using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinSkillCountModifier : BaseAbilityMixin
{
	private ConfigMixinSkillCountModifier m_Config;

	public AbilityMixinSkillCountModifier(ConfigMixinSkillCountModifier config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinSkillCountModifier)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		if (!owner.HasCompAbility())
		{
			return;
		}
		foreach (Skill skill in owner.GetCompMotion().skills)
		{
			if (!(skill.config.name != m_Config.skillName))
			{
				skill.AddSkillCountModifier(ability.config.name, m_Config.addCount);
			}
		}
	}

	internal override void OnRemove()
	{
		if (!owner.HasCompAbility())
		{
			return;
		}
		foreach (Skill skill in owner.GetCompMotion().skills)
		{
			if (!(skill.config.name != m_Config.skillName))
			{
				skill.RemoveSkillCountModifier(ability.config.name);
			}
		}
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}
}
