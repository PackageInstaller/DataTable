using System;
using Cinemachine;
using Dorm;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class DormCameraManager : MonoBehaviour
{
	public enum CAMERA_LOOKAT_STATUS
	{
		NONE = -1,
		WATCH,
		EDIT,
		ROLE
	}

	public static DormCameraManager _instance;

	public CAMERA_MOVE_TYPE moveType;

	public CinemachineFreeLook watchFreeLook;

	public CinemachineFreeLook editFreeLook;

	public CinemachineFreeLook roleFreeLook;

	public Transform gameplayDummy;

	public Transform roleDummy;

	public Transform triggerPanel;

	public float moveSpeed = 0.1f;

	public float radiusSpeed = 0.1f;

	public float heightSpeed = 0.02f;

	public float rotateRateX = 0.5f;

	public float rotateRateY = 0.0002f;

	public float deltaLimitX;

	public float deltaLimitY;

	public float scaleRate = -0.001f;

	public float wallHide;

	public bool isFixButtomRing = true;

	public float roleFreeLookStartFade = 5.5f;

	public float roleFreeLookEndFade = 4.5f;

	public float cameraReflectionBlur;

	public Vector2 limitMoveX;

	public Vector2 limitMoveZ;

	private DormCameraParams watchParams;

	private DormCameraParams editParams;

	public static DormCameraManager Instance => _instance;

	public CAMERA_LOOKAT_STATUS LookStatus { get; private set; } = CAMERA_LOOKAT_STATUS.NONE;

	private void Awake()
	{
		_instance = this;
	}

	public void InitCameraSetting(DormCameraParams watchParams, DormCameraParams editParams)
	{
		this.watchParams = watchParams;
		this.editParams = editParams;
		if (cameraReflectionBlur > 0f)
		{
			CameraExtension component = Camera.main.GetComponent<CameraExtension>();
			if (component != null)
			{
				component.reflectionBlur = cameraReflectionBlur;
			}
		}
	}

	public static void SetCinemachineBrainParams(CinemachineBrain brain)
	{
		brain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.5f);
	}

	public void RotateCamera(PointerEventData eventData)
	{
		float num = rotateRateX;
		float num2 = rotateRateY;
		float num3 = eventData.delta.x * num;
		float num4 = -1f * eventData.delta.y * num2;
		if (deltaLimitX > 0f)
		{
			num3 = Math.Clamp(num3, -1f * deltaLimitX, deltaLimitX);
		}
		if (deltaLimitY > 0f)
		{
			num4 = Math.Clamp(num4, -1f * deltaLimitY, deltaLimitY);
		}
		RotateCamera(num3, num4);
	}

	public void RotateCamera(float x, float y)
	{
		RotateCamera(GetFreeLookCameraByStatus(LookStatus), x, y);
	}

	public void RotateCamera(CAMERA_LOOKAT_STATUS freeLookType, float x, float y)
	{
		RotateCamera(GetFreeLookCameraByStatus(freeLookType), x, y);
	}

	internal static void RotateCamera(CinemachineFreeLook freeLook, float x, float y)
	{
		freeLook.m_XAxis.Value = freeLook.m_XAxis.Value + x;
		freeLook.m_YAxis.Value = freeLook.m_YAxis.Value + y;
	}

	public void MoveGameplayCamera(PointerEventData eventData)
	{
		Vector2 amount = eventData.delta * moveSpeed * Time.deltaTime * 0.5f;
		MoveGameplayCamera(amount);
	}

	public void MoveGameplayCamera(Vector2 amount)
	{
		float num = GetFreeLookCameraByStatus(LookStatus).m_XAxis.Value * (MathF.PI / 180f);
		Vector2 vector = new Vector2(amount.x * (float)Math.Cos(num) + amount.y * (float)Math.Sin(num), amount.y * (float)Math.Cos(num) - amount.x * (float)Math.Sin(num));
		gameplayDummy.Translate(vector.x, 0f, vector.y, Space.World);
		gameplayDummy.position = new Vector3(Mathf.Clamp(gameplayDummy.position.x, limitMoveX.x, limitMoveX.y), gameplayDummy.position.y, Mathf.Clamp(gameplayDummy.position.z, limitMoveZ.x, limitMoveZ.y));
	}

	public void ScaleCamera(float rate)
	{
		DormCameraParams cameraParamByStatus = GetCameraParamByStatus(LookStatus);
		if (cameraParamByStatus == null)
		{
			return;
		}
		CinemachineFreeLook freeLookCameraByStatus = GetFreeLookCameraByStatus(LookStatus);
		float num = freeLookCameraByStatus.m_Orbits[0].m_Radius + radiusSpeed * rate;
		if (!(num < cameraParamByStatus.topRigInterval.x) && !(num > cameraParamByStatus.topRigInterval.y))
		{
			freeLookCameraByStatus.m_Orbits[0].m_Radius = num;
			freeLookCameraByStatus.m_Orbits[1].m_Radius = freeLookCameraByStatus.m_Orbits[1].m_Radius + radiusSpeed * rate;
			freeLookCameraByStatus.m_Orbits[2].m_Radius = freeLookCameraByStatus.m_Orbits[2].m_Radius + radiusSpeed * rate;
			freeLookCameraByStatus.m_Orbits[0].m_Height = freeLookCameraByStatus.m_Orbits[0].m_Height + heightSpeed * rate;
			if (!isFixButtomRing)
			{
				freeLookCameraByStatus.m_Orbits[2].m_Height = freeLookCameraByStatus.m_Orbits[2].m_Height + heightSpeed * rate;
			}
			freeLookCameraByStatus.m_Orbits[1].m_Height = (freeLookCameraByStatus.m_Orbits[0].m_Height - freeLookCameraByStatus.m_Orbits[2].m_Height) / 2f + freeLookCameraByStatus.m_Orbits[2].m_Height;
		}
	}

	public void ModifyCameraLookAtByStatus(CAMERA_LOOKAT_STATUS lookAtStatus, bool isNeedInit = false)
	{
		if (lookAtStatus != LookStatus)
		{
			CinemachineFreeLook freeLookCameraByStatus = GetFreeLookCameraByStatus(LookStatus);
			CinemachineFreeLook freeLookCameraByStatus2 = GetFreeLookCameraByStatus(lookAtStatus);
			freeLookCameraByStatus.Priority = 0;
			freeLookCameraByStatus2.Priority = 100;
			LookStatus = lookAtStatus;
			if (isNeedInit)
			{
				InitCameraByParams();
			}
		}
	}

	public void InitCameraByParams()
	{
		CinemachineFreeLook freeLookCameraByStatus = GetFreeLookCameraByStatus(LookStatus);
		DormCameraParams cameraParamByStatus = GetCameraParamByStatus(LookStatus);
		if (cameraParamByStatus != null && !(freeLookCameraByStatus == null))
		{
			freeLookCameraByStatus.m_Orbits[0].m_Radius = cameraParamByStatus.topRig.y;
			freeLookCameraByStatus.m_Orbits[1].m_Radius = cameraParamByStatus.middleRig.y;
			freeLookCameraByStatus.m_Orbits[2].m_Radius = cameraParamByStatus.bottomRig.y;
			freeLookCameraByStatus.m_Orbits[0].m_Height = cameraParamByStatus.topRig.x;
			freeLookCameraByStatus.m_Orbits[1].m_Height = cameraParamByStatus.middleRig.x;
			freeLookCameraByStatus.m_Orbits[2].m_Height = cameraParamByStatus.bottomRig.x;
			freeLookCameraByStatus.m_XAxis.Value = cameraParamByStatus.value.x;
			freeLookCameraByStatus.m_YAxis.Value = cameraParamByStatus.value.y;
		}
	}

	public void AddYAxis(float addNum)
	{
		roleFreeLook.m_YAxis.Value = roleFreeLook.m_YAxis.Value + addNum;
		editFreeLook.m_YAxis.Value = editFreeLook.m_YAxis.Value + addNum;
		watchFreeLook.m_YAxis.Value = watchFreeLook.m_YAxis.Value + addNum;
	}

	public void SetControllRole(Transform roleTrs)
	{
		if (roleFreeLook != null)
		{
			roleFreeLook.LookAt = roleTrs;
			roleFreeLook.Follow = roleTrs;
			roleFreeLook.GetRig(0).LookAt = roleTrs;
			roleFreeLook.GetRig(1).LookAt = roleTrs;
			roleFreeLook.GetRig(2).LookAt = roleTrs;
		}
	}

	public void SetLookAtRoleDummy(Transform roleTrs)
	{
		if (roleDummy != null)
		{
			roleDummy.position = roleTrs.position;
		}
		if (roleFreeLook != null)
		{
			roleFreeLook.m_XAxis.Value = GetFreeLookCameraByStatus(LookStatus).m_XAxis.Value;
		}
		ModifyCameraLookAtByStatus(CAMERA_LOOKAT_STATUS.ROLE);
	}

	private CinemachineFreeLook GetFreeLookCameraByStatus(CAMERA_LOOKAT_STATUS lookAtStatus)
	{
		return lookAtStatus switch
		{
			CAMERA_LOOKAT_STATUS.WATCH => watchFreeLook, 
			CAMERA_LOOKAT_STATUS.EDIT => editFreeLook, 
			CAMERA_LOOKAT_STATUS.ROLE => roleFreeLook, 
			_ => watchFreeLook, 
		};
	}

	private DormCameraParams GetCameraParamByStatus(CAMERA_LOOKAT_STATUS lookAtStatus)
	{
		return lookAtStatus switch
		{
			CAMERA_LOOKAT_STATUS.WATCH => watchParams, 
			CAMERA_LOOKAT_STATUS.EDIT => editParams, 
			_ => null, 
		};
	}

	private void OnEnable()
	{
		RoomWallTag.wallHideDot = wallHide;
	}

	private void OnDisable()
	{
	}

	private void Update()
	{
	}

	public void OnDestroy()
	{
		if ((bool)triggerPanel)
		{
			UnityEngine.Object.Destroy(triggerPanel.gameObject);
		}
	}
}
