using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinHPAction : BaseAbilityMixin
{
	private ConfigMixinHPAction m_Config;

	public AbilityMixinHPAction(ConfigMixinHPAction config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinHPAction)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtDamaged), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtDamaged && m_Config.hpActions.TryGetValue(owner.GetCompAbility().hp, out var value))
		{
			DoActions(owner, evt, value);
		}
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtDamaged), this);
	}
}
