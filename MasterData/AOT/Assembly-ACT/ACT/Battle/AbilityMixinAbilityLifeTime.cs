using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinAbilityLifeTime : BaseAbilityMixin
{
	public ConfigMixinAbilityLifetime config;

	public AbilityMixinAbilityLifeTime(ConfigMixinAbilityLifetime configMixinAbilityLifetime, Ability ab, byte index)
		: base(ab, index)
	{
		config = configMixinAbilityLifetime;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinAbilityLifetime)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility()?.AddListener(typeof(EvtMotionChange), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtMotionChange), this);
	}

	internal override void OnSilentRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtMotionChange), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtMotionChange))
		{
			return;
		}
		EvtMotionChange evtMotionChange = (EvtMotionChange)evt;
		bool flag = false;
		if (config == null || config.motions == null)
		{
			return;
		}
		string[] motions = config.motions;
		for (int i = 0; i < motions.Length; i++)
		{
			if (motions[i] == evtMotionChange.to)
			{
				flag = true;
			}
		}
		if (!flag)
		{
			ability.RemoveStack(ability.stack);
		}
	}
}
