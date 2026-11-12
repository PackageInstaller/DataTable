using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Attack_ShortLong : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StopLookAT_Event = "StopLookAt";

	private LogicEntity AttackTarget;

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
		int rand = TSRandom.Range(0, 100);
		int probabilityThreshold1 = 50;
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(AttackTarget), 0.2, 300);
		if (rand < probabilityThreshold1)
		{
			BeginAttack(1, _actionKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(2, _actionKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
