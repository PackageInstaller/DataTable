using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

internal class AbilityMixinIntervalDamage : BaseAbilityMixin
{
	private ConfigMixinIntervalDamage m_Config;

	private float m_Interval;

	public AbilityMixinIntervalDamage(ConfigMixinIntervalDamage config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_Interval = -1f;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinIntervalDamage)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Interval = -1f;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		if (owner.IsAlive())
		{
			m_Interval -= owner.GetCompTime().fixedDeltaTime;
			if (m_Interval < 0f)
			{
				CompAbility compAbility = owner.GetCompAbility();
				m_Interval = m_Config.damageInterval;
				int num = 3 + 50 * compAbility.level / (compAbility.level + 10);
				SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
				AttackData attackData = systemAbility.GetAttackData();
				attackData.damage = num;
				attackData.attacker = owner;
				attackData.attackee = owner;
				attackData.hitEndureLevel = 0;
				attackData.element = m_Config.element;
				Singleton<GameManager>.instance.ecsManager.systemAbility.ServerResolveDamage(attackData, ability);
				owner.SetInt("HitLevel", 0);
				systemAbility.ReleaseAttackData(attackData);
			}
		}
	}
}
