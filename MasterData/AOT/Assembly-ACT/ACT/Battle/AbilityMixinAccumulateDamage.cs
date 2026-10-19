using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinAccumulateDamage : BaseAbilityMixin
{
	private ConfigMixinAccumulateDamage m_Config;

	private float m_AccumulatedDamage;

	public AbilityMixinAccumulateDamage(ConfigMixinAccumulateDamage config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_AccumulatedDamage = 0f;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinAccumulateDamage)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_AccumulatedDamage = 0f;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		if (m_Config.accumulateType == EAccumulateDamageType.Damage)
		{
			owner.GetCompAbility().AddListener(typeof(EvtSetActualDamage), this);
		}
		else
		{
			owner.GetCompAbility().AddListener(typeof(EvtDamaged), this);
		}
	}

	internal override void OnRemove()
	{
		if (m_Config.accumulateType == EAccumulateDamageType.Damage)
		{
			owner.GetCompAbility().RemoveListener(typeof(EvtSetActualDamage), this);
		}
		else
		{
			owner.GetCompAbility().RemoveListener(typeof(EvtDamaged), this);
		}
		if (owner.HasCompAbility())
		{
			EvtAccumulateDamage evt = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<EvtAccumulateDamage>(owner, ability);
			evt.mainEntity = owner;
			evt.ownerEntity = owner;
			evt.attackee = owner;
			evt.AccumulatedDamage = m_AccumulatedDamage;
			Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt);
			Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt);
		}
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (m_Config.accumulateType == EAccumulateDamageType.Damage)
		{
			if (evt is EvtSetActualDamage)
			{
				int actualDamage = ((EvtSetActualDamage)evt).attackData.actualDamage;
				m_AccumulatedDamage += actualDamage;
			}
		}
		else if (evt is EvtDamaged)
		{
			float damage = ((EvtDamaged)evt).attackData.damage;
			m_AccumulatedDamage += damage;
		}
	}
}
