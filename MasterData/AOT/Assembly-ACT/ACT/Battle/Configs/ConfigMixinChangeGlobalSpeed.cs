using ACT.Utility;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("全局速度效果", "Mixin", new string[] { "change", "global", "speed" })]
public class ConfigMixinChangeGlobalSpeed : ConfigMixin
{
	public AllianceCondition alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public TimeType timeType;

	[HideInInspector]
	public SystemTime.ConfigChangeGlobalSpeed configChangeGlobalSpeed;

	public BaseFindTargets additionalFindTargets;

	public bool affectWorldRuntime;

	private float Speed
	{
		get
		{
			return configChangeGlobalSpeed.speed;
		}
		set
		{
			configChangeGlobalSpeed.speed = value;
		}
	}

	private float EaseTime
	{
		get
		{
			return configChangeGlobalSpeed.easeTime;
		}
		set
		{
			configChangeGlobalSpeed.easeTime = ((value < 0f) ? 0f : value);
		}
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinChangeGlobalSpeed(this, ab, index);
	}
}
