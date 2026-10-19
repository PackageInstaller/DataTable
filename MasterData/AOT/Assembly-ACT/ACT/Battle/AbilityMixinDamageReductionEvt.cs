using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinDamageReductionEvt : BaseAbilityMixin
{
	public ConfigMixinDamageReductionEvt config;

	public AbilityMixinDamageReductionEvt(ConfigMixinDamageReductionEvt config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinDamageReductionEvt)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility()?.AddListener(typeof(EvtAttackeeModifyDamage), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtAttackeeModifyDamage), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtAttackeeModifyDamage)
		{
			EvtAttackeeModifyDamage evtAttackeeModifyDamage = evt as EvtAttackeeModifyDamage;
			int element = (int)evtAttackeeModifyDamage.attackData.element;
			int num = 1 << element;
			int element2 = (int)config.element;
			if (((num & element2) > 0 && !config.inverse) || ((num & element2) == 0 && config.inverse))
			{
				evtAttackeeModifyDamage.attackData.finalPhaseMul *= config.damageReduction;
			}
		}
	}
}
