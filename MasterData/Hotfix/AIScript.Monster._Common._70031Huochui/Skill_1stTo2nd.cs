using System.Collections;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_1stTo2nd : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.W,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private LogicEntity MonsterTarget;

	private static readonly string FuYouJianDead_Event = "FuYouJianDead";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		if (GetTargetByTeammateIndex(1).Count == 1)
		{
			MonsterTarget = GetTargetByTeammateIndex(1).get_Item(0);
		}
		else
		{
			MonsterTarget = _actor;
		}
		SetLockToughnessEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		yield return WaitCustomEvent(FuYouJianDead_Event);
		AddBuffToTarget(MonsterTarget, 700310040);
		if (GetTargetByTeammateIndex(1).Count > 0)
		{
			KillActors(GetTargetByTeammateIndex(1));
			yield return WaitTime(1);
		}
		RemoveBuffFromTarget(_actor, 700310010);
		RemoveBuffFromTarget(_actor, 700310020);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLockToughnessDisable();
	}

	protected override void OnSkillDisable()
	{
		SetLockToughnessDisable();
	}
}
