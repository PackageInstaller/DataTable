using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Drama;

public class AsideManager
{
	private enum AsideEndReason
	{
		Completed,
		Replaced,
		ResumeDisabled,
		SceneChanged,
		ShowFailed
	}

	private enum PresentationState
	{
		None,
		Queued,
		Active
	}

	private static AsideManager _instance;

	private MonoAsideView.AsideData m_CurrentAside;

	private MonoAsideView m_AsideView;

	private PresentationState m_PresentationState;

	private SceneStatus m_CurrentSceneStatus;

	private bool m_HasSceneStatus;

	private bool m_AsideDisplayActive;

	private int m_SessionVersion;

	private readonly Queue<MonoAsideView.AsideData> m_PendingAsides = new Queue<MonoAsideView.AsideData>();

	private readonly HashSet<object> playbackBlockOwners = new HashSet<object>();

	public static AsideManager instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new AsideManager();
			}
			return _instance;
		}
	}

	public bool asideIsActive => m_AsideDisplayActive;

	internal bool IsPlaybackBlocked => playbackBlockOwners.Count > 0;

	private AsideManager()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeLeaveWorld, OnBeforeLeaveWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change, OnSceneChanged);
	}

	private int GetIconId(int characterId)
	{
		if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(characterId, out var value) && value.id == 10001)
		{
			switch ((Sex)G.detailUserInfo.Brief.Gender)
			{
			case Sex.MALE:
				return 10002;
			case Sex.FEMALE:
				return 10001;
			}
		}
		return characterId;
	}

	private int GetSpeakerNameId(int characterId)
	{
		if (!RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(characterId, out var value))
		{
			return 0;
		}
		return value.nameLocal;
	}

	private bool TryBuildAsideData(int asideId, int sessionVersion, out MonoAsideView.AsideData viewAsideData)
	{
		viewAsideData = null;
		if (!RuntimeConfigs.data.dialogueAsideGroupDatas.TryGetValue(asideId, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("dialogueAsideGroup表没配" + asideId + "!!!!!!!!!!!");
			}
			return false;
		}
		viewAsideData = new MonoAsideView.AsideData
		{
			cts = new CancellationTokenSource(),
			asideId = asideId,
			asideType = value.type,
			eventAddress = value.eventAddress,
			version = sessionVersion
		};
		long[] content = value.content;
		foreach (long num in content)
		{
			if (!RuntimeConfigs.data.dialogueAsideDatas.TryGetValue(num, out var value2))
			{
				viewAsideData.cts.Dispose();
				viewAsideData = null;
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"Aside组配置了不存在的对话：{asideId} - {num}");
				}
				return false;
			}
			viewAsideData.dialogueInfos.Add(new MonoAsideView.DialogueInfo
			{
				id = num,
				icon = GetIconId(value2.speakerId),
				speakerNameId = GetSpeakerNameId(value2.speakerId),
				content = value2.content,
				disableResumeAfterInterrupt = value2.disableResumeAfterInterrupt
			});
		}
		if (viewAsideData.dialogueInfos.Count == 0)
		{
			viewAsideData.cts.Dispose();
			viewAsideData = null;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Aside组未配置对话内容：{asideId}");
			}
			return false;
		}
		return true;
	}

	public void BeginAside(int asideId)
	{
		BeginAsideBatch(new int[1] { asideId });
	}

	internal void BeginAsideBatch(IReadOnlyList<int> asideIds)
	{
		if (asideIds == null || asideIds.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Aside批次未配置内容");
			}
			return;
		}
		EnsureSceneStatus();
		int sessionVersion = m_SessionVersion + 1;
		List<MonoAsideView.AsideData> list = new List<MonoAsideView.AsideData>(asideIds.Count);
		for (int i = 0; i < asideIds.Count; i++)
		{
			if (TryBuildAsideData(asideIds[i], sessionVersion, out var viewAsideData))
			{
				list.Add(viewAsideData);
			}
		}
		if (list.Count != 0)
		{
			m_SessionVersion = sessionVersion;
			ReplaceCurrentAsideBatch(list, sessionVersion);
		}
	}

	internal void PushPlaybackBlock(object owner)
	{
		if (playbackBlockOwners.Add(owner) && playbackBlockOwners.Count == 1 && (bool)m_AsideView)
		{
			m_AsideView.InterruptForPlaybackBlock();
		}
	}

	internal void PopPlaybackBlock(object owner)
	{
		if (playbackBlockOwners.Remove(owner) && !IsPlaybackBlocked)
		{
			QueueCurrentAsideIfNeeded();
		}
	}

	internal void AttachView(MonoAsideView asideView)
	{
		m_AsideView = asideView;
		EnsureSceneStatus();
		QueueCurrentAsideIfNeeded();
	}

	internal void DetachView(MonoAsideView asideView)
	{
		if (!(m_AsideView != asideView))
		{
			if (m_PresentationState == PresentationState.Queued && m_CurrentAside != null)
			{
				RemovePendingPresentation(m_CurrentAside);
			}
			m_AsideView = null;
		}
	}

	internal bool TryActivatePresentation(MonoAsideView asideView, MonoAsideView.AsideData asideData)
	{
		if (m_PresentationState != PresentationState.Queued || asideData == null || asideData != m_CurrentAside || asideData.cts.IsCancellationRequested)
		{
			return false;
		}
		m_AsideView = asideView;
		m_PresentationState = PresentationState.Active;
		return true;
	}

	internal void OnPresentationShowFailed(MonoAsideView.AsideData asideData)
	{
		if (asideData == m_CurrentAside)
		{
			m_PresentationState = PresentationState.None;
			FinishCurrentBatch(AsideEndReason.ShowFailed);
		}
	}

	internal void OnPresentationReleased(MonoAsideView asideView, MonoAsideView.AsideData asideData)
	{
		if (m_PresentationState == PresentationState.Active && (m_AsideView == asideView || !m_AsideView) && (m_CurrentAside == asideData || m_CurrentAside == null))
		{
			m_PresentationState = PresentationState.None;
		}
		QueueCurrentAsideIfNeeded();
	}

	internal bool IsCurrentAside(MonoAsideView.AsideData asideData)
	{
		if (asideData != null && asideData == m_CurrentAside && asideData.version == m_SessionVersion)
		{
			return !asideData.cts.IsCancellationRequested;
		}
		return false;
	}

	internal bool MarkDialogueStarted(MonoAsideView.AsideData asideData, int dialogueIndex)
	{
		if (IsPlaybackBlocked || !IsCurrentDialogue(asideData, dialogueIndex))
		{
			return false;
		}
		asideData.currentDialogueStarted = true;
		StartTrackIfNeeded(asideData);
		if (IsPlaybackBlocked || !IsCurrentDialogue(asideData, dialogueIndex))
		{
			return false;
		}
		SetAsideDisplayState(active: true);
		if (!IsPlaybackBlocked)
		{
			return IsCurrentDialogue(asideData, dialogueIndex);
		}
		return false;
	}

	internal bool CompleteDialogue(MonoAsideView.AsideData asideData, int dialogueIndex)
	{
		if (IsPlaybackBlocked || !IsCurrentDialogue(asideData, dialogueIndex))
		{
			return false;
		}
		asideData.currentDialogueStarted = false;
		SetAsideDisplayState(active: false);
		if (!IsCurrentDialogue(asideData, dialogueIndex))
		{
			return false;
		}
		if (IsPlaybackBlocked)
		{
			return true;
		}
		asideData.currentDialogueIndex++;
		if (asideData.currentDialogueIndex < asideData.dialogueInfos.Count)
		{
			return true;
		}
		FinishAside(asideData, AsideEndReason.Completed);
		if (m_CurrentAside != asideData || asideData.version != m_SessionVersion)
		{
			return false;
		}
		if (TryPlayNextAside(asideData.version))
		{
			return false;
		}
		m_CurrentAside = null;
		return false;
	}

	internal bool InterruptPresentation(MonoAsideView.AsideData asideData)
	{
		if (!IsCurrentAside(asideData))
		{
			return false;
		}
		SetAsideDisplayState(active: false);
		if (!IsCurrentAside(asideData))
		{
			return false;
		}
		if (!asideData.currentDialogueStarted)
		{
			return true;
		}
		int currentDialogueIndex = asideData.currentDialogueIndex;
		if (currentDialogueIndex < 0 || currentDialogueIndex >= asideData.dialogueInfos.Count || !asideData.dialogueInfos[currentDialogueIndex].disableResumeAfterInterrupt)
		{
			return true;
		}
		FinishCurrentBatch(AsideEndReason.ResumeDisabled);
		return false;
	}

	private bool IsCurrentDialogue(MonoAsideView.AsideData asideData, int dialogueIndex)
	{
		if (IsCurrentAside(asideData))
		{
			return asideData.currentDialogueIndex == dialogueIndex;
		}
		return false;
	}

	private void ReplaceCurrentAsideBatch(IReadOnlyList<MonoAsideView.AsideData> newAsideDataList, int sessionVersion)
	{
		MonoAsideView.AsideData currentAside = m_CurrentAside;
		List<MonoAsideView.AsideData> asideDataList = DrainPendingAsides();
		bool flag = m_PresentationState == PresentationState.Active && (bool)m_AsideView;
		if (currentAside != null)
		{
			if (flag)
			{
				m_AsideView.StopCurrentPresentation(currentAside);
			}
			else if (m_PresentationState == PresentationState.Queued)
			{
				RemovePendingPresentation(currentAside);
			}
			FinishAside(currentAside, AsideEndReason.Replaced);
		}
		FinishAsideList(asideDataList, AsideEndReason.Replaced);
		if (sessionVersion != m_SessionVersion)
		{
			FinishAsideList(newAsideDataList, AsideEndReason.Replaced);
			return;
		}
		m_CurrentAside = newAsideDataList[0];
		for (int i = 1; i < newAsideDataList.Count; i++)
		{
			m_PendingAsides.Enqueue(newAsideDataList[i]);
		}
		if (flag)
		{
			m_AsideView.ReplaceAside(m_CurrentAside);
			return;
		}
		m_PresentationState = PresentationState.None;
		QueueCurrentAsideIfNeeded();
	}

	private bool TryPlayNextAside(int sessionVersion)
	{
		if (sessionVersion != m_SessionVersion)
		{
			return false;
		}
		while (m_PendingAsides.Count > 0)
		{
			MonoAsideView.AsideData asideData = m_PendingAsides.Dequeue();
			if (asideData.version != sessionVersion || asideData.finished || asideData.cts.IsCancellationRequested)
			{
				FinishAside(asideData, AsideEndReason.Replaced);
				continue;
			}
			m_CurrentAside = asideData;
			if (m_PresentationState == PresentationState.Active && (bool)m_AsideView)
			{
				m_AsideView.ReplaceAside(asideData);
				return true;
			}
			m_PresentationState = PresentationState.None;
			QueueCurrentAsideIfNeeded();
			return true;
		}
		return false;
	}

	private void FinishCurrentBatch(AsideEndReason reason)
	{
		MonoAsideView.AsideData currentAside = m_CurrentAside;
		List<MonoAsideView.AsideData> asideDataList = DrainPendingAsides();
		FinishAside(currentAside, reason);
		FinishAsideList(asideDataList, reason);
		if (m_CurrentAside == currentAside)
		{
			m_CurrentAside = null;
		}
	}

	private List<MonoAsideView.AsideData> DrainPendingAsides()
	{
		List<MonoAsideView.AsideData> list = new List<MonoAsideView.AsideData>(m_PendingAsides.Count);
		while (m_PendingAsides.Count > 0)
		{
			list.Add(m_PendingAsides.Dequeue());
		}
		return list;
	}

	private void FinishAsideList(IReadOnlyList<MonoAsideView.AsideData> asideDataList, AsideEndReason reason)
	{
		for (int i = 0; i < asideDataList.Count; i++)
		{
			FinishAside(asideDataList[i], reason);
		}
	}

	private void QueueCurrentAsideIfNeeded()
	{
		if (!IsPlaybackBlocked && m_CurrentAside != null && m_PresentationState == PresentationState.None && (bool)m_AsideView && Model<BattleMainModel>.HasInstance() && Model<BattleMainModel>.Interface.HudCpQueueManager != null)
		{
			m_PresentationState = PresentationState.Queued;
			OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
			evt.position = UIPosition.MiddleBottom;
			evt.type = HudComponentType.Aside;
			evt.priorityInQueue = 1;
			evt.uiData = m_CurrentAside;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void RemovePendingPresentation(MonoAsideView.AsideData asideData)
	{
		if (Model<BattleMainModel>.HasInstance() && Model<BattleMainModel>.Interface.HudCpQueueManager != null)
		{
			Model<BattleMainModel>.Interface.HudCpQueueManager.RemovePendingQueueItem(UIPosition.MiddleBottom, HudComponentType.Aside, asideData);
		}
		m_PresentationState = PresentationState.None;
	}

	private void StartTrackIfNeeded(MonoAsideView.AsideData asideData)
	{
		if (asideData.trackStarted)
		{
			return;
		}
		EventTrackSolver eventTrackSolver = EventTrackSolver.Instance;
		if ((bool)eventTrackSolver)
		{
			TrackDramaEvt evt = eventTrackSolver.GetEvt<TrackDramaEvt>();
			if (evt != null)
			{
				asideData.trackStarted = true;
				asideData.startStamp = TimeManager.LocalTime.NowTimestamp;
				evt.conversationId = asideData.asideId;
				evt.subId = 0L;
				evt.type = 7;
				evt.status = 1;
				evt.conversationDuration = 0.0;
				evt.isSkip = false;
				eventTrackSolver.Dispatch(evt);
			}
		}
	}

	private void FinishAside(MonoAsideView.AsideData asideData, AsideEndReason reason)
	{
		if (asideData == null || asideData.finished)
		{
			return;
		}
		asideData.finished = true;
		SetAsideDisplayState(active: false);
		try
		{
			if (asideData.trackStarted)
			{
				EventTrackSolver eventTrackSolver = EventTrackSolver.Instance;
				if ((bool)eventTrackSolver)
				{
					TrackDramaEvt evt = eventTrackSolver.GetEvt<TrackDramaEvt>();
					if (evt != null)
					{
						evt.conversationId = asideData.asideId;
						evt.subId = 0L;
						evt.type = 7;
						evt.status = 2;
						evt.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - asideData.startStamp).TotalSeconds;
						evt.isSkip = reason != AsideEndReason.Completed;
						eventTrackSolver.Dispatch(evt);
					}
				}
			}
			if (reason == AsideEndReason.Completed)
			{
				Singleton<ConversationManager>.instance.SetKeyPoint(asideData.asideId);
				Singleton<ConversationManager>.instance.SendKeyPoints();
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		finally
		{
			asideData.cts.Cancel();
			asideData.cts.Dispose();
		}
	}

	private void SetAsideDisplayState(bool active)
	{
		if (m_AsideDisplayActive != active)
		{
			m_AsideDisplayActive = active;
			GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
			evt.IsInState = active;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAsideStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void EnsureSceneStatus()
	{
		if (!m_HasSceneStatus)
		{
			m_CurrentSceneStatus = MonoECS.instance.sceneStatus;
			m_HasSceneStatus = true;
		}
	}

	private void OnBeforeLeaveWorld(BaseEventContent content)
	{
		ClearCurrentAsideForSceneChange();
	}

	private void OnSceneChanged(BaseEventContent content)
	{
		if (content is SceneChangeEvt sceneChangeEvt)
		{
			if (!m_HasSceneStatus)
			{
				m_CurrentSceneStatus = sceneChangeEvt.newScene;
				m_HasSceneStatus = true;
			}
			else if (m_CurrentSceneStatus != sceneChangeEvt.newScene)
			{
				m_CurrentSceneStatus = sceneChangeEvt.newScene;
				ClearCurrentAsideForSceneChange();
			}
		}
	}

	private void ClearCurrentAsideForSceneChange()
	{
		MonoAsideView.AsideData currentAside = m_CurrentAside;
		if (currentAside != null || m_PendingAsides.Count != 0)
		{
			int num = ++m_SessionVersion;
			List<MonoAsideView.AsideData> asideDataList = DrainPendingAsides();
			m_CurrentAside = null;
			if (m_PresentationState == PresentationState.Active && (bool)m_AsideView)
			{
				m_AsideView.StopAndReleasePresentation(currentAside);
			}
			else if (m_PresentationState == PresentationState.Queued)
			{
				RemovePendingPresentation(currentAside);
			}
			FinishAside(currentAside, AsideEndReason.SceneChanged);
			FinishAsideList(asideDataList, AsideEndReason.SceneChanged);
			if (m_SessionVersion == num && m_CurrentAside == null)
			{
				m_PresentationState = PresentationState.None;
			}
		}
	}
}
