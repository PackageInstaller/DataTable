using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private bool hasBuff;

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990013100);
		AddBuffToTarget(_actor, 990021100);
		SetBattleOutEnable();
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPositionObsoleted(attackTarget);
		}
		while (Distance(TargetPosition, GetPosition()) >= 8f)
		{
			yield return WaitFrame(3);
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPositionObsoleted(attackTarget);
			}
		}
		yield return WaitTime(0.2);
		SetBattleOutDisable();
		ShowCenterHpBar();
		RemoveBuffFromTarget(_actor, 990013100);
		RemoveBuffFromTarget(_actor, 990021100);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}
}
