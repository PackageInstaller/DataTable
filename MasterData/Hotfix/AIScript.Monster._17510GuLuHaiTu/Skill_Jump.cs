#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Jump : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetImmuneControlEnable();
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		NovaLogger.Debug("海浪鱼出生");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Jump", flushInputedKeys: true, forceInterruptAttack: true);
		BeginDash(10, GetForward(), 17, 40, 1, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitTime(1.4);
		List<LogicEntity> entities = new List<LogicEntity> { _actor };
		CancelAttack();
		ClearActors(entities);
	}
}
