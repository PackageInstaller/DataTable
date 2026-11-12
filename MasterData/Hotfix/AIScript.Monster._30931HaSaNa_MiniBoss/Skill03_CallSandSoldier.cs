using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill03_CallSandSoldier : SkillSimpleBase
{
	private static readonly string QuickCasting = "QuickCasting";

	private FP SignX;

	private TSVector2 SpawnDir;

	private bool SoldierPos;

	protected override void OnSkillEnable()
	{
		switch (randomWeight(new int[2] { 1, 1 }))
		{
		case 0:
			SignX = -1;
			SpawnDir = new TSVector2(1, 0);
			break;
		case 1:
			SignX = 1;
			SpawnDir = new TSVector2(-1, 0);
			break;
		}
		switch (randomWeight(new int[2] { 1, 1 }))
		{
		case 0:
			SoldierPos = true;
			break;
		case 1:
			SoldierPos = false;
			break;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, QuickCasting, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Call");
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			if (GetLogicTagStringValue(_actor, "SkillLv") == "SkillLv_1")
			{
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 2.92));
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -2.92));
				yield return WaitTime(0.5);
				SummonTeammate(2, new TSVector2(SignX * 12, 2.92), SpawnDir);
				SummonTeammate(2, new TSVector2(SignX * 12, -2.92), SpawnDir);
			}
			else if (SoldierPos)
			{
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 6.25));
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 1.25));
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -3.75));
				yield return WaitTime(0.5);
				SummonTeammate(2, new TSVector2(SignX * 12, 6.25), SpawnDir);
				SummonTeammate(2, new TSVector2(SignX * 12, 1.25), SpawnDir);
				SummonTeammate(2, new TSVector2(SignX * 12, -3.75), SpawnDir);
			}
			else
			{
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 3.75));
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -1.25));
				PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -6.25));
				yield return WaitTime(0.5);
				SummonTeammate(2, new TSVector2(SignX * 12, 3.75), SpawnDir);
				SummonTeammate(2, new TSVector2(SignX * 12, -1.25), SpawnDir);
				SummonTeammate(2, new TSVector2(SignX * 12, -6.25), SpawnDir);
			}
		}
		else
		{
			PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, 2.92));
			PlayEarlyWarningEffect("fx_warning_circular_2", 0.5f, 0, new TSVector2(SignX * 12, -2.92));
			yield return WaitTime(0.5);
			SummonTeammate(2, new TSVector2(SignX * 12, 2.92), SpawnDir);
			SummonTeammate(2, new TSVector2(SignX * 12, -2.92), SpawnDir);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
