using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Hide : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Z,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string KillActors_Event = "KillActors";

	private List<LogicEntity> KillTarget = new List<LogicEntity>();

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AddBuffToTarget(_actor, 990010050);
		AttackTarget = GetAttackTarget();
		KillTarget.Clear();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCustomEvent(KillActors_Event);
		AddBuffToTarget(_actor, 990010040);
		yield return WaitTime(0.03f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
