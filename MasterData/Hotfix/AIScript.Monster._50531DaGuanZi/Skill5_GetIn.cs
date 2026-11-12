using System.Collections;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill5_GetIn : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly FP summonRadius = 5f;

	private readonly int summonCount = 2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetBlockPriorityToStatic();
		SetLockToughnessEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
		SetLockToughnessDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		for (int i = 0; i < summonCount; i++)
		{
			TSVector2 tSVector = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
			TSVector2 normalized = (tSVector - GetEntityPosition(GetCurrentPlayer())).normalized;
			SummonTeammate(1, tSVector, normalized);
		}
		BeginAttack(1, startKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2.5);
		ReplaceAnimationGroup();
		SetLogicTagToggleValue(_actor, "DaGuanZiToXiaoGuanZi", value: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
