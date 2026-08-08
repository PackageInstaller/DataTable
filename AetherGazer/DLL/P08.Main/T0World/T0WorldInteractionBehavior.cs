using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

public class T0WorldInteractionBehavior : T0WorldBehavior
{
	private Dictionary<string, T0InterationAnimationData> hideTimelineTeleportDic;

	[SerializeField]
	private Animator m_animator;

	public QWNPCMoveComponent moveComponent;

	[SerializeField]
	private HeroUITimelineBrain m_brain;

	public PlayableDirector executePlayable;

	private Vector3 _lastPosition = Vector3.zero;

	public float executePlayableStartTime;

	private LRUCache<string, GameObject> m_playableDirectorGos = new LRUCache<string, GameObject>(5);

	private const string TIMELINE_ASSET_PATH = "T0World/UITimeLine/{0}/{1}";

	private Action holdEndAction;

	public CancellationTokenSource cancel;

	public Animator animator => m_animator;

	public HeroUITimelineBrain brain => m_brain;

	public void CloseExcutePlayable()
	{
		if ((bool)executePlayable)
		{
			executePlayable.Stop();
			executePlayable.gameObject.SetActive(value: false);
		}
		executePlayable = null;
	}

	public void OnAnimatorMove()
	{
		Vector3 deltaPosition = animator.deltaPosition;
		Vector3 vector = deltaPosition - _lastPosition;
		_lastPosition = deltaPosition;
		if (!(vector.magnitude > 0.1f))
		{
			base.transform.position += vector;
		}
	}

	private void AddTimelineTeleportDic(T0InterationAnimationData animationData)
	{
		if (animationData.teleport_type == T0WorldTeleportType.End)
		{
			if (hideTimelineTeleportDic == null)
			{
				hideTimelineTeleportDic = new Dictionary<string, T0InterationAnimationData>();
			}
			if (!hideTimelineTeleportDic.ContainsKey(animationData.animName))
			{
				hideTimelineTeleportDic.Add(animationData.animName, animationData);
			}
		}
	}

	public int GetCharacterID()
	{
		int result = 0;
		if (base.mAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			result = (base.mAgent as T0CharacterAgent).CharacterBoard.characterID;
		}
		return result;
	}

	public bool CheckIsPlayingTargetTimeline(string timeLineName)
	{
		if ((bool)executePlayable && executePlayable.name == timeLineName)
		{
			return true;
		}
		return false;
	}

	private void CheckRegisterTimelineCamera(T0InterationAnimationData animationData, GameObject timelineGo)
	{
		if (!(T0WorldScene.Scene.mWorldUI == null) && animationData.animatorType == T0WorldAnimationType.Timeline && T0WorldScene.Scene.mWorldUI.NowState == T0ControlerStateEnum.half_lock)
		{
			CinemachineVirtualCamera componentInChildren = timelineGo.transform.GetComponentInChildren<CinemachineVirtualCamera>();
			if (componentInChildren != null)
			{
				T0WorldScene.Scene.player.SetHalfLockData(componentInChildren);
			}
		}
	}

	private void SetCharacterIkLook(GameObject timelineGo)
	{
		if (T0WorldScene.Scene.mWorldUI == null || !(base.mAgent is T0CharacterAgent))
		{
			return;
		}
		T0ControlerStateEnum nowState = T0WorldScene.Scene.mWorldUI.NowState;
		T0CharacterIkBehavior ikBehavior = (base.mAgent as T0CharacterAgent).CharacterBoard.ikBehavior;
		if (ikBehavior == null || ikBehavior.IsCloseState)
		{
			return;
		}
		if (nowState == T0ControlerStateEnum.normal)
		{
			ikBehavior.SetIkLookTarget(T0WorldScene.Scene.player.slowFollowNode);
			return;
		}
		CinemachineVirtualCamera componentInChildren = timelineGo.transform.GetComponentInChildren<CinemachineVirtualCamera>();
		if (componentInChildren != null)
		{
			ikBehavior.SetIkLookTarget(componentInChildren.transform);
		}
	}

	public void PlayTimeline(T0InterationAnimationData animationData)
	{
		PlayableDirector playable;
		GameObject timelineGo;
		if (animationData.customAnimAssetPath)
		{
			PlayTimelineWithAssetPath(animationData.animName, out playable, out timelineGo, animationData.extrapolationMode);
		}
		else
		{
			PlayTimeline(animationData.animName, out playable, out timelineGo, animationData.extrapolationMode);
		}
		playable.played += delegate
		{
		};
		playable.stopped += delegate
		{
			animationData.IsFinish = true;
		};
		if (animationData.extrapolationMode == DirectorWrapMode.Hold)
		{
			SetHoldEndAction(delegate
			{
				animationData.IsFinish = true;
			});
		}
		CheckRegisterTimelineCamera(animationData, timelineGo);
		SetCharacterIkLook(timelineGo);
		if (animationData.teleport_type == T0WorldTeleportType.Begin)
		{
			if (Vector3.Distance(animationData.teleportPos, Vector3.zero) > 0.1f)
			{
				base.transform.position = animationData.teleportPos;
			}
			base.transform.localEulerAngles = animationData.teleportAngle;
		}
		else if (animationData.teleport_type == T0WorldTeleportType.End)
		{
			AddTimelineTeleportDic(animationData);
		}
	}

