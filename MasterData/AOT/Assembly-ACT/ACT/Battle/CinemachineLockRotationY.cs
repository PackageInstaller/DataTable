using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class CinemachineLockRotationY : CinemachineExtension
{
	[SerializeField]
	private float rotationY;

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage == CinemachineCore.Stage.Finalize)
		{
			Vector3 eulerAngles = state.RawOrientation.eulerAngles;
			eulerAngles.y = rotationY;
			state.RawOrientation = Quaternion.Euler(eulerAngles);
		}
	}
}
