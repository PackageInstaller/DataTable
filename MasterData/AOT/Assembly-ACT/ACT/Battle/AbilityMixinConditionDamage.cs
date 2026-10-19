using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinConditionDamage : BaseAbilityMixin
{
	public ConfigMixinConditionDamage config;

	public AbilityMixinConditionDamage(ConfigMixinConditionDamage ConfigMixinConditionDamage, Ability ab, byte index)
		: base(ab, index)
	{
		config = ConfigMixinConditionDamage;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinConditionDamage)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtSetActualDamage), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtSetActualDamage evtSetActualDamage))
		{
			return;
		}
		ConfigPredicate[] configPredicateList = config.configPredicateList;
		foreach (ConfigPredicate configPredicate in configPredicateList)
		{
			if (configPredicate.Inverse ? (!configPredicate.Check(new ActionMemory(caster, owner, owner, evt, ability))) : configPredicate.Check(new ActionMemory(caster, owner, owner, evt, ability)))
			{
				return;
			}
		}
		evtSetActualDamage.attackData.damage = 0f;
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtSetActualDamage), this);
	}
}
