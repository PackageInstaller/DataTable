using System.ComponentModel;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行手柄震动", "Action", new string[] { "gamepad", "rumble", "camera", "fov", "volume" })]
public class ActionGamepadRumble : ConfigAction
{
	public GamepadRumbleCurvePreset curvePreset;

	public float amplitudeMultiplier = 1f;

	public bool loop;

	public float loopTime = -1f;

	public bool enableDurationOverride;

	[DefaultValue(0.01f)]
	public float durationOverride;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		if (!(curvePreset == null))
		{
			float duration = ((enableDurationOverride && durationOverride > 0f) ? durationOverride : curvePreset.duration);
			float value = (float)SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.GamepadRumble").GetValue() / 10f;
			value = Mathf.Clamp(value, 0f, 2f);
			GamepadRumbleManager.Play(curvePreset, duration, amplitudeMultiplier * value, loop, loopTime);
		}
	}
}
