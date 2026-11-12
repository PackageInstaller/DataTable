using System.Collections;
using TrueSync;

namespace AIScript.Monster._50211TanZhaoDeng;

public class Skill_Slash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] LeftHandAttack_Start_Combo = new ComboInputBuffer.ActionKey[2];

	private static readonly ComboInputBuffer.ActionKey[] LeftHandAttack_EndWithSearchAndAttack_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey.C
	};

	private static readonly ComboInputBuffer.ActionKey[] RightHandAttack_Start_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey.B
	};

	private static readonly ComboInputBuffer.ActionKey[] RightHandAttack_EndWithSearchAndAttack_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey.C
	};

	private static readonly ComboInputBuffer.ActionKey[] DashBack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] EndWithDirectAttack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly FP SearchDurationTime = 3;

	private static readonly FP BackDashDistance = 8;

	private ComboInputBuffer.ActionKey[] Start_Combo;

	private ComboInputBuffer.ActionKey[] EndWithSearchAndAttack_Combo;

	private bool IsAttack;

	private FP SearchTimeCount;

	private string SkillMode;

	private string SearchMode;

	private CoroutineNode SpecialSearchNode;

	protected override void OnSkillEnable()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			Start_Combo = LeftHandAttack_Start_Combo;
			EndWithSearchAndAttack_Combo = LeftHandAttack_EndWithSearchAndAttack_Combo;
			SearchMode = "LTR";
		}
		else
		{
			Start_Combo = RightHandAttack_Start_Combo;
			EndWithSearchAndAttack_Combo = RightHandAttack_EndWithSearchAndAttack_Combo;
			SearchMode = "RTL";
		}
		SearchTimeCount = 0;
		IsAttack = false;
		SkillMode = GetMonsterTagValue(_actor, 1);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 75);
		yield return WaitCustomEvent("StopTurn1");
		StopWaitLookAt();
		yield return WaitCustomEvent("Dash1");
		BeginDashActorForward(1, 10, 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("Dash2");
		BeginDashActorForward(1, 10, 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (SearchTargetInShape())
		{
			BeginAttack(2, EndWithDirectAttack_Combo);
			if (SkillMode == "Wind")
			{
				PlayAreaEffect("AreaEffect_50211TanZhaoDeng_Wind", GetPosition());
			}
			IsAttack = true;
			BeginLookAt_NotWait(GetAttackTarget(), 999, 75);
			yield return WaitCustomEvent("ReadyToHit");
			StopWaitLookAt();
			BeginDashActorForward(1, 4.5, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		else
		{
			if (SkillMode == "Dark")
			{
				StartCor(ref SpecialSearchNode, SpecialSearch());
			}
			while (SearchTimeCount < SearchDurationTime)
			{
				if (SearchTargetInShape())
				{
					if (SkillMode == "Dark")
					{
						StopCor(SpecialSearchNode);
						StopWaitLookAt();
					}
					SearchTimeCount = SearchDurationTime;
					IsAttack = true;
					BeginAttack(3, EndWithSearchAndAttack_Combo);
					if (SkillMode == "Wind")
					{
						PlayAreaEffect("AreaEffect_50211TanZhaoDeng_Wind", GetPosition());
					}
					yield return WaitCustomEvent("SearchSuccessTurn");
					yield return BeginLookAt(GetAttackTarget(), 0, 999);
					BeginLookAt_NotWait(GetAttackTarget(), 999, 100);
					yield return WaitCustomEvent("ReadyToHit");
					StopWaitLookAt();
					BeginDashActorForward(1, 4.5, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				}
				else
				{
					yield return null;
					SearchTimeCount += (FP)0.03;
				}
			}
		}
		if (!IsAttack)
		{
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (SearchTargetBeside())
		{
			BeginAttack(9, DashBack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("StartBackDash");
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)), TSVector2.up * BackDashDistance);
			BeginDash(9, tSVector - GetPosition(), BackDashDistance / 0.36, BackDashDistance, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitLookAt(GetAttackTarget(isUpToDate: true), 0.36, 720);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private bool SearchTargetInShape()
	{
		TSVector2 position = GetPosition();
		FP radius = 5.5;
		FP innerRadius = 1;
		FP angle = 120;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		if (GetTargetsFromShape(shapeData, null, includeSelf: false, GetAttackTarget(isUpToDate: true)).Count == 0)
		{
			return false;
		}
		return true;
	}

	private bool SearchTargetBeside()
	{
		TSVector2 position = GetPosition();
		FP radius = 3.5;
		FP innerRadius = 1;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		if (GetTargetsFromShape(shapeData, null, includeSelf: false, GetAttackTarget(isUpToDate: true)).Count == 0)
		{
			return false;
		}
		return true;
	}

	private IEnumerator SpecialSearch()
	{
		int SearchAngle = 90;
		if (SearchMode == "LTR")
		{
			yield return BeginRotateAngle(-SearchAngle, (double)SearchAngle / 0.75);
			yield return WaitTime(0.15);
			yield return BeginRotateAngle(SearchAngle * 2, (double)SearchAngle / 0.6);
		}
		else
		{
			yield return BeginRotateAngle(SearchAngle, (double)SearchAngle / 0.75);
			yield return WaitTime(0.15);
			yield return BeginRotateAngle(-SearchAngle * 2, (double)SearchAngle / 0.6);
		}
	}
}
