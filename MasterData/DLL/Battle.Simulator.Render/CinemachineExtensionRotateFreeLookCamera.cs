using System;
using System.Reflection;
using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

public class CinemachineExtensionRotateFreeLookCamera : CinemachineExtension
{
	[Tooltip("相机绕y轴的旋转角度")]
	public float rotateDegreeAroundYAxis;

	[Tooltip("相机的旋转速度")]
	public float rotateSpeed;

	public float rotateSpeedAroundX;

	public float rotateDegreeAroundXAxis;

	public CameraParamComponent virtualCameraParam;

	private void Start()
	{
		if (virtualCameraParam == null)
		{
			virtualCameraParam = GetComponent<CameraParamComponent>();
		}
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
	}

	public void SetComposerValue(CinemachineComposer composer, CinemachineVirtualCamera virtualCamera, Quaternion quaternion)
	{
		Type type = composer.GetType();
		type.GetField("m_CameraOrientationPrevFrame", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(composer, quaternion);
		type.GetField("m_ScreenOffsetPrevFrame", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(composer, quaternion.GetCameraRotationToTarget((Vector3)type.GetField("m_LookAtPrevFrame", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(composer) - virtualCamera.State.CorrectedPosition, virtualCamera.State.ReferenceUp));
	}
}
