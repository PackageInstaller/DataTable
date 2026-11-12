#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_Throw_Daily : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly FP Inr = 0.3;

	private readonly string FxAlias = "Seed_ShootDown";

	private TSVector2 PosOrigin;

	private TSVector2 Pos01;

	private TSVector2 Pos02;

	private TSVector2 Pos03;

	private TSVector2 Pos04;

	private TSVector2 Pos05;

	private TSVector2 Pos06;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.5);
		CancelAttack();
		if (GetAttackTarget() != null)
		{
			PosOrigin = GetEntityPositionObsoleted(GetAttackTarget());
			Pos01 = new TSVector2(0, 4) + PosOrigin;
			Pos02 = new TSVector2(2.8, -2) + PosOrigin;
			Pos03 = new TSVector2(-2.8, -2) + PosOrigin;
			Pos04 = new TSVector2(0, -4) + PosOrigin;
			Pos05 = new TSVector2(2.8, 2) + PosOrigin;
			Pos06 = new TSVector2(-2.8, 2) + PosOrigin;
		}
		else
		{
			yield return WaitCombo(ComboAttackType.isComboFinish);
			InterruptSkill();
		}
		yield return WaitTime(Inr);
		PlayAreaEffect(FxAlias, Pos01, 0);
		PlayAreaEffect(FxAlias, Pos02, 0);
		PlayAreaEffect(FxAlias, Pos03, 0);
		PlayAreaEffect(FxAlias, Pos04, 0);
		PlayAreaEffect(FxAlias, Pos05, 0);
		PlayAreaEffect(FxAlias, Pos06, 0);
		yield return WaitTime(Inr);
		InterruptSkill();
		NovaLogger.Debug("技能结束");
	}
}
