using Cinemachine;
using UnityEngine;

public class CameraParamComponent : MonoBehaviour
{
	public CameraParam defaultCameraParam;

	public CinemachineVirtualCamera virtualCamera;

	public CinemachineOrbitalTransposer transposer;

	public CinemachineComposer composer;

	public LockTargetCinemachine lockTargetCinemachine;

	public CinemachineTargetGroup targetGroup;

	public CinemachineCameraOffset offsetCom;

	private CameraParam targetParam;

	private float leftTime;

	private bool isRunning;

	private bool lockTarget;

	private Vector3 offset = Vector3.zero;

	private float m_targetXAxisValue;

	private float m_xAxisTime;

	private void Awake()
	{
		if (virtualCamera == null)
		{
			virtualCamera = GetComponent<CinemachineVirtualCamera>();
		}
		if (transposer == null)
		{
			transposer = virtualCamera.GetCinemachineComponent<CinemachineOrbitalTransposer>();
		}
		if (composer == null)
		{
			composer = virtualCamera.GetCinemachineComponent<CinemachineComposer>();
		}
		if (lockTargetCinemachine == null)
		{
			lockTargetCinemachine = GetComponent<LockTargetCinemachine>();
		}
		if (targetGroup == null)
		{
			targetGroup = base.transform.Find("TargetGroup").GetComponent<CinemachineTargetGroup>();
		}
		if (targetGroup != null)
		{
			targetGroup.transform.parent = null;
		}
		if (offsetCom == null)
		{
			offsetCom = GetComponent<CinemachineCameraOffset>();
		}
		offset = offsetCom.m_Offset;
	}

	private void OnDestroy()
	{
		if (targetGroup != null)
		{
			Object.Destroy(targetGroup.gameObject);
		}
	}

	public void SetCameraParam(CameraParam param, float time, bool lockTarget = false)
	{
		if (virtualCamera == null)
		{
			Debug.LogError("虚拟相机为空");
			return;
		}
		this.lockTarget = lockTarget;
		isRunning = true;
		leftTime = time;
		targetParam = param;
	}

	public void SetCameraParam(CameraParam param)
	{
		transposer.m_FollowOffset = new Vector3(0f, param.height, 0f - param.radius);
		virtualCamera.m_Lens.FieldOfView = param.fov;
		composer.m_DeadZoneWidth = param.deadZoneWidth;
		composer.m_DeadZoneHeight = param.deadZoneHeight;
		composer.m_SoftZoneHeight = param.softZoneHeight;
		composer.m_SoftZoneWidth = param.softZoneWidth;
		composer.m_ScreenY = param.screenY;
	}

	public CameraParam GetCurrentCameraParam()
	{
		CameraParam result = default(CameraParam);
		result.height = transposer.m_FollowOffset.y;
		result.radius = 0f - transposer.m_FollowOffset.z;
		result.fov = virtualCamera.m_Lens.FieldOfView;
		result.deadZoneHeight = composer.m_DeadZoneHeight;
		result.deadZoneWidth = composer.m_DeadZoneWidth;
		result.softZoneHeight = composer.m_SoftZoneHeight;
		result.softZoneWidth = composer.m_SoftZoneWidth;
		result.screenY = composer.m_ScreenY;
		return result;
	}

	public CameraParam LerpCameraParam(CameraParam param1, CameraParam param2, float target, float total)
	{
		if (target <= 0f)
		{
			return param1;
		}
		if (target >= total)
		{
			return param2;
		}
		float num = target / total;
		CameraParam result = default(CameraParam);
		result.height = (param2.height - param1.height) * num + param1.height;
		result.radius = (param2.radius - param1.radius) * num + param1.radius;
		result.fov = (param2.fov - param1.fov) * num + param1.fov;
		result.deadZoneHeight = (param2.deadZoneHeight - param1.deadZoneHeight) * num + param1.deadZoneHeight;
		result.deadZoneWidth = (param2.deadZoneWidth - param1.deadZoneWidth) * num + param1.deadZoneWidth;
		result.softZoneHeight = (param2.softZoneHeight - param1.softZoneHeight) * num + param1.softZoneHeight;
		result.softZoneWidth = (param2.softZoneWidth - param1.softZoneWidth) * num + param1.softZoneWidth;
		result.screenY = (param2.screenY - param1.screenY) * num + param1.screenY;
		if (lockTarget)
		{
			offsetCom.m_Offset = (Vector3.zero - offsetCom.m_Offset) * num + offsetCom.m_Offset;
		}
		else
		{
			offsetCom.m_Offset = (offset - offsetCom.m_Offset) * num + offsetCom.m_Offset;
		}
		return result;
	}

	private void Update()
	{
		UpdateResetCamera();
		if (isRunning)
		{
			CameraParam cameraParam = LerpCameraParam(GetCurrentCameraParam(), targetParam, Time.deltaTime, leftTime);
			SetCameraParam(cameraParam);
			leftTime -= Time.deltaTime;
			if (leftTime <= 0f)
			{
				isRunning = false;
			}
		}
	}

	public bool RotateCameraToRoleaBack(Transform role)
	{
		if (virtualCamera == null)
		{
			return false;
		}
		m_xAxisTime = 0f;
		transposer.m_XAxis.Value = transposer.GetAxisClosestValue(role.position - role.forward * 20f, virtualCamera.State.ReferenceUp);
		return true;
	}

	public bool RotateCameraToRoleaBackWithTime(Transform role, float time)
	{
		if (virtualCamera == null)
		{
			return false;
		}
		m_targetXAxisValue = transposer.GetAxisClosestValue(role.position - role.forward * 20f, virtualCamera.State.ReferenceUp);
		m_xAxisTime = time;
		return true;
	}

	private void UpdateResetCamera()
	{
		if (m_xAxisTime > 0f)
		{
			float num = Mathf.Lerp(0f, m_targetXAxisValue, Time.deltaTime / m_xAxisTime);
			m_xAxisTime -= Time.deltaTime;
			if (m_xAxisTime < 0f)
			{
				num = m_targetXAxisValue;
			}
			m_targetXAxisValue -= num;
			transposer.m_XAxis.Value = num;
		}
	}
}
