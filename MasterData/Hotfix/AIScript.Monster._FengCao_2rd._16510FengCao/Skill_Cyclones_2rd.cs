using System.Collections;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_Cyclones_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly string StartLookAT_Event = "StartLookAt";

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
		yield return BeginLookAt(AttackTarget, 0.2, 900);
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
