using System;
using System.Collections.Generic;
using Chess;
using Cinemachine;
using UnityEngine;

public class HexCameraManager : MonoBehaviour
{
	private enum CAMERASTATE
	{
		LookAt,
		Drag,
		Switch_Ready,
		Switch_Start,
		Move
	}

	private enum CAMERA_LOOKAT_STATUS
	{
		FREE,
		PLAYER,
		TARGET_GROUP
	}

	public static HexCameraManager _instance;

	private bool isEnableControl = true;

	public Transform gameplayDummy;

	public CinemachineFreeLook dummyFreeLook;

	public CinemachineFreeLook playerFreeLook;

	public CinemachineFreeLook groupFreeLook;

	public CinemachineTargetGroup targetGroup;

	public CinemachineTargetGroup targetGroupTmp;

	private CinemachineBrain cinemachineBrain;

	public Transform playerTrs;

	private CinemachineTargetGroup.Target playerTarget;

	private float minFreeLookX;

	private float maxFreeLookX;

	private float minFreeLookZ;

	private float maxFreeLookZ;

	private CAMERASTATE state;

	private ChessCameraTarget.cameraTarget target1;

	private float cameraSpeed = 10f;

	private bool isSpeedUniform = true;

	public AnimationCurve speedCurve;

	private Action callBackTmpLookat;

	private Dictionary<int, ChessCameraTarget.cameraTarget> _callBackDic = new Dictionary<int, ChessCameraTarget.cameraTarget>(new IntComparer());

	private float moveDistance;

	private CAMERA_LOOKAT_STATUS cameraLookAtStatus;

	private bool isFramingPlatoon;

	public static HexCameraManager Instance => _instance;

	public bool IsEnableControl
	{
		get
		{
			return isEnableControl;
		}
		set
		{
			if (isEnableControl != value)
			{
				isEnableControl = value;
				if (cinemachineBrain == null)
				{
					cinemachineBrain = Camera.main.gameObject.GetComponent<CinemachineBrain>();
				}
				if (cinemachineBrain != null)
				{
					cinemachineBrain.enabled = isEnableControl;
				}
			}
		}
	}

	public Transform PlayerTrs
	{
		get
		{
			return playerTrs;
		}
		set
		{
			playerTrs = value;
			playerTarget = default(CinemachineTargetGroup.Target);
			playerTarget.target = playerTrs;
			playerTarget.weight = 1f;
			playerTarget.radius = 0f;
			targetGroup.m_Targets = new CinemachineTargetGroup.Target[1];
			targetGroup.m_Targets[0] = playerTarget;
		}
	}

	public bool IsFramingPlatoon => isFramingPlatoon;

	private void Awake()
	{
		_instance = this;
		MapConfig mapConfig = ChessMapCfgManager.Instance.MapConfig;
		minFreeLookX = mapConfig.minFreeLookX;
		maxFreeLookX = mapConfig.maxFreeLookX;
		minFreeLookZ = mapConfig.minFreeLookZ;
		maxFreeLookZ = mapConfig.maxFreeLookZ;
	}

	private void Start()
	{
		playerFreeLook.LookAt = targetGroup.transform;
		playerFreeLook.Follow = targetGroup.transform;
		groupFreeLook.LookAt = targetGroupTmp.transform;
		groupFreeLook.Follow = targetGroupTmp.transform;
	}

