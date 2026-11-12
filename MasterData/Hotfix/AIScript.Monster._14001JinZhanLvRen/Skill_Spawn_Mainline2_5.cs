using System.Collections;
using TrueSync;

namespace AIScript.Monster._14001JinZhanLvRen;

public class Skill_Spawn_Mainline2_5 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagToggleValue(_actor, "BattleStart", value: false);
		SetLogicTagToggleValue(_actor, "AIStart", value: false);
		SetBattleOutEnable();
		while (!GetLogicTagToggleValue(_actor, "BattleStart"))
		{
			yield return null;
		}
		while (!GetLogicTagToggleValue(_actor, "AIStart"))
		{
			Skill_Spawn_Mainline2_5 skill_Spawn_Mainline2_ = this;
			TSVector2 position = GetPosition();
			skill_Spawn_Mainline2_.PlayEffect("Cheer", 1f, default, position);
			yield return WaitTime(GetRandomValue(1, 3));
		}
		SetBattleOutDisable();
		ShowBlood(isShow: true);
	}
}
