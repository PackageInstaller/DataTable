using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class MainLine_Skill_Born : SkillSimpleBase
{
	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 700010010, 99);
		AddBuffToTarget(_actor, 700010013, 2);
		yield return WaitTime(1);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
