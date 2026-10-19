using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinBlackViscousSwamp : BaseAbilityMixin
{
	private ConfigMixinBlackViscousSwamp _config;

	public AbilityMixinBlackViscousSwamp(ConfigMixinBlackViscousSwamp config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void OnAdd()
	{
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		_config = (ConfigMixinBlackViscousSwamp)config;
	}

	internal override void ResetForPool()
	{
		_config = null;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		CompMotion? compMotion = owner.GetCompMotion();
		compMotion.dodgeInAirCount = 0;
		compMotion.JumpInAirCount = 0;
		compMotion.SetBool("ForbidGlide", b: true);
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompMotion(out CompMotion component))
		{
			ConfigCharacter config = owner.GetConfig();
			if (config != null)
			{
				component.dodgeInAirCount = config.dogeInAirCount;
				component.JumpInAirCount = config.jumpInAirCount;
			}
			component.SetBool("ForbidGlide", b: false);
		}
	}

	internal override void OnSilentRemove()
	{
	}
}
