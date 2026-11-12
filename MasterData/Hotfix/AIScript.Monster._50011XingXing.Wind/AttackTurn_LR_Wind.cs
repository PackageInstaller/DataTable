using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

public class AttackTurn_LR_Wind : SkillScript_Base
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StartLookAT_Event = "StartLookAt";

	private static readonly string AreaEffectAlias = "Wind_Attack_Bullet";

	private readonly string lightSpawnFxAlias = "fx_m50011_loop_ground_wind_born";

	private LogicEntity AttackTarget;

	private static FP AngleOfIncline;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (AngleOfIncline >= 0)
		{
			BeginAttack(1, _actionKey1, flushInputedKeys: true);
			ElementalSkill();
			yield return WaitCombo(ComboAttackType.isRecoveryBegin);
			BeginLookAt_NotWait(AttackTarget, 0.5, 540);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(2, _actionKey2, flushInputedKeys: true);
			ElementalSkill();
			yield return WaitCombo(ComboAttackType.isRecoveryBegin);
			BeginLookAt_NotWait(AttackTarget, 0.5, 540);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void ElementalSkill()
	{
		int aiType = GetAiType();
		if (aiType != 0 && aiType == 1)
		{
			StartCor(LongJuanFeng());
		}
	}
}