	public static string GetTimelineAssetByRoleIDAndName(int roleID, string timelineName)
	{
		return $"T0World/UITimeLine/{roleID}/{timelineName}";
	}

	public GameObject GetTimelineGo(int roleID, string timeLineName, out string assetPath)
	{
		assetPath = GetTimelineAssetByRoleIDAndName(roleID, timeLineName);
		return GetTimelineGo(assetPath);
	}

	public bool GetTimelineGo(string assetPath, out GameObject timelineGo)
	{
		if (m_playableDirectorGos.Get(assetPath, out timelineGo) && (bool)timelineGo)
		{
			return false;
		}
		GameObject gameObject = Asset.Load<GameObject>(assetPath);
		timelineGo = UnityEngine.Object.Instantiate(gameObject);
		timelineGo.name = gameObject.name;
		timelineGo.transform.SetParent(base.transform);
		timelineGo.transform.localPosition = Vector3.zero;
		timelineGo.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
		timelineGo.transform.localScale = Vector3.one;
		string text = m_playableDirectorGos.Put(assetPath, timelineGo, out var removed);
		if (assetPath != text)
		{
			UnloadTimelineGo_Internal(text, removed);
		}
		return true;
	}

	public GameObject GetTimelineGo(string assetPath)
	{
		GetTimelineGo(assetPath, out var timelineGo);
		return timelineGo;
	}

	public void UnloadTimelineGo(int roleID, string timelineName)
	{
		UnloadTimelineGo(GetTimelineAssetByRoleIDAndName(roleID, timelineName));
	}

	public void UnloadTimelineGo(string assetPath)
	{
		if (m_playableDirectorGos != null && m_playableDirectorGos.Remove(assetPath, out var value))
		{
			UnloadTimelineGo_Internal(assetPath, value);
		}
	}

	internal void UnloadTimelineGo_Internal(string assetPath, GameObject cachedTimelineObj)
	{
		if ((bool)cachedTimelineObj)
		{
			UnityEngine.Object.DestroyImmediate(cachedTimelineObj);
		}
		Asset.Unload(assetPath);
	}

	public void PlayTimeline(string animName, out PlayableDirector playable, out GameObject timelineGo, DirectorWrapMode extrapolationMode = DirectorWrapMode.None)
	{
		timelineGo = null;
		if (CheckIsPlayingTargetTimeline(animName))
		{
			playable = executePlayable;
			return;
		}
		if ((bool)executePlayable)
		{
			CloseExcutePlayable();
		}
		string timelineAssetByRoleIDAndName = GetTimelineAssetByRoleIDAndName(GetCharacterID(), animName);
		GetTimelineGo(timelineAssetByRoleIDAndName, out timelineGo);
		timelineGo.SetActive(value: true);
		playable = timelineGo.GetComponent<PlayableDirector>();
		playable.extrapolationMode = extrapolationMode;
		if ((bool)brain)
		{
			brain.BindPlayableDirector(playable);
			brain.RebuildPlayableDirector(playable);
			PlayableDirector[] componentsInChildren = timelineGo.transform.GetComponentsInChildren<PlayableDirector>();
			foreach (PlayableDirector playableDirector in componentsInChildren)
			{
				if (playableDirector != playable)
				{
					brain.BindPlayableDirector(playableDirector);
				}
			}
		}
		playable.Play();
		playable.Evaluate();
		executePlayable = playable;
		executePlayableStartTime = Time.time;
	}

	public void PlayTimelineWithAssetPath(string assetPath, out PlayableDirector playable, out GameObject timelineGo, DirectorWrapMode extrapolationMode = DirectorWrapMode.None)
	{
		GetTimelineGo(assetPath, out timelineGo);
		string timeLineName = timelineGo.name;
		if (CheckIsPlayingTargetTimeline(timeLineName))
		{
			playable = executePlayable;
			return;
		}
		if ((bool)executePlayable)
		{
			CloseExcutePlayable();
		}
		timelineGo.SetActive(value: true);
		playable = timelineGo.GetComponent<PlayableDirector>();
		playable.extrapolationMode = extrapolationMode;
		if ((bool)brain)
		{
			brain.BindPlayableDirector(playable);
			brain.RebuildPlayableDirector(playable);
			PlayableDirector[] componentsInChildren = timelineGo.transform.GetComponentsInChildren<PlayableDirector>();
			foreach (PlayableDirector playableDirector in componentsInChildren)
			{
				if (playableDirector != playable)
				{
					brain.BindPlayableDirector(playableDirector);
				}
			}
		}
		playable.Play();
		playable.Evaluate();
		executePlayable = playable;
		executePlayableStartTime = Time.time;
	}

