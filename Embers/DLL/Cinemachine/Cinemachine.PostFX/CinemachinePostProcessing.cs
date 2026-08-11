using UnityEngine;

namespace Cinemachine.PostFX;

[SaveDuringPlay]
[AddComponentMenu("")]
public class CinemachinePostProcessing : CinemachineExtension
{
	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
	}
}
