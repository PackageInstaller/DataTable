using System.Collections;

namespace AIScript.Monster._50261FengLing;

public class Skill_ShootAttack : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 3.5, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
