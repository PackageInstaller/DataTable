using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinBattleEntityAddBuff : BaseAbilityMixin
{
	private ConfigMixinBattleEntityAddBuff m_Config;

	private Entity battleEntity;

	public AbilityMixinBattleEntityAddBuff(ConfigMixinBattleEntityAddBuff config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinBattleEntityAddBuff)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		battleEntity = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtBattleChange), this);
		battleEntity = MPPlayer.local.battleEntity;
		CompAbility compAbility = battleEntity.GetCompAbility();
		compAbility.AddAbility(caster, m_Config.ability, AbilitySource.Ability, ability.skillLevelInfo, 1);
		string[] abilities = m_Config.abilities;
		foreach (string abName in abilities)
		{
			compAbility.AddAbility(caster, abName, AbilitySource.Ability, ability.skillLevelInfo, 1);
		}
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (evt is EvtBattleChange evtBattleChange)
		{
			CompAbility compAbility = evtBattleChange.last.GetCompAbility();
			compAbility.RemoveAbility(m_Config.ability);
			string[] abilities = m_Config.abilities;
			foreach (string name in abilities)
			{
				compAbility.RemoveAbility(name);
			}
			CompAbility compAbility2 = evtBattleChange.next.GetCompAbility();
			compAbility2.AddAbility(caster, m_Config.ability, AbilitySource.Ability, ability.skillLevelInfo, 1);
			abilities = m_Config.abilities;
			foreach (string abName in abilities)
			{
				compAbility2.AddAbility(caster, abName, AbilitySource.Ability, ability.skillLevelInfo, 1);
			}
			battleEntity = evtBattleChange.next;
		}
	}

	internal override void OnRemove()
	{
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveListener(typeof(EvtBattleChange), this);
		CompAbility compAbility = battleEntity.GetCompAbility();
		compAbility.RemoveAbility(m_Config.ability);
		string[] abilities = m_Config.abilities;
		foreach (string name in abilities)
		{
			compAbility.RemoveAbility(name);
		}
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}
}
