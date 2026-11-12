#define LOG_ERROR
using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Laser_Lv2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private string AimlinkFxAlias = "AimLaser";

	private string AttacklinkFxAlias = "Laser";

	private string Skill2ChargeLFxAlias = "Skill2ChargeL";

	private string Skill2ChargeRFxAlias = "Skill2ChargeR";

	private string Skill2ShootingLFxAlias = "Skill2ShootingL";

	private string Skill2ShootingRFxAlias = "Skill2ShootingR";

	private TSVector2 originalHitPositionForLeft_Offset = new TSVector2(-2, 5.8);

	private TSVector2 originalHitPositionForRight_Offset = new TSVector2(2, 5.8);

	private string areaEffectAlias = "LaserAttackEffect";

	private string ExtendedAreaEffectAlias = "ExtendedArea";

	private int laserExtendLenght = 20;

	private FP fixedMoveDistance = 40;

	private FP MaxHitAngle = 65;

	private FP hitDelay = 0.75;

	private FP hitMoveDelay = 0.25;

	private FP hitMoveSpeed = 2f;

	private int speedUpDownFrame = 10;

	private FP MoveInterval1 = 0.5;

	private FP MoveInterval2 = 0.75;

	private FP MoveInterval3 = 0.5;

	private static readonly ComboInputBuffer.ActionKey[] actionKeys2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private static readonly FP hitMoveDelay_handSkill_smashFloor = 1.5;

	private static readonly FP MoveInterval1_handSkill_smashFloor = 0.5;

	private static readonly FP MoveInterval2_handSkill_smashFloor = 1.5;

	private static readonly FP MoveInterval3_handSkill_smashFloor = 0.5;

	private static readonly ComboInputBuffer.ActionKey[] actionKeys3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private static readonly FP hitMoveDelay_handSkill_handLaser = 1;

	private static readonly FP MoveInterval1_handSkill_handLaser = 0.5;

	private static readonly FP MoveInterval2_handSkill_handLaser = 1.5;

	private static readonly FP MoveInterval3_handSkill_handLaser = 0.5;

	private static readonly ComboInputBuffer.ActionKey[] actionKeys4 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly FP hitMoveDelay_handSkill_rocket = 1.25;

	private static readonly FP MoveInterval1_handSkill_rocket = 0.5;

	private static readonly FP MoveInterval2_handSkill_rocket = 1.5;

	private static readonly FP MoveInterval3_handSkill_rocket = 0.5;

	private int skillType;

	private int cooperateType;

	private ComboInputBuffer.ActionKey[] actionKeys;

	private long leftAreaEffectId;

	private long rightAreaEffectId;

	private long leftExtendId;

	private long rightExtendId;

	private AreaEffectEntity leftArea;

	private AreaEffectEntity rightArea;

	private AreaEffectEntity leftExtendArea;

	private AreaEffectEntity rightExtendtArea;

	private PlayFX leftLaserFx;

	private PlayFX rightLaserFx;

	private PlayFX leftAimLaserFx;

	private PlayFX rightAimLaserFx;

	private long Skill2ChargeLFx;

	private long Skill2ChargeRFx;

	private long Skill2Skill2ShootingLFx;

	private long Skill2Skill2ShootingRFx;

	private FP speedUpDownDistance;

	private bool leftAreaInPlat;

	private bool rightAreaInPlat;

	private CoroutineNode hitMoveCoroutine1;

	private CoroutineNode hitMoveCoroutine2;

	private CoroutineNode hitMoveCoroutine3;

	private CoroutineNode hitMoveCoroutine4;

	private TSVector2 originalHitPositionForLeft;

	private TSVector2 originalHitPositionForRight;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		cooperateType = (int)(long)_actor.logicVariable.GetLogicTagValue("cooperateType");
		actionKeys = actionKeys1;
		FP fP = speedUpDownFrame;
		FP fP2 = hitMoveSpeed;
		speedUpDownDistance = fP2 * fP * 0.5;
		leftAreaInPlat = true;
		rightAreaInPlat = true;
		if (cooperateType == 1)
		{
			actionKeys = actionKeys2;
			hitMoveDelay = hitMoveDelay_handSkill_smashFloor;
			MoveInterval1 = MoveInterval1_handSkill_smashFloor;
			MoveInterval2 = MoveInterval2_handSkill_smashFloor;
			MoveInterval3 = MoveInterval3_handSkill_smashFloor;
		}
		else if (cooperateType == 2)
		{
			actionKeys = actionKeys3;
			hitMoveDelay = hitMoveDelay_handSkill_handLaser;
			MoveInterval1 = MoveInterval1_handSkill_handLaser;
			MoveInterval2 = MoveInterval2_handSkill_handLaser;
			MoveInterval3 = MoveInterval3_handSkill_handLaser;
		}
		else if (cooperateType == 3)
		{
			actionKeys = actionKeys4;
			hitMoveDelay = hitMoveDelay_handSkill_rocket;
			MoveInterval1 = MoveInterval1_handSkill_rocket;
			MoveInterval2 = MoveInterval2_handSkill_rocket;
			MoveInterval3 = MoveInterval3_handSkill_rocket;
		}
		originalHitPositionForLeft = TransLocalPosToWorldPos(GetPosition(), GetForward(), originalHitPositionForLeft_Offset);
		originalHitPositionForRight = TransLocalPosToWorldPos(GetPosition(), GetForward(), originalHitPositionForRight_Offset);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (hitMoveCoroutine1 != null)
		{
			_actor.StopLogicCoroutine(hitMoveCoroutine1);
			hitMoveCoroutine1 = null;
		}
		if (hitMoveCoroutine2 != null)
		{
			_actor.StopLogicCoroutine(hitMoveCoroutine2);
			hitMoveCoroutine2 = null;
		}
		if (hitMoveCoroutine3 != null)
		{
			_actor.StopLogicCoroutine(hitMoveCoroutine3);
			hitMoveCoroutine3 = null;
		}
		if (hitMoveCoroutine4 != null)
		{
			_actor.StopLogicCoroutine(hitMoveCoroutine4);
			hitMoveCoroutine4 = null;
		}
		leftLaserFx?.Stop();
		leftLaserFx?.Clear();
		rightLaserFx?.Stop();
		rightLaserFx?.Clear();
		leftAimLaserFx?.Stop();
		leftAimLaserFx?.Clear();
		rightAimLaserFx?.Stop();
		rightAimLaserFx?.Clear();
		StopEffect(Skill2ChargeLFx);
		StopEffect(Skill2ChargeRFx);
		StopEffect(Skill2Skill2ShootingLFx);
		StopEffect(Skill2Skill2ShootingRFx);
		StopAreaEffect(leftAreaEffectId);
		StopAreaEffect(rightAreaEffectId);
		StopAreaEffect(leftExtendId);
		StopAreaEffect(rightExtendId);
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_Laser_Lv2 skill_Laser_Lv = this;
		TSVector2 position = originalHitPositionForLeft;
		skill_Laser_Lv.PlayEarlyWarningEffect("LaserStartWarning", 1.7f, default, position);
		Skill_Laser_Lv2 skill_Laser_Lv2 = this;
		position = originalHitPositionForRight;
		skill_Laser_Lv2.PlayEarlyWarningEffect("LaserStartWarning", 1.7f, default, position);
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		Skill2ChargeLFx = PlayEffect(Skill2ChargeLFxAlias);
		Skill2ChargeRFx = PlayEffect(Skill2ChargeRFxAlias);
		Skill2Skill2ShootingLFx = PlayEffect(Skill2ShootingLFxAlias);
		Skill2Skill2ShootingRFx = PlayEffect(Skill2ShootingRFxAlias);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		leftAimLaserFx = PlayLinkFX(AimlinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_1.gameObject, TSVector.zero, 0, null, new TSVector(originalHitPositionForLeft.x, 0, originalHitPositionForLeft.y), _actor.tsTransform.PositionY);
		rightAimLaserFx = PlayLinkFX(AimlinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_2.gameObject, TSVector.zero, 0, null, new TSVector(originalHitPositionForRight.x, 0, originalHitPositionForRight.y), _actor.tsTransform.PositionY);
		yield return WaitTime(hitDelay);
		leftAimLaserFx.Stop();
		leftAimLaserFx.Clear();
		rightAimLaserFx.Stop();
		rightAimLaserFx.Clear();
		leftAreaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, originalHitPositionForLeft);
		rightAreaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, originalHitPositionForRight);
		leftArea = ILRuntimeAPI.GetAreaEffect(leftAreaEffectId);
		leftArea.tsTransform.PositionY = _actor.tsTransform.PositionY;
		rightArea = ILRuntimeAPI.GetAreaEffect(rightAreaEffectId);
		rightArea.tsTransform.PositionY = _actor.tsTransform.PositionY;
		leftExtendId = ILRuntimeAPI.PlayAreaEffect(_actor, ExtendedAreaEffectAlias, originalHitPositionForLeft);
		rightExtendId = ILRuntimeAPI.PlayAreaEffect(_actor, ExtendedAreaEffectAlias, originalHitPositionForRight);
		leftExtendArea = ILRuntimeAPI.GetAreaEffect(leftExtendId);
		leftExtendArea.tsTransform.PositionY = _actor.tsTransform.PositionY - laserExtendLenght;
		rightExtendtArea = ILRuntimeAPI.GetAreaEffect(rightExtendId);
		rightExtendtArea.tsTransform.PositionY = _actor.tsTransform.PositionY - laserExtendLenght;
		leftLaserFx = PlayLinkFX(AttacklinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_1.gameObject, TSVector.zero, 0, leftArea.gameObject, TSVector.zero, 0);
		rightLaserFx = PlayLinkFX(AttacklinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_2.gameObject, TSVector.zero, 0, rightArea.gameObject, TSVector.zero, 0);
		yield return WaitTime(hitMoveDelay - 0.25);
		int num = TSRandom.Range(0, 2);
		AreaEffectEntity first = leftArea;
		AreaEffectEntity second = rightArea;
		long firstAreaEffectId = leftAreaEffectId;
		long secondAreaEffectId = rightAreaEffectId;
		PlayFX firstLaserFx = leftLaserFx;
		PlayFX secondLaserFx = rightLaserFx;
		if (num == 0)
		{
			first = rightArea;
			second = leftArea;
			firstAreaEffectId = rightAreaEffectId;
			secondAreaEffectId = leftAreaEffectId;
			firstLaserFx = rightLaserFx;
			secondLaserFx = leftLaserFx;
		}
		PlayEffect("LaserLineWarningFlash", 1f, position: first.tsTransform.Position, fxPositionY: 0.5f, angle: default, spawnSize: 2f);
		yield return WaitTime(0.25);
		hitMoveCoroutine1 = _actor.StartLogicCoroutine(HitMove(first, firstMove: true));
		PlayWwiseSound("mon_13051_laser_FB");
		yield return WaitTime(MoveInterval1 - 0.25);
		PlayEffect("LaserLineWarningFlash", 1f, position: second.tsTransform.Position, fxPositionY: 0.5f, angle: default, spawnSize: 2f);
		yield return WaitTime(0.25);
		hitMoveCoroutine2 = _actor.StartLogicCoroutine(HitMove(second, firstMove: true));
		PlayWwiseSound("mon_13051_laser_FB");
		yield return WaitTime(MoveInterval2);
		hitMoveCoroutine3 = _actor.StartLogicCoroutine(HitMove(first, firstMove: false));
		PlayWwiseSound("mon_13051_laser_BF");
		yield return WaitTime(MoveInterval3);
		PlayWwiseSound("mon_13051_laser_BF");
		yield return hitMoveCoroutine4 = _actor.StartLogicCoroutine(HitMove(second, firstMove: false));
		yield return WaitTime(0.25);
		if (skillType == 0)
		{
			ILRuntimeAPI.StopAreaEffect(firstAreaEffectId);
			firstLaserFx.Stop();
			ILRuntimeAPI.StopAreaEffect(secondAreaEffectId);
			secondLaserFx.Stop();
		}
		ILRuntimeAPI.StopAreaEffect(leftExtendId);
		ILRuntimeAPI.StopAreaEffect(rightExtendId);
		yield return WaitTime(1);
		StopEffect(Skill2ChargeLFx);
		StopEffect(Skill2ChargeRFx);
		StopEffect(Skill2Skill2ShootingLFx);
		StopEffect(Skill2Skill2ShootingRFx);
		BeginAttack(2, actionKeys);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private IEnumerator HitMove(AreaEffectEntity area, bool firstMove)
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 tSVector = new TSVector2(0, -32.2);
		TSVector2 tSVector2 = (CheckTargetIsValid(attackTarget) ? GetEntityPositionObsoleted(attackTarget) : tSVector);
		FP fP = fixedMoveDistance;
		TSVector2 tSVector3 = new TSVector2(0, -1);
		AreaEffectEntity extendArea = leftExtendArea;
		PlayFX fxPlayer = leftLaserFx;
		if (area == rightArea)
		{
			extendArea = rightExtendtArea;
			fxPlayer = rightLaserFx;
		}
		if (firstMove)
		{
			TSVector2 tSVector4 = ((!(area == leftArea)) ? originalHitPositionForRight : originalHitPositionForLeft);
			TSVector2 b = tSVector2 - tSVector4;
			FP fP2 = TSVector2.SignedAngle(tSVector3, b);
			if (fP2 > MaxHitAngle)
			{
				b = TSVector2.Rotate(tSVector3, MaxHitAngle);
			}
			else if (fP2 < -MaxHitAngle)
			{
				b = TSVector2.Rotate(tSVector3, -MaxHitAngle);
			}
			tSVector2 = tSVector4 + b.normalized;
		}
		if (!firstMove)
		{
			tSVector2 = ((!(area == leftArea)) ? originalHitPositionForLeft : originalHitPositionForRight);
			fP = TSVector2.Distance(tSVector2, area.tsTransform.Position);
		}
		FP fP3 = fP - speedUpDownDistance * 2;
		if (fP3 <= 0)
		{
			NovaLogger.Error("移动距离配置的不够！");
		}
		int constantSpeedFrame = (int)(long)(fP3 / hitMoveSpeed);
		int totalFrame = speedUpDownFrame * 2 + constantSpeedFrame;
		area.tsTransform.Forward = (tSVector2 - area.tsTransform.Position).normalized;
		int frameCount = 0;
		FP moveSpeed = 0;
		FP progressiveSpeed = hitMoveSpeed / speedUpDownFrame;
		Vector3 startPosition = _actor.slotConfig.extraSlot_1.position;
		if (area == rightArea)
		{
			startPosition = _actor.slotConfig.extraSlot_2.position;
		}
		_ = (FP)0;
		while (totalFrame > 0)
		{
			if (frameCount < speedUpDownFrame)
			{
				moveSpeed += progressiveSpeed;
				if (moveSpeed > hitMoveSpeed)
				{
					moveSpeed = hitMoveSpeed;
				}
			}
			else if (frameCount >= speedUpDownFrame + constantSpeedFrame)
			{
				moveSpeed -= progressiveSpeed;
			}
			else
			{
				moveSpeed = hitMoveSpeed;
			}
			area.tsTransform.Position += area.tsTransform.Forward * moveSpeed;
			totalFrame--;
			frameCount++;
			Vector3 normalized = (area.transform.position - startPosition).normalized;
			Vector3 vector = area.transform.position + normalized * laserExtendLenght;
			extendArea.tsTransform.Position = new TSVector2(vector.x, vector.z);
			extendArea.tsTransform.PositionY = vector.y;
			bool flag = ILRuntimeAPI.Raycast(startPosition, normalized, 50f);
			if (!flag)
			{
				if (area == leftArea && leftAreaInPlat)
				{
					leftAreaInPlat = false;
					fxPlayer.fxInstance.target = extendArea.transform;
				}
				else if (area == rightArea && rightAreaInPlat)
				{
					rightAreaInPlat = false;
					fxPlayer.fxInstance.target = extendArea.transform;
				}
			}
			else if (flag)
			{
				if (area == leftArea && !leftAreaInPlat)
				{
					leftAreaInPlat = true;
					fxPlayer.fxInstance.target = area.transform;
				}
				else if (area == rightArea && !rightAreaInPlat)
				{
					rightAreaInPlat = true;
					fxPlayer.fxInstance.target = area.transform;
				}
			}
			yield return null;
		}
	}
}
