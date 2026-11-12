#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Die_LD_Boat : SkillSimpleBase
{
	private static readonly string FxAlias = "fx_m31411_base_die";

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		SetHideModelEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		PlayEffect(FxAlias, 1f, default, GetPosition(), GetRotation(), 1f, actorScale: true);
		new List<LogicEntity>();
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			KillActors(targetsByFaction);
		}
		yield return WaitTime(4.5);
		NovaLogger.Debug("死亡技能结束");
	}
}
