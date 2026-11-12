using System.Collections;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Born : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
		AddBuffToTarget(_actor, 501810004);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(77);
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPosition(attackTarget);
		}
		while (Distance(TargetPosition, GetPosition()) >= 15)
		{
			yield return WaitFrame(3);
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPosition(attackTarget);
			}
		}
		RemoveBuffFromTarget(_actor, 990020140);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
