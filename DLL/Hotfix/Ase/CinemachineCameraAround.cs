using Cinemachine;
using UnityEngine;

namespace Ase;

[AddComponentMenu("")]
[ExecuteAlways]
[SaveDuringPlay]
public class CinemachineCameraAround : CinemachineExtension
{
	private float speed = 1f / 15f;

	private Quaternion target;

	private Quaternion current;

	private bool vaild;

	private CinemachineVirtualCamera cv;

	private void Start()
	{
		current = Quaternion.identity;
		vaild = base.VirtualCamera is CinemachineVirtualCamera;
		cv = base.VirtualCamera as CinemachineVirtualCamera;
	}

	private void Update()
	{
		if (vaild && base.VirtualCamera.LookAt != null && base.VirtualCamera.Follow != null)
		{
			current = Quaternion.Slerp(current, target, Time.deltaTime / speed);
			cv.GetCinemachineComponent<CinemachineOrbitalTransposer>().m_XAxis.Value = TSUtil.Angle2Limit(current.eulerAngles.y);
		}
	}

	private void FixedUpdate()
	{
		if (vaild && base.VirtualCamera.LookAt != null && base.VirtualCamera.Follow != null)
		{
			target = Quaternion.LookRotation((base.VirtualCamera.LookAt.position - base.VirtualCamera.Follow.position).ToVector2().ToVector3(), Vector3.up);
		}
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
	}
}
