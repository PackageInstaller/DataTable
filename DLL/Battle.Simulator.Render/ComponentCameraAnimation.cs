using System;
using System.Collections.Generic;
using Cinemachine;
using Cinemachine.Utility;
using Config;
using UnityEngine;

public class ComponentCameraAnimation : CMonoBehaviour
{
	public const int DEFINE_CLOSE_UP_SQR_DISTANCE = 25;

	private BBHumanoid m_Character;

	private CharacterEffect characterEffect;

	public bool m_hide;

	private bool isNeedLock;

	private bool delay;

	private int count;

	private CinemachineBrain brain;

	private Camera mainCamera;

	public Dictionary<string, NoiseSettings> keyValuePairs = new Dictionary<string, NoiseSettings>();

	private List<CinemachineBasicMultiChannelPerlin> multiChannelPerlins = new List<CinemachineBasicMultiChannelPerlin>();

	private List<TimelineCameraClip> cameraShakeLeftTime = new List<TimelineCameraClip>();

	public LockTargetCinemachine LockTargetCinemachine { get; set; }

	public CameraParamComponent virtualCameraParam { get; set; }

	public override void Initialize()
	{
		base.Initialize();
		m_Character = mAgent.Blackboard as BBHumanoid;
		BBCommom blackboard = mAgent.Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(HandleAction));
		if (characterEffect == null)
		{
			characterEffect = base.gameObject.GetComponent<CharacterEffect>();
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (m_Character.mAgent.IsLocalPlayer && battleScene != null)
		{
			virtualCameraParam = battleScene.virtualCameraParam;
			if (virtualCameraParam != null)
			{
				LockTargetCinemachine = virtualCameraParam.lockTargetCinemachine;
			}
		}
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<PlayerChangeEvent>(OnPlayerChange);
		multiChannelPerlins.Clear();
		cameraShakeLeftTime.Clear();
	}