	public void SetCinemachineBrainParams(CinemachineBrain brain)
	{
		if (null == brain.m_CustomBlends)
		{
			brain.m_CustomBlends = new CinemachineBlenderSettings();
		}
		CinemachineBlenderSettings.CustomBlend customBlend = new CinemachineBlenderSettings.CustomBlend
		{
			m_From = "**ANY CAMERA**",
			m_To = dummyFreeLook.name,
			m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f)
		};
		brain.m_CustomBlends.m_CustomBlends = new CinemachineBlenderSettings.CustomBlend[1];
		brain.m_CustomBlends.m_CustomBlends[0] = customBlend;
		brain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.2f);
	}

	private void Update()
	{
		switch (state)
		{
		case CAMERASTATE.Switch_Ready:
			state = CAMERASTATE.Switch_Start;
			break;
		case CAMERASTATE.Switch_Start:
		{
			CinemachineBrain component = Camera.main.GetComponent<CinemachineBrain>();
			if (null == component || component.ActiveBlend == null)
			{
				if ((bool)component && !component.IsLive(playerFreeLook))
				{
					Debug.LogError("Hex Camera cause error");
				}
				state = CAMERASTATE.LookAt;
				CheckCallBack();
				Debug.Log("Camera LootAt");
			}
			break;
		}
		case CAMERASTATE.Move:
		{
			float num = cameraSpeed;
			if (!isSpeedUniform && moveDistance != 0f)
			{
				float time = (moveDistance - Vector3.Distance(gameplayDummy.position, target1.target)) / moveDistance;
				num = speedCurve.Evaluate(time) * cameraSpeed;
			}
			float maxDistanceDelta = num * Time.deltaTime;
			gameplayDummy.position = Vector3.MoveTowards(gameplayDummy.position, target1.target, maxDistanceDelta);
			if (0.0001f > Vector3.Distance(gameplayDummy.position, target1.target))
			{
				state = CAMERASTATE.Drag;
				gameplayDummy.position = target1.target;
				CheckCallBack(target1);
			}
			break;
		}
		}
	}

	public void LookAtTargetS(Transform[] targetS, float speed = 10f, Action callback = null, bool isUniform = true)
	{
		cameraSpeed = speed;
		targetGroupTmp.m_Targets = new CinemachineTargetGroup.Target[targetS.Length];
		for (int i = 0; i < targetS.Length; i++)
		{
			CinemachineTargetGroup.Target target = new CinemachineTargetGroup.Target
			{
				target = targetS[i],
				weight = 1f,
				radius = 0.5f
			};
			targetGroupTmp.m_Targets[i] = target;
		}
		targetGroupTmp.DoUpdate();
		Action callBack = delegate
		{
			ChangeCameraLookAt(CAMERA_LOOKAT_STATUS.TARGET_GROUP);
			if (callback != null)
			{
				callback();
			}
		};
		MoveTargetSmooth(targetGroupTmp.transform.position, speed, _force: true, callBack, isUniform);
	}

	public void LookAtPlayer(Action callBack = null)
	{
		callBackTmpLookat = callBack;
		if (state != CAMERASTATE.LookAt)
		{
			state = CAMERASTATE.Switch_Ready;
		}
		else
		{
			CheckCallBack();
			Debug.Log("Camera LootAt");
		}
		ChangeCameraLookAt(CAMERA_LOOKAT_STATUS.PLAYER);
	}

	public void MoveGameplayCamera(Vector2 amount)
	{
		if (CAMERASTATE.Move != state)
		{
			state = CAMERASTATE.Drag;
			ChangeCameraLookAt(CAMERA_LOOKAT_STATUS.FREE);
			gameplayDummy.Translate(amount.x, 0f, amount.y, Space.World);
			gameplayDummy.position = new Vector3(Mathf.Clamp(gameplayDummy.position.x, minFreeLookX, maxFreeLookX), gameplayDummy.position.y, Mathf.Clamp(gameplayDummy.position.z, minFreeLookZ, maxFreeLookZ));
		}
	}

	public void MoveTarget(Vector3 _target, bool _force = true)
	{
		if (_force || CAMERASTATE.Move != state)
		{
			ChangeCameraLookAt(CAMERA_LOOKAT_STATUS.FREE);
			gameplayDummy.position = _target;
			state = CAMERASTATE.Move;
		}
	}

	public void MoveTargetSmooth(Vector3 _target, float speed = 10f, bool _force = true, Action callBack = null, bool isUniform = true)
	{
		cameraSpeed = speed;
		isSpeedUniform = isUniform;
		if (_force || CAMERASTATE.Move != state)
		{
			ChangeCameraLookAt(CAMERA_LOOKAT_STATUS.FREE);
			moveDistance = Vector3.Distance(gameplayDummy.position, _target);
			target1 = ChessCameraTarget.SetNewTarget(_target, callBack);
			state = CAMERASTATE.Move;
			_callBackDic[target1.uuid] = target1;
		}
	}

	private void ChangeCameraLookAt(CAMERA_LOOKAT_STATUS lookAtStatus)
	{
		if (cameraLookAtStatus != lookAtStatus)
		{
			ModifyCameraLookAtByStatus(lookAtStatus);
		}
	}

	private void SetPlatoonFramingMode(bool enable)
	{
		if (isFramingPlatoon != enable)
		{
			isFramingPlatoon = enable;
			TogglePlatoonFramingMode();
		}
	}

	public void SyncDummyToPlayer()
	{
		gameplayDummy.position = playerTrs.position;
	}

	public void AddYAxis(float addNum)
	{
		playerFreeLook.m_YAxis.Value = playerFreeLook.m_YAxis.Value + addNum;
		dummyFreeLook.m_YAxis.Value = dummyFreeLook.m_YAxis.Value + addNum;
		groupFreeLook.m_YAxis.Value = groupFreeLook.m_YAxis.Value + addNum;
	}

	public void ResetYAxis()
	{
		playerFreeLook.m_YAxis.Value = 0.5f;
		dummyFreeLook.m_YAxis.Value = 0.5f;
		groupFreeLook.m_YAxis.Value = 0.5f;
	}

	public Vector3 GetCameraLookAtPosition()
	{
		return cameraLookAtStatus switch
		{
			CAMERA_LOOKAT_STATUS.FREE => gameplayDummy.position, 
			CAMERA_LOOKAT_STATUS.PLAYER => targetGroup.transform.position, 
			CAMERA_LOOKAT_STATUS.TARGET_GROUP => targetGroupTmp.transform.position, 
			_ => Vector3.zero, 
		};
	}

	private void ModifyCameraLookAtByStatus(CAMERA_LOOKAT_STATUS lookAtStatus)
	{
		CinemachineFreeLook freeLookCameraByStatus = GetFreeLookCameraByStatus(cameraLookAtStatus);
		CinemachineFreeLook freeLookCameraByStatus2 = GetFreeLookCameraByStatus(lookAtStatus);
		freeLookCameraByStatus2.m_YAxis = freeLookCameraByStatus.m_YAxis;
		freeLookCameraByStatus.Priority = 0;
		freeLookCameraByStatus2.Priority = 1;
		if (lookAtStatus == CAMERA_LOOKAT_STATUS.FREE)
		{
			gameplayDummy.position = freeLookCameraByStatus.LookAt.position;
		}
		if (lookAtStatus == CAMERA_LOOKAT_STATUS.TARGET_GROUP)
		{
			freeLookCameraByStatus2.m_YAxis.Value = GetGroupCameraYAxis();
		}
		cameraLookAtStatus = lookAtStatus;
	}

	private CinemachineFreeLook GetFreeLookCameraByStatus(CAMERA_LOOKAT_STATUS lookAtStatus)
	{
		return lookAtStatus switch
		{
			CAMERA_LOOKAT_STATUS.FREE => dummyFreeLook, 
			CAMERA_LOOKAT_STATUS.PLAYER => playerFreeLook, 
			CAMERA_LOOKAT_STATUS.TARGET_GROUP => groupFreeLook, 
			_ => dummyFreeLook, 
		};
	}

	private float GetGroupCameraYAxis()
	{
		Bounds boundingBox = targetGroupTmp.BoundingBox;
		if (IstInCameraView(boundingBox.min) && IstInCameraView(boundingBox.max))
		{
			return dummyFreeLook.m_YAxis.Value;
		}
		return 1f;
	}

	public static bool IstInCameraView(Vector3 position)
	{
		Camera main = Camera.main;
		Vector3 vector = main.WorldToViewportPoint(position);
		if (vector.x > 0f && vector.x < 1f && vector.y > 0f && vector.y < 1f && vector.z > main.nearClipPlane && vector.z < main.farClipPlane)
		{
			return true;
		}
		return false;
	}

	private void TogglePlatoonFramingMode()
	{
		if (isFramingPlatoon)
		{
			playerFreeLook.m_YAxis = dummyFreeLook.m_YAxis;
			dummyFreeLook.Priority = 0;
			playerFreeLook.Priority = 1;
		}
		else
		{
			playerFreeLook.m_YAxis = dummyFreeLook.m_YAxis;
			gameplayDummy.position = playerTrs.position;
			playerFreeLook.Priority = 0;
			dummyFreeLook.Priority = 1;
		}
	}

	private void CheckCallBack(ChessCameraTarget.cameraTarget tar)
	{
		if (_callBackDic.TryGetValue(tar.uuid, out var value) && value.callback != null)
		{
			value.callback();
			_callBackDic.Remove(tar.uuid);
		}
	}

	private void CheckCallBack()
	{
		if (callBackTmpLookat != null)
		{
			callBackTmpLookat();
			callBackTmpLookat = null;
		}
	}

	public void OnDestroy()
	{
		_callBackDic.Clear();
	}
}
