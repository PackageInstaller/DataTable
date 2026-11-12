using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Born_NoEffect : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		TriggerOpLisener("BattleStart");
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		TSVector2 targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
		while (Distance(targetPOS, GetPosition()) >= 12)
		{
			targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
			yield return WaitTime(0.2);
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
