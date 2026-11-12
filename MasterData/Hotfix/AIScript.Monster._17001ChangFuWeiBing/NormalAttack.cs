using System.Collections;
using TrueSync;

namespace AIScript.Monster._17001ChangFuWeiBing;

public class NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private ComboInputBuffer.ActionKey[] _actionkey;

	private readonly int checkbuff = 170210010;

	private readonly FP combotime = 1.8f;

	private readonly FP aimtime = 0.5f;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget(isUpToDate: true);
		if (!(target == null))
		{
			BeginLookAt_NotWait(target, 0.4, 240);
			yield return WaitTime(0.4);
			if (GetBuffNum(_actor, checkbuff) != 0)
			{
				_actionkey = Attack_Combo;
			}
			else
			{
				_actionkey = Attack_Combo3;
			}
			BeginAttack(1, _actionkey, flushInputedKeys: true, forceInterruptAttack: true);
			AimAtTarget(GetAttackTarget(isUpToDate: true), 120);
			yield return WaitTime(aimtime);
			CancelAim();
			yield return WaitTime(1.45f);
			if (GetBuffNum(_actor, checkbuff) != 0)
			{
				BeginAttack(2, Attack_Combo2, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAt_NotWait(target, 0.3, 300);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}
}
