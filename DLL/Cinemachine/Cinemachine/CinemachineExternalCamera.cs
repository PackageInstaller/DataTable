using Cinemachine.Utility;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineExternalCamera.html")]
[AddComponentMenu("Cinemachine/CinemachineExternalCamera")]
[RequireComponent(typeof(Camera))]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[ExecuteAlways]
[DisallowMultipleComponent]
public class CinemachineExternalCamera : CinemachineVirtualCameraBase
{
	[Tooltip("The object that the camera is looking at.  Setting this will improve the quality of the blends to and from this camera")]
	[NoSaveDuringPlay]
	[VcamTargetProperty]
	public Transform m_LookAt;

	private Camera m_Camera;

	private CameraState m_State = CameraState.Default;

	[Tooltip("Hint for blending positions to and from this virtual camera")]
	[FormerlySerializedAs("m_PositionBlending")]
	public BlendHint m_BlendHint;

	public override CameraState State => m_State;

	public override Transform LookAt
	{
		get
		{
			return m_LookAt;
		}
		set
		{
			m_LookAt = value;
		}
	}

	public override Transform Follow { get; set; }

	public override void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		if (m_Camera == null)
		{
			TryGetComponent<Camera>(out m_Camera);
		}
		m_State = CameraState.Default;
		m_State.RawPosition = base.transform.position;
		m_State.RawOrientation = base.transform.rotation;
		m_State.ReferenceUp = m_State.RawOrientation * Vector3.up;
		if (m_Camera != null)
		{
			m_State.Lens = LensSettings.FromCamera(m_Camera);
		}
		if (m_LookAt != null)
		{
			m_State.ReferenceLookAt = m_LookAt.transform.position;
			Vector3 vector = m_State.ReferenceLookAt - State.RawPosition;
			if (!vector.AlmostZero())
			{
				m_State.ReferenceLookAt = m_State.RawPosition + Vector3.Project(vector, State.RawOrientation * Vector3.forward);
			}
		}
		ApplyPositionBlendMethod(ref m_State, m_BlendHint);
		InvokePostPipelineStageCallback(this, CinemachineCore.Stage.Finalize, ref m_State, deltaTime);
	}
}
