using Cinemachine;
using UnityEngine;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineRecomposer.html")]
[SaveDuringPlay]
[ExecuteAlways]
[AddComponentMenu("")]
public class CinemachineRecomposer : CinemachineExtension
{
	[Tooltip("When to apply the adjustment")]
	public CinemachineCore.Stage m_ApplyAfter;

	[Tooltip("Tilt the camera by this much")]
	public float m_Tilt;

	[Tooltip("Pan the camera by this much")]
	public float m_Pan;

	[Tooltip("Roll the camera by this much")]
	public float m_Dutch;

	[Tooltip("Scale the zoom by this amount (normal = 1)")]
	public float m_ZoomScale;

	[Tooltip("Lowering this value relaxes the camera's attention to the Follow target (normal = 1)")]
	[Range(0f, 1f)]
	public float m_FollowAttachment;

	[Range(0f, 1f)]
	[Tooltip("Lowering this value relaxes the camera's attention to the LookAt target (normal = 1)")]
	public float m_LookAtAttachment;

	private void Reset()
	{
		m_ApplyAfter = CinemachineCore.Stage.Finalize;
		m_Tilt = 0f;
		m_Pan = 0f;
		m_Dutch = 0f;
		m_ZoomScale = 1f;
		m_FollowAttachment = 1f;
		m_LookAtAttachment = 1f;
	}

	private void OnValidate()
	{
		m_ZoomScale = Mathf.Max(0.01f, m_ZoomScale);
		m_FollowAttachment = Mathf.Clamp01(m_FollowAttachment);
		m_LookAtAttachment = Mathf.Clamp01(m_LookAtAttachment);
	}

	public override void PrePipelineMutateCameraStateCallback(CinemachineVirtualCameraBase vcam, ref CameraState curState, float deltaTime)
	{
		vcam.FollowTargetAttachment = m_FollowAttachment;
		vcam.LookAtTargetAttachment = m_LookAtAttachment;
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage == m_ApplyAfter)
		{
			LensSettings lens = state.Lens;
			Quaternion quaternion = state.RawOrientation * Quaternion.AngleAxis(m_Tilt, Vector3.right);
			Quaternion quaternion2 = Quaternion.AngleAxis(m_Pan, state.ReferenceUp) * quaternion;
			state.OrientationCorrection = Quaternion.Inverse(state.CorrectedOrientation) * quaternion2;
			lens.Dutch += m_Dutch;
			if (m_ZoomScale != 1f)
			{
				lens.OrthographicSize *= m_ZoomScale;
				lens.FieldOfView *= m_ZoomScale;
			}
			state.Lens = lens;
		}
	}
}