	public void StopAllTimeline()
	{
		if (m_playableDirectorGos != null)
		{
			foreach (GameObject value in m_playableDirectorGos.Values)
			{
				value.GetComponent<PlayableDirector>().Stop();
				value.SetActive(value: false);
			}
		}
		CloseExcutePlayable();
	}

	public void PlayAnimation(string animName)
	{
		StopAllTimeline();
		if (animator != null)
		{
			animator.enabled = true;
			animator.Rebind();
			animator.Play(animName, -1, 0f);
			animator.Update(0f);
		}
		animator.transform.parent.localPosition = Vector3.zero;
	}

	public void SetHoldEndAction(Action action)
	{
		holdEndAction = action;
	}

	public void TriggerHoldPlayable()
	{
		if (!(executePlayable == null) && executePlayable.extrapolationMode == DirectorWrapMode.Hold)
		{
			holdEndAction?.Invoke();
			holdEndAction = null;
		}
	}

	public override void Initialize()
	{
		base.Initialize();
		cancel = new CancellationTokenSource();
		if (base.mAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			m_brain = base.transform.GetComponent<HeroUITimelineBrain>();
			if (m_brain == null)
			{
				m_brain = base.transform.gameObject.AddComponent<HeroUITimelineBrain>();
			}
			if (moveComponent != null)
			{
				moveComponent.animatorMoveDelgate = OnAnimatorMove;
			}
		}
	}

	public override void FixedUpdateBehavior()
	{
		base.FixedUpdateBehavior();
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		List<T0InterationBaseData> interationEventList = base.mAgent.Blackboard.EventContext.interationEventList;
		if (interationEventList == null || interationEventList.Count <= 0)
		{
			return;
		}
		T0InterationBaseData t0InterationBaseData = null;
		foreach (T0InterationBaseData item in interationEventList)
		{
			if (!item.IsInit)
			{
				item.OnStart(this);
			}
			if (!item.IsFinish)
			{
				item.OnUpdate(this);
			}
			if (item.IsFinish && !item.IsDispose)
			{
				t0InterationBaseData = item;
			}
		}
		t0InterationBaseData?.OnFinish(this);
	}

	public override void LateUpdateBehavior()
	{
		base.LateUpdateBehavior();
	}

	public override void DestroyBehavior()
	{
		if (m_playableDirectorGos != null)
		{
			while (m_playableDirectorGos.Count > 0)
			{
				GameObject cachedTimelineObj = m_playableDirectorGos.RemoveLast(out var rmvKey);
				UnloadTimelineGo_Internal(rmvKey, cachedTimelineObj);
			}
			m_playableDirectorGos = null;
		}
		if (hideTimelineTeleportDic != null)
		{
			hideTimelineTeleportDic.Clear();
			hideTimelineTeleportDic = null;
		}
		cancel.Cancel();
		base.DestroyBehavior();
	}

	public override void OnLowMemory()
	{
		CinemachineBlend activeBlend = T0WorldScene.Scene.chineBrain.ActiveBlend;
		List<KeyValuePair<string, GameObject>> list = new List<KeyValuePair<string, GameObject>>(m_playableDirectorGos.Entries);
		int num = 0;
		foreach (KeyValuePair<string, GameObject> item in list)
		{
			item.Deconstruct(out var key, out var value);
			string text = key;
			GameObject gameObject = value;
			if (CheckTimelineGoUseless(gameObject, activeBlend))
			{
				m_playableDirectorGos.Remove(text, out value);
				UnloadTimelineGo_Internal(text, gameObject);
				num++;
			}
		}
		Debug.LogWarning($"T0 Low Memory - InteractionBehaviour({this}) unload {num} timeline obj", this);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool IsSubTrsOf(Transform a, Transform b)
	{
		while (a != b)
		{
			if (a == null)
			{
				return false;
			}
			a = a.parent;
		}
		return true;
	}

	private bool CheckTimelineGoUseless(GameObject timelineGo, CinemachineBlend curBlend)
	{
		if (timelineGo.activeSelf)
		{
			return false;
		}
		if (curBlend != null)
		{
			if (curBlend.CamA is Component component && IsSubTrsOf(component.transform, timelineGo.transform))
			{
				return false;
			}
			if (curBlend.CamB is Component component2 && IsSubTrsOf(component2.transform, timelineGo.transform))
			{
				return false;
			}
		}
		return true;
	}

	public void ChangeAIState(T0WorldAIControlStateEnum aiState)
	{
		if (base.mAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			switch (aiState)
			{
			case T0WorldAIControlStateEnum.none:
				break;
			case T0WorldAIControlStateEnum.open:
				OpenAI();
				break;
			default:
				CloseAI();
				break;
			}
		}
	}

	private void CloseAI()
	{
		if (base.mAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			(base.mAgent as T0CharacterAgent)?.CharacterBoard.CloseAI();
		}
	}

	private void OpenAI()
	{
		if (base.mAgent.GetAgentLayer() == T0AgentLayer.Character)
		{
			(base.mAgent as T0CharacterAgent)?.CharacterBoard.OpenAI();
		}
	}
}
