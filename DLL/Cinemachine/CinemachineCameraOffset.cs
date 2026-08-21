using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

[SaveDuringPlay]
[AddComponentMenu("")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/api/Cinemachine.CinemachineCameraOffset.html")]
[ExecuteAlways]
public class CinemachineCameraOffset : CinemachineExtension
{
	[Tooltip("Offset the camera's position by this much (camera space)")]
	public Vector3 m_Offset = Vector3.zero;

	[Tooltip("When to apply the offset")]
	public CinemachineCore.Stage m_ApplyAfter = CinemachineCore.Stage.Aim;

	[Tooltip("If applying offset after aim, re-adjust the aim to preserve the screen position of the LookAt target as much as possible")]
	public bool m_PreserveComposition;

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage == m_ApplyAfter)
		{
			bool num = m_PreserveComposition && state.HasLookAt && stage > CinemachineCore.Stage.Body;
			Vector3 vector = Vector2.zero;
			if (num)
			{
				vector = state.RawOrientation.GetCameraRotationToTarget(state.ReferenceLookAt - state.CorrectedPosition, state.ReferenceUp);
			}
			Vector3 vector2 = state.RawOrientation * m_Offset;
			state.PositionCorrection += vector2;
			if (!num)
			{
				state.ReferenceLookAt += vector2;
				return;
			}
			Quaternion orient = Quaternion.LookRotation(state.ReferenceLookAt - state.CorrectedPosition, state.ReferenceUp);
			orient = orient.ApplyCameraRotation(-vector, state.ReferenceUp);
			state.RawOrientation = orient;
		}
	}
}
