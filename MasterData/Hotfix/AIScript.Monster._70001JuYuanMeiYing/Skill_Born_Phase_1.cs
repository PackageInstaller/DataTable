using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Born_Phase_1 : SkillSimpleBase
{
	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, 700010010) == 0 && GetBuffNum(_actor, 700010014) == 0)
		{
			if (GetMonsterTagValue(_actor, 1) == "Lv1")
			{
				AddBuffToTarget(_actor, 700010010, 40);
				AddBuffToTarget(_actor, 700010013, 2);
			}
			if (GetMonsterTagValue(_actor, 1) == "Lv2")
			{
				AddBuffToTarget(_actor, 700010010, 40);
				AddBuffToTarget(_actor, 700010013, 2);
			}
			if (GetMonsterTagValue(_actor, 1) == "Lv3")
			{
				AddBuffToTarget(_actor, 700010010, 40);
				AddBuffToTarget(_actor, 700010013, 2);
			}
			if (GetMonsterTagValue(_actor, 1) == "Lv4")
			{
				AddBuffToTarget(_actor, 700010010, 60);
				AddBuffToTarget(_actor, 700010013, 2);
			}
			if (GetMonsterTagValue(_actor, 1) == "Lv5")
			{
				AddBuffToTarget(_actor, 700010010, 80);
				AddBuffToTarget(_actor, 700010013, 2);
			}
		}
		yield return WaitTime(1);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
