using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill5_XuanZhuan : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected FP rolltime;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 0.2, 300);
		yield return WaitTime(0.2);
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		if (_actor.buffComponent.CheckBuffByBuffID(505810099))
		{
			rolltime = 5;
		}
		else
		{
			rolltime = 3;
		}
		yield return WaitTime(rolltime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
