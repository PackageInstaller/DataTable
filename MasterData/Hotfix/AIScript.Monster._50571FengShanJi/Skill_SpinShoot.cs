using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_SpinShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] SpinShoot_Combo_D2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static readonly ComboInputBuffer.ActionKey[] SpinShoot_Combo_D1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly ComboInputBuffer.ActionKey[] SpinShoot_Combo_D3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly FP RotateTimeP1 = 1;

	private static readonly FP RotateTimeP2 = 2;

	private static readonly FP DashSpeed = 2;

	private static readonly FP SkillRadius = 4;

	private FP Phase;

	private FP RotateTime;

	private FP RotateDuration;

	private TSVector2 DashDirection;

	private ComboInputBuffer.ActionKey[] SpinShoot_Combo;

	private FP Difficulty;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "Phase");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		if (Phase == 1)
		{
			RotateTime = RotateTimeP1;
		}
		else
		{
			RotateTime = RotateTimeP2;
		}
		if (Difficulty == 3)
		{
			RotateTime = RotateTimeP1;
		}
		RotateDuration = RotateTime;
		if (Difficulty == 1)
		{
			SpinShoot_Combo = SpinShoot_Combo_D1;
		}
		else if (Difficulty == 2)
		{
			SpinShoot_Combo = SpinShoot_Combo_D2;
		}
		else if (Difficulty == 3)
		{
			SpinShoot_Combo = SpinShoot_Combo_D3;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 tSVector = GetEntityPositionObsoleted(GetAttackTarget()) - GetPosition();
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), tSVector * -1, new TSVector2(0, RotateDuration * DashSpeed));
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
		BeginDash(1, DashDirection, DashSpeed, DashSpeed * RotateDuration, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		WaitLookAt_NoWait(GetAttackTarget(), 999, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopWaitLookAt();
	}
}
