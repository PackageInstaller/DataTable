#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_Throw_LD : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly FP Inr = 0.3;

	private readonly string FxAlias = "Seed_ShootDown";

	private TSVector2 PosOrigin;

	private TSVector2 Pos01;

	private TSVector2 Pos02;

	private TSVector2 Pos03;

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
			Pos01 = new TSVector2(0, 3) + PosOrigin;
			Pos02 = new TSVector2(3, -3) + PosOrigin;
			Pos03 = new TSVector2(-3, -3) + PosOrigin;
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
		yield return WaitTime(Inr);
		InterruptSkill();
		NovaLogger.Debug("技能结束");
	}
}
