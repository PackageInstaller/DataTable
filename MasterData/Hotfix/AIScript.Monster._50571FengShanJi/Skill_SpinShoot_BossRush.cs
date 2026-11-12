using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_SpinShoot_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] SpinShoot_Combo_D2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private readonly ComboInputBuffer.ActionKey[] SpinShoot_Combo_D3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private readonly FP RotateTime = 1;

	private readonly FP DashSpeed = 2;

	private readonly FP SkillRadius = 4;

	private FP Phase;

	private FP RotateDuration;

	private TSVector2 DashDirection;

	private ComboInputBuffer.ActionKey[] SpinShoot_Combo;

	private FP Difficulty;

	private bool IsUpdate;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		if (Phase == 1 || Phase == 2)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
		if (!IsUpdate)
		{
			SpinShoot_Combo = SpinShoot_Combo_D2;
		}
		else
		{
			SpinShoot_Combo = SpinShoot_Combo_D3;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 tSVector = GetEntityPosition(GetAttackTarget()) - GetPosition();
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), tSVector * -1, new TSVector2(0, RotateTime * DashSpeed));
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= SkillRadius && QueryPositionReachable(_actor, position))
		{
			DashDirection = -tSVector;
		}
		else
		{
			DashDirection = tSVector;
		}
		BeginAttack(1, SpinShoot_Combo, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDash(1, DashDirection, DashSpeed, DashSpeed * RotateTime, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		WaitLookAt_NoWait(GetAttackTarget(), 999, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopWaitLookAt();
	}
}
