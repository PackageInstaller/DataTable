using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("飘字类型", 0)]
[Category("Render/UI")]
[Description("获取飘字类型,返回该用哪一种飘法\nisUniqueSkill列表中的ID会被强制视为奥义类型")]
[ExposeAsDefinition]
public class GetHPTipsType : CallableFunctionNode<HPTipsType, DamageType, int, int, int, int, List<int>>
{
	public override HPTipsType Invoke(DamageType damageType, int injuredEntityID, int attackerEntityID, int value, int abilityID, List<int> isUniqueSkill)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		AgentManager agentManager = battleScene.GetAgentManager();
		NAgent agent = agentManager.GetAgent(injuredEntityID);
		switch (damageType)
		{
		case DamageType.Immune:
			return HPTipsType.Immune;
		case DamageType.Missing:
			return HPTipsType.Miss;
		case DamageType.Absorb:
			return HPTipsType.Invalid;
		case DamageType.Defense:
			return HPTipsType.DefendDamage;
		default:
		{
			if (null != agent)
			{
				switch (damageType)
				{
				case DamageType.Recover:
					return HPTipsType.AddHP;
				case DamageType.CritRecover:
					return HPTipsType.CritAddHP;
				}
				if (RoleCampProcessor.IsPlayer(agent.Camp) || agent.Camp == 128)
				{
					return HPTipsType.PlayerGetDamage;
				}
			}
			NAgent agent2 = agentManager.GetAgent(attackerEntityID);
			if (agent2 != null && RoleCampProcessor.IsPlayer(agent2.Camp))
			{
				if ((ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(agent2.AgentConfigID, out var config) && (config.AbilityId.Contains(abilityID) || config.Projectiles.Contains(abilityID) || (isUniqueSkill != null && isUniqueSkill.Contains(abilityID)))) || (battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID != 0 && ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID, out var config2) && config2.CooperateThrownIds.Contains(abilityID)))
				{
					switch (damageType)
					{
					case DamageType.Crit:
					case DamageType.HighDamageCrit:
						if (attackerEntityID == agentManager.mPlayerAgentID)
						{
							return HPTipsType.UniqueSkillCrit;
						}
						return HPTipsType.TeammateUniqueSkillCrit;
					case DamageType.Damage:
					case DamageType.HighDamage:
						if (attackerEntityID == agentManager.mPlayerAgentID)
						{
							return HPTipsType.UniqueSkill;
						}
						return HPTipsType.TeammateUniqueSkill;
					}
				}
				if (attackerEntityID == agentManager.mPlayerAgentID)
				{
					switch (damageType)
					{
					case DamageType.Crit:
						return HPTipsType.CritDamage;
					case DamageType.HighDamage:
						return HPTipsType.HighDamage;
					case DamageType.HighDamageCrit:
						return HPTipsType.CritHighDamage;
					default:
						_ = 1;
						return HPTipsType.NormalDamage;
					}
				}
				if (damageType == DamageType.Crit || damageType == DamageType.HighDamageCrit)
				{
					return HPTipsType.TeammateCrit;
				}
				return HPTipsType.Teammate;
			}
			return HPTipsType.NormalDamage;
		}
		}
	}
}
