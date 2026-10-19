using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class CinemachineLockRotationX : CinemachineExtension
{
	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage == CinemachineCore.Stage.Finalize)
		{
			Vector3 eulerAngles = state.RawOrientation.eulerAngles;
			eulerAngles.x = 0f;
			state.RawOrientation = Quaternion.Euler(eulerAngles);
		}
	}
}
