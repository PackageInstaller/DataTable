using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行镜头视野", "Action", new string[] { "camera", "fov", "volume" })]
public class ActionCameraFOV : ConfigAction
{
	public enum ChangeCameraFOVType
	{
		UseLibrary,
		Custom
	}

	public ChangeCameraFOVType changeCameraFOVType;

	public uint curve;

	public AnimationCurve curveCustom;

	public float duration;

	public TimeScale timeScale = TimeScale.NoScale;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Do(ActionMemory memory)
	{
	}
}
