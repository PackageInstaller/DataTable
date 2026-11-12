using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill6_Dash : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private readonly string bullet3 = "Weapon_10007KuangFengQingXiao_GuideShootPlus2";

	protected override IEnumerator DoMainLogic()
	{
		FP intervaltime = 0.2;
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		List<LogicEntity> targetsByLogicTag = GetTargetsByLogicTag(LogicTagType._Bool, "isEnvelope", null, value1: true);
		int count = targetsByLogicTag.Count;
		Skill6_Dash skill6_Dash = this;
		TSVector2 entityPosition = GetEntityPosition(attackTarget);
		FP radius = 4;
		FP innerRadius = 1;
		FP angle = 360;
		FP rotation = 0;
		DeterministicShape shapeData = skill6_Dash.GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition, default, default, radius, innerRadius, angle, rotation);
		TSVector2 targetpos = GetShapeRandomPoint(shapeData, attackTarget, isReachable: true);
		if (count > 0)
		{
			LogicEntity targetNearOrFar = GetTargetNearOrFar(iNear: false, targetsByLogicTag);
			targetpos = GetEntityPosition(targetNearOrFar);
		}
		BeginLookAtByPos_NotWait(targetpos, _duration, _rotateSpeed);
		yield return WaitTime(_duration);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCustomEvent("DashStart");
		FP fP = Distance(GetPosition(), targetpos) + 2f;
		fP = ((fP < 16) ? ((FP)16) : fP);
		BeginDash(1, GetForward(), 20, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		if (GetLogicTagFpValue(_actor, "BossStage") == 2)
		{
			intervaltime = 0.15;
		}
		for (FP t = 0.6; t > 0; t -= intervaltime)
		{
			DoShoot();
			yield return WaitTime(intervaltime);
		}
		CancelAttack();
		yield return WaitTime(2);
	}

	private void DoShoot()
	{
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1.1f), _actor.tsTransform.Rotation);
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		GetEntityPosition(attackTarget);
		FanMultipleShoot(bullet3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 2, 0.9, shootPosition, 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 10, 1);
	}
}
