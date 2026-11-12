#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50551CanCha;

public class Skill_TeamShooting_LD : SkillBaseCanCha
{
	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "IsMaster", value: true);
		NovaLogger.Debug("MiniBoss餐叉猪.射击矩阵技能.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("MiniBoss餐叉猪.射击矩阵技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			KillActors(targetsByFaction);
			yield return WaitTime(1);
		}
		UseMonsterCloneActorCastSkill(5055117);
	}
}
