using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineFocusContext : CinemachineExtension
{
	public enum Mode
	{
		Default,
		Simple
	}

	public Mode mode;

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
	}
}
