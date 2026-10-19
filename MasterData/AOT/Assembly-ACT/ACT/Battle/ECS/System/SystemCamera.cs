using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Utility;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemCamera : ECSSystem
{
	private enum FocusMode
	{
		Following,
		Fixed,
		Transition
	}

	private enum FocusContext
	{
		Full,
		Simple
	}

	private CinemachineVirtualCamera m_Camera;

	private CinemachineTargetGroup m_TargetGroup;

	private EntityLocal m_Local;

	private CinemachineBrain m_Brain;

	private CinemachineBlendDefinition m_DefaultBlend;

	private CinemachineBlendDefinition m_CutBlend;

	private CinemachineBlenderSettings _customBlendSettings;

	private CinemachineVirtualCamera m_VirtualCamera;

	private Dictionary<EntityId, GameObject> characterCameras;

	private CinemachineVirtualCamera currentCam;

	private CameraUnFollowedTime m_CameraUnFollowedTime;

	private bool m_FocusReady;

	private FocusMode m_FocusMode;

	private Vector3 m_FocusPosition;

	private Vector3 m_FocusCurrentOffset;

	private Vector3 m_FocusTargetOffset;

	private Vector3 m_FocusOffsetVelocity;

	private ConfigCameraFocus m_FocusConfig;

	private float m_FocusProfileLerp;

	private float m_FocusProfileTransitionTime;

	private FocusContext m_FocusContext;

	private float m_FocusInputTimer;

	private EInputDir m_FocusBufferedDir;

	private float m_FocusTransitionDuration;

	private float m_FocusTransitionTimer;

	private Vector3 m_FocusFixedPosition;

	private Vector3 m_FocusDispOffset;

	private Vector3 m_FocusDispVelocity;

	public CinemachineBrain Brain => m_Brain;

	public CameraPlayerWrapper CameraPlayerWrapper { get; protected set; }

	public override Filter MajorFilter => null;

	protected override void OnCreate()
	{
		m_Brain = Camera.main.GetComponent<CinemachineBrain>();
		m_CutBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		m_DefaultBlend = m_Brain.m_DefaultBlend;
		_customBlendSettings = m_Brain.m_CustomBlends;
		m_Local = MonoECS.instance.entityLocal;
		m_Local.compCamera.Init();
		m_Local.compCamera.mainCamera = Camera.main;
		characterCameras = new Dictionary<EntityId, GameObject>();
		CameraPlayerWrapper = new GameObject("CameraPlayerWrapper").AddComponent<CameraPlayerWrapper>();
		UnityEngine.Object.DontDestroyOnLoad(CameraPlayerWrapper.gameObject);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		characterCameras.Clear();
		if (CameraPlayerWrapper != null)
		{
			UnityEngine.Object.Destroy(CameraPlayerWrapper.gameObject);
			CameraPlayerWrapper = null;
		}
	}

	public void Start(Entity localBehave, GameObject cams)
	{
		ConfigCharacter config = localBehave.GetConfig();
		m_Brain.m_CustomBlends = config.cinemachineSettings;
		if (cams != null)
		{
			m_VirtualCamera = cams.GetComponentInChildren<CinemachineVirtualCamera>(includeInactive: true);
		}
		else
		{
			m_VirtualCamera = GameObject.Find("defaultvcam").GetComponent<CinemachineVirtualCamera>();
			m_VirtualCamera.Follow = CameraPlayerWrapper.transform;
			m_VirtualCamera.LookAt = CameraPlayerWrapper.transform;
		}
		CameraConfig cameraConfig = config.cameraConfig;
		switch (cameraConfig.tgType)
		{
		case ACT.Battle.Configs.CameraType.FollowOwner:
			m_VirtualCamera.Follow = CameraPlayerWrapper.transform;
			m_VirtualCamera.LookAt = CameraPlayerWrapper.transform;
			break;
		case ACT.Battle.Configs.CameraType.FollowPoint:
		{
			Transform transform = localBehave.GetRootTransform().Find(cameraConfig.followPoint);
			m_VirtualCamera.Follow = transform;
			m_VirtualCamera.LookAt = transform;
			break;
		}
		case ACT.Battle.Configs.CameraType.None:
		case ACT.Battle.Configs.CameraType.SelfTarget:
		case ACT.Battle.Configs.CameraType.TargetGroup:
		case ACT.Battle.Configs.CameraType.Static:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("角色相机的相机类型只能为 FollowOwner 和 FollowPoint");
			}
			break;
		}
		m_VirtualCamera.Priority = 10;
	}

	public void InitCharacterVCam(Entity entity, int charIndex)
	{
		GameObject gameObject = null;
		ConfigCharacter config = entity.GetConfig();
		if (config.cameras != null)
		{
			gameObject = UnityEngine.Object.Instantiate(config.cameras);
		}
		bool active = charIndex == MonoECS.instance.battleEntityIndex;
		gameObject?.SetActive(active);
		characterCameras[entity.Id] = gameObject;
		if (charIndex == MonoECS.instance.battleEntityIndex)
		{
			Start(entity, gameObject);
			m_Camera = m_VirtualCamera;
		}
	}

	public void ShowCharacterVCam(bool show, EntityId id, Entity eb = default(Entity))
	{
		if (characterCameras.TryGetValue(id, out var value))
		{
			value.SetActive(show);
		}
		if (show && eb.IsValid)
		{
			Start(eb, value);
		}
	}

	public void DestroyCharacterVCam(EntityId id)
	{
		if (characterCameras.TryGetValue(id, out var value))
		{
			UnityEngine.Object.Destroy(value);
			characterCameras.Remove(id);
		}
	}

	public int StartCinemachineMovement(GameObject cams, CinemachineBlenderSettings settings, Transform follow, int priority = 0)
	{
		m_Brain.m_CustomBlends = settings;
		CinemachineVirtualCamera[] array = new CinemachineVirtualCamera[0];
		if (cams != null)
		{
			array = cams.GetComponentsInChildren<CinemachineVirtualCamera>();
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("对话相机配置有问题?请检查检查相机预制体");
		}
		int result = (int)(1000f * settings.GetBlendForVirtualCameras(m_Camera.name, array[0].name, default).BlendTime);
		m_Camera = array[0];
		m_Camera.Priority = 45 + priority;
		m_Camera.Follow = follow;
		return result;
	}

	public int EndCinemachineMovement(Entity localBehave)
	{
		m_Camera.Priority = 9;
		m_Brain.m_CustomBlends = localBehave.GetConfig().cinemachineSettings;
		CinemachineVirtualCamera[] array;
		if (characterCameras.TryGetValue(localBehave.Id, out var value))
		{
			array = value.GetComponentsInChildren<CinemachineVirtualCamera>();
		}
		else
		{
			array = GameObject.Find("defaultvcam").GetComponents<CinemachineVirtualCamera>();
			array[0].Follow = CameraPlayerWrapper.transform;
		}
		int result = (int)(1000f * m_Brain.m_CustomBlends.GetBlendForVirtualCameras(m_Camera.name, array[0].name, new CinemachineBlendDefinition
		{
			m_Style = CinemachineBlendDefinition.Style.EaseInOut,
			m_Time = 2f
		}).BlendTime);
		m_Camera = array[0];
		m_Camera.Priority = 10;
		return result;
	}

	public override void FixedUpdate()
	{
		try
		{
			if (m_CameraUnFollowedTime.time > 0f && !(MonoECS.instance == null) && MonoECS.instance.mainEntity.IsValid && MonoECS.instance.mainEntity.IsLogicAvailable())
			{
				m_CameraUnFollowedTime.time -= MonoECS.instance.mainEntity.GetCompTime().fixedDeltaTime;
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{arg}");
			}
		}
	}

	public override void Update()
	{
		if (m_CameraUnFollowedTime.time <= 0f)
		{
			CameraPlayerWrapper.OnUpdate();
		}
		UpdateCameraFocus();
	}

	private FocusContext DetermineFocusContext()
	{
		if (MonoECS.instance == null)
		{
			return FocusContext.Simple;
		}
		if (MonoECS.instance.playState == PlayState.Death)
		{
			return FocusContext.Simple;
		}
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.Interacting))
		{
			return FocusContext.Simple;
		}
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.BackTrace))
		{
			return FocusContext.Simple;
		}
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.Timeline))
		{
			return FocusContext.Simple;
		}
		if (m_Brain != null)
		{
			ICinemachineCamera activeVirtualCamera = m_Brain.ActiveVirtualCamera;
			if (activeVirtualCamera != null)
			{
				if (activeVirtualCamera.Priority >= 91)
				{
					return FocusContext.Simple;
				}
				CinemachineFocusContext component = activeVirtualCamera.VirtualCameraGameObject.GetComponent<CinemachineFocusContext>();
				if (component != null && component.mode == CinemachineFocusContext.Mode.Simple)
				{
					return FocusContext.Simple;
				}
			}
		}
		return FocusContext.Full;
	}

	private void UpdateFocusProfileLerp()
	{
		float target = ((MonoECS.instance != null && MonoECS.instance.playState == PlayState.Battle) ? 1f : 0f);
		float maxDelta = ((m_FocusProfileTransitionTime > 0f) ? (Time.deltaTime / m_FocusProfileTransitionTime) : 1f);
		m_FocusProfileLerp = Mathf.MoveTowards(m_FocusProfileLerp, target, maxDelta);
	}

	private void UpdateCameraFocus()
	{
		if (MonoECS.instance == null || GameLoader.meta == null)
		{
			return;
		}
		if (m_FocusConfig == null)
		{
			m_FocusConfig = GameLoader.meta.cameraFocusConfig;
			m_FocusProfileTransitionTime = m_FocusConfig.profileTransitionTime;
			m_FocusTransitionDuration = m_FocusConfig.transitionDuration;
			m_FocusProfileLerp = ((MonoECS.instance != null && MonoECS.instance.playState == PlayState.Battle) ? 1f : 0f);
		}
		UpdateFocusProfileLerp();
		m_FocusContext = DetermineFocusContext();
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsValid || !entity.IsLogicAvailable())
		{
			if (m_FocusReady)
			{
				CameraPlayerWrapper.transform.position = m_FocusPosition;
			}
			return;
		}
		if (!m_FocusReady)
		{
			m_FocusPosition = CameraPlayerWrapper.transform.position + m_FocusConfig.focusOffset;
			CameraPlayerWrapper.transform.position = m_FocusPosition;
			m_FocusReady = true;
			return;
		}
		Vector3 position = CameraPlayerWrapper.transform.position;
		Vector3 focusOffset = m_FocusConfig.focusOffset;
		switch (m_FocusMode)
		{
		case FocusMode.Following:
			if (m_FocusContext == FocusContext.Simple)
			{
				m_FocusCurrentOffset = Vector3.zero;
				m_FocusTargetOffset = Vector3.zero;
				m_FocusOffsetVelocity = Vector3.zero;
				m_FocusDispOffset = Vector3.zero;
				m_FocusDispVelocity = Vector3.zero;
				m_FocusPosition = position + focusOffset;
			}
			else
			{
				UpdateFocusFollowing(entity, position);
			}
			break;
		case FocusMode.Transition:
			UpdateFocusTransition(position);
			break;
		}
		CameraPlayerWrapper.transform.SetPositionAndRotation(m_FocusPosition, CameraPlayerWrapper.transform.rotation);
	}

	private void UpdateFocusFollowing(Entity main, Vector3 playerPos)
	{
		float focusProfileLerp = m_FocusProfileLerp;
		ConfigCameraFocus focusConfig = m_FocusConfig;
		float num = Mathf.Lerp(focusConfig.exploration.leadingAmount, focusConfig.combat.leadingAmount, focusProfileLerp);
		float num2 = Mathf.Lerp(focusConfig.exploration.smoothTimeOut, focusConfig.combat.smoothTimeOut, focusProfileLerp);
		float num3 = Mathf.Lerp(focusConfig.exploration.smoothTimeBack, focusConfig.combat.smoothTimeBack, focusProfileLerp);
		float num4 = Mathf.Lerp(focusConfig.exploration.inputBufferTime, focusConfig.combat.inputBufferTime, focusProfileLerp);
		bool flag = ((focusProfileLerp > 0.5f) ? focusConfig.combat.useDisplacement : focusConfig.exploration.useDisplacement);
		float num5 = Mathf.Lerp(focusConfig.exploration.displacementScale, focusConfig.combat.displacementScale, focusProfileLerp);
		float num6 = Mathf.Lerp(focusConfig.exploration.displacementMax, focusConfig.combat.displacementMax, focusProfileLerp);
		float t = Mathf.Lerp(focusConfig.exploration.inputWeight, focusConfig.combat.inputWeight, focusProfileLerp);
		CompInput compInput = main.GetCompInput();
		if (compInput != null)
		{
			EInputDir dirX = compInput.dirX;
			if (dirX != EInputDir.None)
			{
				if (dirX == m_FocusBufferedDir)
				{
					m_FocusInputTimer += Time.deltaTime;
				}
				else
				{
					m_FocusBufferedDir = dirX;
					m_FocusInputTimer = Time.deltaTime;
				}
				if (m_FocusInputTimer >= num4)
				{
					m_FocusTargetOffset.x = ((dirX == EInputDir.Right) ? num : (0f - num));
				}
			}
			else
			{
				m_FocusTargetOffset.x = 0f;
				m_FocusBufferedDir = EInputDir.None;
				m_FocusInputTimer = 0f;
			}
		}
		if (flag)
		{
			CompPhysics compPhysics = main.GetCompPhysics();
			if (compPhysics != null)
			{
				float target = Mathf.Clamp(compPhysics.rawVelocity.x * num5, 0f - num6, num6);
				m_FocusDispOffset.x = Mathf.SmoothDamp(m_FocusDispOffset.x, target, ref m_FocusDispVelocity.x, num2);
			}
		}
		else
		{
			m_FocusDispOffset.x = 0f;
			m_FocusDispVelocity.x = 0f;
		}
		float num7 = ((!flag) ? m_FocusTargetOffset.x : Mathf.Lerp(m_FocusDispOffset.x, m_FocusTargetOffset.x, t));
		float smoothTime = ((Mathf.Abs(num7) > Mathf.Abs(m_FocusCurrentOffset.x)) ? num2 : num3);
		m_FocusCurrentOffset.x = Mathf.SmoothDamp(m_FocusCurrentOffset.x, num7, ref m_FocusOffsetVelocity.x, smoothTime);
		m_FocusPosition = playerPos + m_FocusCurrentOffset + m_FocusConfig.focusOffset;
	}

	private void UpdateFocusTransition(Vector3 playerPos)
	{
		m_FocusTransitionTimer -= Time.deltaTime;
		if (m_FocusTransitionTimer <= 0f)
		{
			m_FocusPosition = playerPos + m_FocusConfig.focusOffset;
			m_FocusCurrentOffset = Vector3.zero;
			m_FocusTargetOffset = Vector3.zero;
			m_FocusOffsetVelocity = Vector3.zero;
			m_FocusMode = FocusMode.Following;
		}
		else
		{
			float t = 1f - m_FocusTransitionTimer / m_FocusTransitionDuration;
			m_FocusPosition = Vector3.Lerp(m_FocusFixedPosition, playerPos + m_FocusConfig.focusOffset, t);
		}
	}

	public void SetFocusFixed()
	{
		m_FocusFixedPosition = ((CameraPlayerWrapper != null) ? CameraPlayerWrapper.transform.position : m_FocusPosition);
		m_FocusMode = FocusMode.Fixed;
	}

	public void SetFocusTransition(float duration = -1f)
	{
		if (duration > 0f)
		{
			m_FocusTransitionDuration = duration;
		}
		m_FocusTransitionTimer = m_FocusTransitionDuration;
		m_FocusMode = FocusMode.Transition;
	}

	public void SetCameraBlend(bool isDefault = false)
	{
		if (isDefault)
		{
			m_Brain.m_DefaultBlend = m_DefaultBlend;
			m_Brain.m_CustomBlends = _customBlendSettings;
		}
		else
		{
			m_Brain.m_DefaultBlend = m_CutBlend;
			m_Brain.m_CustomBlends = null;
		}
	}

	public void SetCameraUnFollow(CameraUnFollowedTime cameraUnFollowedTime)
	{
		m_CameraUnFollowedTime = cameraUnFollowedTime;
	}

	public void CameraTp(Vector3 position)
	{
		if (CameraPlayerWrapper != null)
		{
			Vector3 vector = position - CameraPlayerWrapper.transform.position;
			Vector3 immediatePosition = Brain.transform.position + vector;
			CameraPlayerWrapper.transform.position = position;
			m_FocusPosition = position;
			m_FocusCurrentOffset = Vector3.zero;
			m_FocusOffsetVelocity = Vector3.zero;
			CinemachineCore.Instance.OnTargetObjectWarped(CameraPlayerWrapper.transform, vector);
			Brain.TeleportSnap(immediatePosition);
		}
	}

	public void SetCameraPosition(Vector3 position)
	{
		m_Brain.transform.position = position;
	}
}
