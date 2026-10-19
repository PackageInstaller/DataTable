using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.Event;
using ACT.Model;
using ACT.Sound.Management;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoAsideView : BaseUIComponent, IBattleMainComponent
{
	public struct DialogueInfo
	{
		public long id;

		public int icon;

		public int speakerNameId;

		public int content;

		public int endTime;

		public bool disableResumeAfterInterrupt;
	}

	public class AsideData
	{
		public CancellationTokenSource cts;

		public int asideId;

		public int asideType;

		public string eventAddress;

		public int version;

		public int currentDialogueIndex;

		public bool currentDialogueStarted;

		public bool trackStarted;

		public bool finished;

		public long startStamp;

		public List<DialogueInfo> dialogueInfos = new List<DialogueInfo>();
	}

	public MonoDramaAsideUnit dramaAsideDown;

	private bool m_AsideOpen;

	private bool m_Paused;

	private bool m_UiStackPaused;

	private int m_PresentationVersion;

	private AsideData m_AsideData;

	private CancellationTokenSource m_ProcessCts;

	private UniTaskCompletionSource<bool> m_ProcessCompletionSource;

	private CancellationTokenSource m_CurrentDialoguePlaybackCts;

	private uint m_CurrentDialogueVoiceInstanceId;

	private int dialoguePlaybackVersion;

	private bool IsPlaybackPaused
	{
		get
		{
			if (!m_Paused && !m_UiStackPaused)
			{
				return AsideManager.instance.IsPlaybackBlocked;
			}
			return true;
		}
	}

	public bool IsAsideOpen => m_AsideOpen;

	public void Initialize(MonoBattleMainBaseView view)
	{
		m_UiStackPaused = false;
		m_Paused = false;
		m_AsideOpen = false;
		gameObject.SetActive(value: true);
		dramaAsideDown.SetVisible(isVisible: false);
		AsideManager.instance.AttachView(this);
	}

	public void UnInitialize()
	{
		AsideManager.instance.DetachView(this);
		if (m_AsideOpen)
		{
			InterruptCurrentPresentation();
			ReleasePresentationSlot();
		}
		else
		{
			CancelProcess();
			StopCurrentAttempt();
		}
		m_UiStackPaused = false;
		m_Paused = false;
		gameObject.SetActive(value: false);
	}

	public void Pause()
	{
		m_Paused = true;
		if (OwnsCurrentDialogueVoice() && Singleton<DramaVoiceManager>.instance.IsPlaying())
		{
			Singleton<DramaVoiceManager>.instance.PauseVoice(pause: true);
		}
		foreach (AnimationState item in dramaAsideDown.animation)
		{
			item.speed = 0f;
		}
	}

	public void Resume()
	{
		m_Paused = false;
		if (IsPlaybackPaused)
		{
			return;
		}
		if (OwnsCurrentDialogueVoice() && Singleton<DramaVoiceManager>.instance.IsPaused())
		{
			Singleton<DramaVoiceManager>.instance.PauseVoice(pause: false);
		}
		foreach (AnimationState item in dramaAsideDown.animation)
		{
			item.speed = 1f;
		}
	}

	public void Init(AsideData asideData, Action onShowFail)
	{
		if (!AsideManager.instance.TryActivatePresentation(this, asideData))
		{
			onShowFail?.Invoke();
			return;
		}
		try
		{
			m_AsideOpen = true;
			SetAsideViewState(active: true);
			m_UiStackPaused = false;
			m_Paused = false;
			onClose = () =>
			{
				if (Model<BattleMainModel>.HasInstance())
				{
					Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.MiddleBottom);
				}
			};
			ReplaceAside(asideData);
		}
		catch (Exception arg)
		{
			dramaAsideDown.SetVisible(isVisible: false);
			AsideManager.instance.OnPresentationShowFailed(asideData);
			m_AsideOpen = false;
			SetAsideViewState(active: false);
			m_AsideData = null;
			onClose = null;
			onShowFail?.Invoke();
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"小剧场打开失败：{arg}");
			}
		}
	}

	internal void ReplaceAside(AsideData asideData)
	{
		m_AsideData = asideData;
		m_AsideOpen = true;
		dramaAsideDown.SetVisible(isVisible: false);
		RestartProcess(asideData);
	}

	internal void StopCurrentPresentation(AsideData asideData)
	{
		if (m_AsideData == asideData)
		{
			m_PresentationVersion++;
			CancelProcess();
			StopCurrentAttempt();
			dramaAsideDown.SetVisible(isVisible: false);
		}
	}

	internal void StopAndReleasePresentation(AsideData asideData)
	{
		if (m_AsideData == asideData)
		{
			StopCurrentPresentation(asideData);
			ReleasePresentationSlot(asideData);
		}
	}

	internal void InterruptForPlaybackBlock()
	{
		if (m_AsideOpen)
		{
			AsideData asideData = m_AsideData;
			InterruptCurrentPresentation();
			if (asideData != null && !AsideManager.instance.IsCurrentAside(asideData))
			{
				ReleasePresentationSlot(asideData);
			}
		}
	}

	private void RestartProcess(AsideData asideData)
	{
		int version = ++m_PresentationVersion;
		UniTaskCompletionSource<bool> processCompletionSource = m_ProcessCompletionSource;
		CancelProcess();
		RestartProcessAsync(asideData, version, processCompletionSource).Forget();
	}

	private async UniTask RestartProcessAsync(AsideData asideData, int version, UniTaskCompletionSource<bool> previousCompletionSource)
	{
		if (previousCompletionSource != null)
		{
			await previousCompletionSource.Task;
		}
		if (version != m_PresentationVersion || m_AsideData != asideData || !AsideManager.instance.IsCurrentAside(asideData))
		{
			return;
		}
		CancellationTokenSource processCts = CancellationTokenSource.CreateLinkedTokenSource(asideData.cts.Token, destroyCancellationToken);
		UniTaskCompletionSource<bool> completionSource = new UniTaskCompletionSource<bool>();
		m_ProcessCts = processCts;
		m_ProcessCompletionSource = completionSource;
		try
		{
			await ProcessAside(asideData, processCts.Token);
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception message)
		{
			Debug.LogError(message);
			if (AsideManager.instance.IsCurrentAside(asideData))
			{
				AsideManager.instance.OnPresentationShowFailed(asideData);
				ReleasePresentationSlot(asideData);
			}
		}
		finally
		{
			if (m_ProcessCts == processCts)
			{
				m_ProcessCts = null;
			}
			if (m_ProcessCompletionSource == completionSource)
			{
				m_ProcessCompletionSource = null;
			}
			processCts.Dispose();
			completionSource.TrySetResult(result: true);
		}
	}

	private async UniTask ProcessAside(AsideData asideData, CancellationToken token)
	{
		while (!token.IsCancellationRequested && AsideManager.instance.IsCurrentAside(asideData))
		{
			int dialogueIndex = asideData.currentDialogueIndex;
			if (dialogueIndex < 0 || dialogueIndex >= asideData.dialogueInfos.Count)
			{
				ReleasePresentationSlot(asideData);
				break;
			}
			DialogueInfo info = asideData.dialogueInfos[dialogueIndex];
			dramaAsideDown.gameObject.SetActive(value: false);
			if (token.IsCancellationRequested || m_AsideData != asideData || !AsideManager.instance.IsCurrentAside(asideData))
			{
				break;
			}
			while (!token.IsCancellationRequested && asideData.currentDialogueIndex == dialogueIndex)
			{
				await UniTask.WaitUntil(() => !IsPlaybackPaused, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
				if (token.IsCancellationRequested || !AsideManager.instance.IsCurrentAside(asideData))
				{
					return;
				}
				int playbackVersion = dialoguePlaybackVersion;
				bool flag = await PlayDialogue(asideData, dialogueIndex, info, token);
				if (token.IsCancellationRequested || !AsideManager.instance.IsCurrentAside(asideData))
				{
					return;
				}
				if (flag && playbackVersion == dialoguePlaybackVersion && !IsPlaybackPaused && !AsideManager.instance.CompleteDialogue(asideData, dialogueIndex))
				{
					ReleasePresentationSlot(asideData);
					return;
				}
			}
		}
	}

	private async UniTask<bool> PlayDialogue(AsideData asideData, int dialogueIndex, DialogueInfo info, CancellationToken token)
	{
		CancellationTokenSource playbackCts = (m_CurrentDialoguePlaybackCts = CancellationTokenSource.CreateLinkedTokenSource(token));
		CancellationToken playbackToken = playbackCts.Token;
		try
		{
			dramaAsideDown.SetVisible(isVisible: true);
			dramaAsideDown.WriteSpeakerName(info.speakerNameId);
			string text = dramaAsideDown.WriteContent(info.content);
			dramaAsideDown.gameObject.SetActive(value: true);
			dramaAsideDown.ClearAnimQueue();
			dramaAsideDown.animation.Stop();
			dramaAsideDown.PlayAnimation("DialogueShow");
			if (!AsideManager.instance.MarkDialogueStarted(asideData, dialogueIndex) || playbackToken.IsCancellationRequested)
			{
				return false;
			}
			UniTask uniTask = Singleton<DramaVoiceManager>.instance.PlayVoiceEventAsync($"event:/Vo/CN/Dialogue/{info.id}");
			m_CurrentDialogueVoiceInstanceId = Singleton<DramaVoiceManager>.instance.GetCurrentInstanceId();
			UniTask<bool> uniTask2 = UniTask.WaitUntil(() => !dramaAsideDown.isAnimating, PlayerLoopTiming.Update, playbackToken).SuppressCancellationThrow();
			UniTask<bool> uniTask3 = UniTask.Delay(Mathf.Max(text.Length * dramaAsideDown.monoTypeWriterEffect.TimeSpace + 1000, info.endTime * 1000), ignoreTimeScale: false, PlayerLoopTiming.Update, playbackToken).SuppressCancellationThrow();
			UniTask<bool> uniTask4 = UniTask.WaitUntil(() => !dramaAsideDown.isTypeWriting, PlayerLoopTiming.Update, playbackToken).SuppressCancellationThrow();
			await UniTask.WhenAll(uniTask, uniTask2, uniTask3, uniTask4).AttachExternalCancellation(playbackToken).SuppressCancellationThrow();
			if (playbackToken.IsCancellationRequested || token.IsCancellationRequested)
			{
				return false;
			}
			await UniTask.WaitUntil(() => !IsPlaybackPaused, PlayerLoopTiming.Update, playbackToken).SuppressCancellationThrow();
			if (playbackToken.IsCancellationRequested || token.IsCancellationRequested)
			{
				return false;
			}
			dramaAsideDown.ClearAnimQueue();
			dramaAsideDown.PlayAnimation("DialogueHide");
			await UniTask.WaitUntil(() => !IsPlaybackPaused && !dramaAsideDown.isAnimating, PlayerLoopTiming.Update, playbackToken).SuppressCancellationThrow();
			return !playbackToken.IsCancellationRequested && !token.IsCancellationRequested;
		}
		finally
		{
			if (m_CurrentDialoguePlaybackCts == playbackCts)
			{
				m_CurrentDialoguePlaybackCts = null;
				m_CurrentDialogueVoiceInstanceId = 0u;
			}
			playbackCts.Dispose();
		}
	}

	private void InterruptCurrentPresentation()
	{
		AsideData asideData = m_AsideData;
		StopCurrentAttempt();
		dramaAsideDown.SetVisible(isVisible: false);
		if (asideData != null)
		{
			AsideManager.instance.InterruptPresentation(asideData);
		}
	}

	private void StopCurrentAttempt()
	{
		dialoguePlaybackVersion++;
		CancellationTokenSource currentDialoguePlaybackCts = m_CurrentDialoguePlaybackCts;
		if (currentDialoguePlaybackCts != null)
		{
			if (OwnsCurrentDialogueVoice())
			{
				Singleton<DramaVoiceManager>.instance.Release();
			}
			m_CurrentDialogueVoiceInstanceId = 0u;
			if (!currentDialoguePlaybackCts.IsCancellationRequested)
			{
				currentDialoguePlaybackCts.Cancel();
			}
		}
		dramaAsideDown.animation.Stop();
		dramaAsideDown.ClearAnimQueue();
	}

	private void CancelProcess()
	{
		if (m_ProcessCts != null && !m_ProcessCts.IsCancellationRequested)
		{
			m_ProcessCts.Cancel();
		}
	}

	private bool OwnsCurrentDialogueVoice()
	{
		if (m_CurrentDialogueVoiceInstanceId != 0)
		{
			return Singleton<DramaVoiceManager>.instance.GetCurrentInstanceId() == m_CurrentDialogueVoiceInstanceId;
		}
		return false;
	}

	private void ReleasePresentationSlot(AsideData expectedAsideData = null)
	{
		if (!m_AsideOpen || (expectedAsideData != null && m_AsideData != expectedAsideData))
		{
			return;
		}
		AsideData asideData = m_AsideData;
		Action action = onClose;
		m_AsideOpen = false;
		m_AsideData = null;
		onClose = null;
		m_PresentationVersion++;
		CancelProcess();
		StopCurrentAttempt();
		dramaAsideDown.SetVisible(isVisible: false);
		try
		{
			action?.Invoke();
		}
		finally
		{
			AsideManager.instance.OnPresentationReleased(this, asideData);
			if (!m_AsideOpen)
			{
				SetAsideViewState(active: false);
			}
		}
	}

	private void SetAsideViewState(bool active)
	{
		GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
		evt.IsInState = active;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAsideViewStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void PauseForUiStack()
	{
		m_UiStackPaused = true;
		InterruptForPlaybackBlock();
	}

	private void ResumeFromUiStack()
	{
		m_UiStackPaused = false;
		if (IsPlaybackPaused)
		{
			return;
		}
		foreach (AnimationState item in dramaAsideDown.animation)
		{
			item.speed = 1f;
		}
	}

	[Obsolete]
	public void OpenComponent()
	{
	}

	[Obsolete]
	public void CloseComponent()
	{
	}

	public void PushStack()
	{
		PauseForUiStack();
	}

	public void PopStack()
	{
		ResumeFromUiStack();
	}

	protected override void OnUnityDestroy()
	{
		AsideManager.instance.DetachView(this);
		if (m_AsideOpen)
		{
			InterruptCurrentPresentation();
			ReleasePresentationSlot();
		}
		base.OnUnityDestroy();
	}
}
