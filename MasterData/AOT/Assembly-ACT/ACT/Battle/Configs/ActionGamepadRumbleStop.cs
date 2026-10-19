namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行手柄震动Stop", "Action", new string[] { "gamepad", "rumble", "stop", "camera", "fov", "volume" })]
public class ActionGamepadRumbleStop : ConfigAction
{
	public GamepadRumbleCurvePreset curvePreset;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		GamepadRumbleManager.Stop(curvePreset);
	}
}
