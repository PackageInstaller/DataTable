#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_UltimateShoot_Vampire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] _actionKey_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private FP ShootPoint_y = 10;

	private FP ChargeTime = 2;

	private FP PerChargeTime = 0.2;

	private TSVector2 AimPoint;

	private TSVector2 KillPos = new TSVector2(0, 30);

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("MiniBoss餐叉猪.UltimateShoot.开始");
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, _actionKey_1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		AimAtTarget(target, 80);
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1));
		PlayEffect("AttackHint", 0.8f, 1.8, position);
		yield return WaitTime(2.5);
		CancelAim();
		BeginAttack(1, _actionKey_2);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
