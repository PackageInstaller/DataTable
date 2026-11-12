using System.Collections;

namespace AIScript.Monster._17031ZhongNuJingYingQiShi;

public class SPDeathIn9_1 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		PlayEffect("fx_switch_monster_actor", 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(1);
		SetHideModelEnable();
		yield return WaitTime(1);
	}
}