	private void OnPlayerChange(PlayerChangeEvent eventReceived)
	{
		if (m_Character != null && m_Character.mAgent.AgentID == eventReceived.mFromEntity)
		{
			LockTargetCinemachine = null;
			virtualCameraParam = null;
		}
		if (!(m_Character != null) || m_Character.mAgent.AgentID != eventReceived.mToEntity)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			virtualCameraParam = battleScene.virtualCameraParam;
			if (virtualCameraParam != null)
			{
				LockTargetCinemachine = virtualCameraParam.lockTargetCinemachine;
			}
		}
	}

	private void HandleAction(AgentAction action)
	{
		if (!(action is AgentActionAbilityEnter))
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.GetAgentManager() == null)
		{
			return;
		}
		RunTimeTimelineAndHitCache timelineAndHitCache = battleScene.GetTimelineAndHitCache();
		if (timelineAndHitCache != null)
		{
			TimelineInfo timelineInfo = timelineAndHitCache.Get(m_Character.m_NextSimFrameData.mAbilityID);
			if (timelineInfo == null)
			{
				Debug.LogError("can't find timeline:" + m_Character.m_NextSimFrameData.mAbilityID);
			}
			else
			{
				delay = timelineInfo.IsNeedCameraLock;
			}
		}
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		if (delay)
		{
			count++;
			if (count >= 3)
			{
				isNeedLock = true;
				delay = false;
				count = 0;
			}
		}
		if (!(characterEffect != null))
		{
			return;
		}
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		if (brain == null)
		{
			brain = mainCamera.transform.GetComponent<CinemachineBrain>();
		}
		if (!(brain != null))
		{
			return;
		}
		Transform transform = brain.ActiveVirtualCamera.LookAt;
		if (transform != null)
		{
			if (transform.name == "lookat" && brain.ActiveVirtualCamera.Follow != null)
			{
				transform = brain.ActiveVirtualCamera.Follow;
			}
			if ((int)Vector3.SqrMagnitude(transform.position - mainCamera.transform.position) < 25)
			{
				DitherAlphaCloseUpShot(transform);
			}
			else
			{
				DitherAlphaNormal(transform);
			}
		}
		else
		{
			DitherAlphaNormal(transform);
		}
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		if (LockTargetCinemachine != null)
		{
			LockTargetCinemachine.SetLoseTarget();
			LockTargetCinemachine = null;
		}
		if (characterEffect != null)
		{
			characterEffect = null;
		}
		m_hide = false;
		m_Character = null;
		StopCameraShake();
	}

	private void DitherAlphaNormal(Transform lookat)
	{
		if (m_hide)
		{
			characterEffect.ditherAlpha = 0.5f;
			return;
		}
		float num = float.MaxValue;
		float num2 = float.MaxValue;
		float num3 = 0f;
		if (lookat != null)
		{
			Vector3 vector = base.transform.position.NewY(0f);
			Vector3 vector2 = Camera.main.transform.position.NewY(0f);
			Vector3 vector3 = lookat.position.NewY(0f);
			num = vector.ClosestPointOnSegment(vector2, vector3);
			num2 = Vector3.SqrMagnitude(vector - Vector3.Lerp(vector2, vector3, num));
			int num4 = ConfigHelper.GetInstance().GetConfig<RoleConfig>(mAgent.AgentConfigID).Radius.get_Item(0);
			int num5 = 500;
			num3 = (float)num4 / 1000f + (float)num5 / 1000f;
			num3 *= num3;
		}
		if (num2 < num3 && num < 0.8f)
		{
			if (characterEffect.ditherAlpha != 0.5f)
			{
				characterEffect.ditherAlpha = 0.5f;
			}
		}
		else if (characterEffect.ditherAlpha != 1f)
		{
			characterEffect.ditherAlpha = 1f;
		}
	}

	private void DitherAlphaCloseUpShot(Transform lookat)
	{
		if (m_hide)
		{
			characterEffect.ditherAlpha = 0.5f;
			return;
		}
		bool flag = false;
		if (lookat != null && lookat.root != base.transform)
		{
			int num = ConfigHelper.GetInstance().GetConfig<RoleConfig>(mAgent.AgentConfigID).Radius.get_Item(0);
			Vector3 vector = base.transform.position.NewY(0f);
			Vector3 vector2 = Camera.main.transform.position.NewY(0f);
			Vector3 vector3 = lookat.position.NewY(0f);
			float num2 = (vector - vector2).magnitude - (float)num / 1000f;
			float magnitude = (vector2 - vector3).magnitude;
			if (num2 < magnitude)
			{
				flag = true;
			}
		}
		if (flag)
		{
			if (characterEffect.ditherAlpha != 0.5f)
			{
				characterEffect.ditherAlpha = 0.5f;
			}
		}
		else if (characterEffect.ditherAlpha != 1f)
		{
			characterEffect.ditherAlpha = 1f;
		}
	}

	public NoiseSettings GetNoiseSettings(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return null;
		}
		if (keyValuePairs.ContainsKey(path))
		{
			return keyValuePairs[path];
		}
		NoiseSettings noiseSettings = Asset.Load<NoiseSettings>(path);
		keyValuePairs.Add(path, noiseSettings);
		return noiseSettings;
	}

	public void SetCameraShake(CinemachineBasicMultiChannelPerlin virtualCamera, TimelineCameraClip clip)
	{
		if (m_Character == null)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < multiChannelPerlins.Count; i++)
		{
			if (multiChannelPerlins[i] == virtualCamera)
			{
				num = i;
				break;
			}
		}
		if (num == -1)
		{
			multiChannelPerlins.Add(virtualCamera);
			cameraShakeLeftTime.Add(clip);
			virtualCamera.m_NoiseProfile = GetNoiseSettings(clip.noiseProfilePath);
			virtualCamera.m_AmplitudeGain = clip.amplitude;
			virtualCamera.m_FrequencyGain = clip.frequency;
		}
		else if (clip.priority >= cameraShakeLeftTime[num].priority)
		{
			cameraShakeLeftTime[num] = clip;
			virtualCamera.m_NoiseProfile = GetNoiseSettings(clip.noiseProfilePath);
			virtualCamera.m_AmplitudeGain = clip.amplitude;
			virtualCamera.m_FrequencyGain = clip.frequency;
		}
	}

	public void UpdateCameraShakeTime()
	{
		for (int num = cameraShakeLeftTime.Count - 1; num >= 0; num--)
		{
			TimelineCameraClip value = cameraShakeLeftTime[num];
			value.duration -= Time.deltaTime;
			cameraShakeLeftTime[num] = value;
			if (value.duration <= 0f)
			{
				if (multiChannelPerlins[num] != null)
				{
					multiChannelPerlins[num].m_NoiseProfile = null;
					multiChannelPerlins[num].m_AmplitudeGain = 0f;
					multiChannelPerlins[num].m_FrequencyGain = 0f;
				}
				cameraShakeLeftTime.RemoveAt(num);
				multiChannelPerlins.RemoveAt(num);
			}
		}
	}

	public void StopCameraShake()
	{
		for (int num = cameraShakeLeftTime.Count - 1; num >= 0; num--)
		{
			if (multiChannelPerlins[num] != null)
			{
				multiChannelPerlins[num].m_NoiseProfile = null;
				multiChannelPerlins[num].m_AmplitudeGain = 0f;
				multiChannelPerlins[num].m_FrequencyGain = 0f;
			}
			cameraShakeLeftTime.RemoveAt(num);
			multiChannelPerlins.RemoveAt(num);
		}
	}

	public void RemoveCameraShake(int key)
	{
		for (int num = cameraShakeLeftTime.Count - 1; num >= 0; num--)
		{
			if (cameraShakeLeftTime[num].key == key)
			{
				if (multiChannelPerlins[num] != null)
				{
					multiChannelPerlins[num].m_NoiseProfile = null;
					multiChannelPerlins[num].m_AmplitudeGain = 0f;
					multiChannelPerlins[num].m_FrequencyGain = 0f;
				}
				cameraShakeLeftTime.RemoveAt(num);
				multiChannelPerlins.RemoveAt(num);
			}
		}
	}

	public float GetLeftShakeTime(CinemachineBasicMultiChannelPerlin virtualCamera)
	{
		for (int i = 0; i < multiChannelPerlins.Count; i++)
		{
			if (multiChannelPerlins[i] == virtualCamera)
			{
				return cameraShakeLeftTime[i].duration;
			}
		}
		return 0f;
	}

	public bool RotateCameraToRoleaBack()
	{
		return virtualCameraParam.RotateCameraToRoleaBack(base.transform);
	}

	public bool RotateCameraToRoleaBackWithTime(float time)
	{
		return virtualCameraParam.RotateCameraToRoleaBackWithTime(base.transform, time);
	}

	public static bool ShapeStateContains(List<ShapeState> list, int part)
	{
		foreach (ShapeState item in list)
		{
			if (item.mPartType == (ShapePartType)part)
			{
				return true;
			}
		}
		return false;
	}

	public override void LateUpdateBehavior()
	{
		base.LateUpdateBehavior();
		UpdateCameraShakeTime();
		if (!LockTargetCinemachine)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		if (isNeedLock && !LockTargetCinemachine.hasManualLock)
		{
			isNeedLock = false;
			RunTimeTimelineAndHitCache timelineAndHitCache = battleScene.GetTimelineAndHitCache();
			if (timelineAndHitCache == null)
			{
				return;
			}
			TimelineInfo timelineInfo = timelineAndHitCache.Get(m_Character.m_NextSimFrameData.mAbilityID);
			if (timelineInfo == null)
			{
				return;
			}
			int index = 0;
			float num = ((timelineInfo.hitEffects.Count > 0) ? timelineInfo.hitEffects[index].begin : 0.1f);
			if (timelineInfo.LookAtPoint != Vector3.zero)
			{
				Vector4 vector = timelineInfo.LookAtPoint;
				vector.w = 1f;
				LockTargetCinemachine.targetPoint = base.transform.localToWorldMatrix * vector;
				LockTargetCinemachine.isLockAPoint = true;
			}
			else
			{
				LockTargetCinemachine.isLockAPoint = false;
			}
			LockTargetCinemachine.lockFineshTime = timelineInfo.duration * num;
			if (LockTargetCinemachine.lockFineshTime > 0.4f)
			{
				LockTargetCinemachine.lockFineshTime = 0.4f;
			}
			LockTargetCinemachine.ResetLockTime();
			if (LockTargetCinemachine.isLockAPoint)
			{
				return;
			}
			NAgent agent = agentManager.GetAgent(m_Character.m_NextSimFrameData.mAimingTarget);
			if (!(agent == null) && !(agent.Blackboard as BBHumanoid).m_NextSimFrameData.mCantBeLocked)
			{
				LockTargetCinemachine.SetTargetAgent(agent.AgentID);
				WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
				worldSatetManager.lockedAgentID = agent.AgentID;
				worldSatetManager.lockedAgentPart = m_Character.m_NextSimFrameData.mAimTargetPart;
				worldSatetManager.lockedTime = 0f;
				if (worldSatetManager.hasManualLock)
				{
					LockTargetCinemachine.hasManualLock = true;
				}
			}
			return;
		}
		WorldStateManager worldSatetManager2 = battleScene.GetWorldSatetManager();
		NAgent agent2 = agentManager.GetAgent(worldSatetManager2.lockedAgentID);
		if (agent2 == null)
		{
			if (!LockTargetCinemachine.isLockAPoint && LockTargetCinemachine.IsLocking())
			{
				LockTargetCinemachine.SetLoseTarget();
			}
			worldSatetManager2.lockedAgentID = 0;
			worldSatetManager2.lockedAgentPart = 0;
			worldSatetManager2.hasManualLock = false;
			return;
		}
		bool flag = ((agent2.Blackboard as BBHumanoid).m_NextSimFrameData.mIsHide & E_EntityHideType.Render) == E_EntityHideType.Render;
		long hP = (agent2.Blackboard as BBHumanoid).HP;
		bool num2 = (agent2.Blackboard as BBHumanoid).m_NextSimFrameData.mCantBeLocked | flag;
		if ((num2 || hP <= 0) && !LockTargetCinemachine.isLockAPoint && LockTargetCinemachine.IsLocking())
		{
			LockTargetCinemachine.SetLoseTarget();
		}
		if (num2 || hP <= 0)
		{
			worldSatetManager2.lockedAgentID = 0;
			worldSatetManager2.lockedAgentPart = 0;
			worldSatetManager2.hasManualLock = false;
		}
		else if (m_Character.m_NextSimFrameData.mAimingTarget != 0)
		{
			worldSatetManager2.lockedAgentID = m_Character.m_NextSimFrameData.mAimingTarget;
			worldSatetManager2.lockedAgentPart = m_Character.m_NextSimFrameData.mAimTargetPart;
		}
	}
}
