using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_Death : SkillSimpleBase
{
	private static readonly string Dash_Message = "CastDashSkill";

	private static readonly string FlyUp_Message = "CastFlyUpSkill";

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		string logicTagStringValue = GetLogicTagStringValue(_actor, "SkillMessage");
		if (logicTagStringValue == Dash_Message)
		{
			PlayEffect("DashDie", 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.6)), -GetRotation(), 1.5f);
		}
		else
		{
			_ = logicTagStringValue == FlyUp_Message;
		}
		yield break;
	}
}
