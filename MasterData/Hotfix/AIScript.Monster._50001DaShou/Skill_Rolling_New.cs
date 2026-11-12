using System.Collections;
using TrueSync;

namespace AIScript.Monster._50001DaShou;

public class Skill_Rolling_New : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys_Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly ComboInputBuffer.ActionKey[] actionKeys_AttackEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected FP rushSpeed = 6;

	protected FP rushDis = 16;

	protected bool isSpicalStop;

	protected readonly string fx_DashEnd = "fx_50001dashou_base_atk03_02_end";

	protected DeterministicShape checkObsShape;

	private TSVector2 frontPoint = new TSVector2(0, 5);

	protected override IEnumerator DoMainLogic()
	{
		isSpicalStop = false;
		BeginAttack(1, actionKeys_Attack, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, rushSpeed, rushDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 1);
		yield return WaitDashFinish();
		if (isSpicalStop)
		{
			BeginAttack(1, actionKeys_Attack);
		}
		else
		{
			BeginAttack(1, actionKeys_AttackEnd);
			BeginDashActorForward(1, 6, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 3);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void DashFinishByActor(int index)
	{
		isSpicalStop = true;
	}

	protected override void DashFinishByObstacle(int index)
	{
		isSpicalStop = true;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn && CheckTargetIsValid(GetAttackTarget()))
		{
			WaitLookAt_NoWait(GetAttackTarget(isUpToDate: true), 5, GetRotSpdInSkill() * 0.2);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
	}
}
