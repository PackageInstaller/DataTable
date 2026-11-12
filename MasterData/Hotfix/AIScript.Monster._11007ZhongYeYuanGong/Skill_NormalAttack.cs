using System.Collections;
using TrueSync;

namespace AIScript.Monster._11007ZhongYeYuanGong;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] _actionKey_2 = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private FP ChargeTime = 2;

	private FP PerChargeTime = 0.2;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey_1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (FP t = 0; t < ChargeTime; t += PerChargeTime)
		{
			LogicEntity attackTarget = GetAttackTarget();
			if (!attackTarget)
			{
				break;
			}
			yield return BeginLookAt(attackTarget, 0, 60);
			yield return WaitTime(PerChargeTime);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
