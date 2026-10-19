using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinGetCurrentAttacker : BaseAbilityMixin
{
	private ConfigMixinGetCurrentAttacker m_ConfigMixinGetCurrentAttacker;

	public AbilityMixinGetCurrentAttacker(ConfigMixinGetCurrentAttacker config, Ability ab, byte index)
		: base(ab, index)
	{
		m_ConfigMixinGetCurrentAttacker = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_ConfigMixinGetCurrentAttacker = (ConfigMixinGetCurrentAttacker)config;
	}

	internal override void ResetForPool()
	{
		m_ConfigMixinGetCurrentAttacker = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtDamaged), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtDamaged)
		{
			EvtDamaged evtDamaged = evt as EvtDamaged;
			DoActions(evtDamaged.attackData.attacker, evt, m_ConfigMixinGetCurrentAttacker.actions);
		}
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtDamaged), this);
	}
}
