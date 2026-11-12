using System.Collections;
using TrueSync;

namespace AIScript.Monster._10004YeZhu;

public class Skill_ThousandDash : SkillSimpleBase
{
	protected readonly FP rotateSpeed = 360;

	protected readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly FP dashSpeed = 14;

	protected long fxLoopA;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity targetByID = GetTargetByID((int)(long)GetLogicTagFpValue(_actor, "MasterID"), GetTargetsByFaction(isFriend: true));
		if (!CheckTargetIsValid(targetByID) || (targetByID as AdventureActor).state == ActorState.LostControl)
		{
			_actor.ClearMonsterSelf();
		}
		fxLoopA = PlayEffect("Dash");
		yield return WaitTime(0.2);
		yield return WaitTime(GetLogicTagFpValue(_actor, "WaitTime"));
		WaitLookAt_NoWait(GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "MasterID")), 999, rotateSpeed);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopWaitLookAt();
		BeginDashActorForward(1, dashSpeed, 999, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		while (true)
		{
			Skill_ThousandDash skill_ThousandDash = this;
			Skill_ThousandDash skill_ThousandDash2 = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1));
			FP width = 1.2;
			FP length = 1;
			FP rotation = GetRotation();
			if (skill_ThousandDash.AreaCheckObstacle(skill_ThousandDash2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation)))
			{
				break;
			}
			yield return WaitFrame(1);
		}
		_actor.DestroySelf();
		yield return WaitTime(999);
	}

	protected override void OnSkillDisable()
	{
		StopEffect(fxLoopA);
	}
}
