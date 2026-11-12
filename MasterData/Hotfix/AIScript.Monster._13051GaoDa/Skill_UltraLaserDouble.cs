#define LOG_ERROR
using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._13051GaoDa;

public class Skill_UltraLaserDouble : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly string AimlinkFxAlias = "AimLaser";

	private static readonly string AttacklinkFxAlias = "Laser";

	private static readonly string FlashBeforeShoot = "UltraSkill_FlashBeforeShoot";

	private static readonly string Warning1 = "UltraSkill_Warning1";

	private static readonly string Warning2 = "UltraSkill_Warning2";

	private static readonly string Warning_Charging = "UltraSkill_Warning_Charging";

	private static readonly string Attack = "UltraSkill_Attack";

	private static readonly string ChargeStart = "UltraSKill_ChargeStart";

	private string Skill2ChargeLFxAlias = "Skill2ChargeL";

	private string Skill2ChargeRFxAlias = "Skill2ChargeR";

	private string Skill2ShootingLFxAlias = "Skill2ShootingL";

	private string Skill2ShootingRFxAlias = "Skill2ShootingR";

	private static readonly string areaEffectAlias = "LaserAttackEffect";

	private string ExtendedAreaEffectAlias = "ExtendedArea";

	private static readonly TSVector2 originalHitPositionForLeft = new TSVector2(3.7, -19.2);

	private static readonly TSVector2 originalHitPositionForRight = new TSVector2(-3.7, -19.2);

	private static readonly FP fixedMoveDistance = 40;

	private static readonly FP MaxHitAngle = 65;

	private static readonly int laserExtendLenght = 20;

	private static readonly FP hitDelay = 0.75;

	private static readonly FP hitMoveDelay = 0.25;

	private static readonly FP hitMoveSpeed = 2f;

	private static readonly int speedUpDownFrame = 10;

	private static readonly FP MoveInterval1 = 0.5;

	private static readonly FP MoveInterval2 = 0;

	private static readonly FP MoveInterval3 = 0.5;

	private static readonly FP shootDelay = 0.75;

	private static readonly FP shootDuration = 4;

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

	private FP speedUpDownDistance;

	private bool leftAreaInPlat;

	private bool rightAreaInPlat;

	private CoroutineNode hitCoroutineNode;

	private CoroutineNode FXCoroutineNode;

	private long Skill2ChargeLFx;

	private long Skill2ChargeRFx;

	private long Skill2Skill2ShootingLFx;

	private long Skill2Skill2ShootingRFx;

	private long WarningChargingFX;

	private CoroutineNode firstAreaHitCoroutineNode;

	private CoroutineNode secondAreaHitCoroutineNode;

	private TSVector2 HitPositionForLeft;

	private TSVector2 HitPositionForRight;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		FP fP = speedUpDownFrame;
		FP fP2 = hitMoveSpeed;
		speedUpDownDistance = fP2 * fP * 0.5;
		leftAreaInPlat = true;
		rightAreaInPlat = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
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
		StopCoroutine(ref hitCoroutineNode);
		StopCoroutine(ref FXCoroutineNode);
		StopEffect(WarningChargingFX);
		StopAreaEffect(leftAreaEffectId);
		StopAreaEffect(rightAreaEffectId);
		StopAreaEffect(leftExtendId);
		StopAreaEffect(rightExtendId);
		StopCoroutine(ref firstAreaHitCoroutineNode);
		StopCoroutine(ref secondAreaHitCoroutineNode);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		Skill2ChargeLFx = PlayEffect(Skill2ChargeLFxAlias);
		Skill2ChargeRFx = PlayEffect(Skill2ChargeRFxAlias);
		Skill2Skill2ShootingLFx = PlayEffect(Skill2ShootingLFxAlias);
		Skill2Skill2ShootingRFx = PlayEffect(Skill2ShootingRFxAlias);
		StartCoroutine(ref FXCoroutineNode, ChargeFXPlay());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		long ChargeFX = PlayEffect(ChargeStart);
		HitPositionForLeft = originalHitPositionForLeft;
		HitPositionForRight = originalHitPositionForRight;
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			HitPositionForLeft = GetPlaceHolderPosition("StrafeLaserHitPosLeft");
			HitPositionForRight = GetPlaceHolderPosition("StrafeLaserHitPosRight");
		}
		leftAimLaserFx = PlayLinkFX(AimlinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_1.gameObject, TSVector.zero, 0, null, new TSVector(HitPositionForLeft.x, 0, HitPositionForLeft.y), _actor.tsTransform.PositionY);
		rightAimLaserFx = PlayLinkFX(AimlinkFxAlias, useCustomSource: true, _actor.slotConfig.extraSlot_2.gameObject, TSVector.zero, 0, null, new TSVector(HitPositionForRight.x, 0, HitPositionForRight.y), _actor.tsTransform.PositionY);
		yield return WaitTime(hitDelay);
		leftAimLaserFx.Stop();
		leftAimLaserFx.Clear();
		rightAimLaserFx.Stop();
		rightAimLaserFx.Clear();
		leftAreaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, HitPositionForLeft);
		rightAreaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, HitPositionForRight);
		leftArea = ILRuntimeAPI.GetAreaEffect(leftAreaEffectId);
		leftArea.tsTransform.PositionY = _actor.tsTransform.PositionY;
		rightArea = ILRuntimeAPI.GetAreaEffect(rightAreaEffectId);
		rightArea.tsTransform.PositionY = _actor.tsTransform.PositionY;
		leftExtendId = ILRuntimeAPI.PlayAreaEffect(_actor, ExtendedAreaEffectAlias, HitPositionForLeft);
		rightExtendId = ILRuntimeAPI.PlayAreaEffect(_actor, ExtendedAreaEffectAlias, HitPositionForRight);
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
		StartCoroutine(ref firstAreaHitCoroutineNode, HitMove(first, firstMove: true, 1));
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_FB");
		yield return WaitTime(MoveInterval1 - 0.25);
		PlayEffect("LaserLineWarningFlash", 1f, position: second.tsTransform.Position, fxPositionY: 0.5f, angle: default, spawnSize: 2f);
		yield return WaitTime(0.25);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_FB");
		StartCoroutine(ref secondAreaHitCoroutineNode, HitMove(second, firstMove: true, 1));
		yield return secondAreaHitCoroutineNode;
		yield return WaitTime(MoveInterval2);
		StartCoroutine(ref firstAreaHitCoroutineNode, HitMove(first, firstMove: false, 1));
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_BF");
		yield return WaitTime(MoveInterval3);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_BF");
		StartCoroutine(ref secondAreaHitCoroutineNode, HitMove(second, firstMove: false, 1));
		yield return secondAreaHitCoroutineNode;
		yield return WaitTime(0.25);
		ILRuntimeAPI.StopAreaEffect(firstAreaEffectId);
		firstLaserFx.Stop();
		firstLaserFx.Clear();
		ILRuntimeAPI.StopAreaEffect(secondAreaEffectId);
		secondLaserFx.Stop();
		secondLaserFx.Clear();
		ILRuntimeAPI.StopAreaEffect(leftExtendId);
		ILRuntimeAPI.StopAreaEffect(rightExtendId);
		yield return WaitTime(0.25);
		StopEffect(Skill2ChargeLFx);
		StopEffect(Skill2ChargeRFx);
		StopEffect(Skill2Skill2ShootingLFx);
		StopEffect(Skill2Skill2ShootingRFx);
		yield return WaitTime(shootDelay);
		BeginAttack(2, actionKeys);
		yield return WaitTime(0.5);
		StopEffect(ChargeFX);
		PlayEffect(FlashBeforeShoot);
		yield return WaitTime(0.35);
		long attackFX = PlayEffect(Attack);
		StartCoroutine(ref hitCoroutineNode, ContinueHit());
		yield return WaitTime(shootDuration);
		StopEffect(attackFX);
		StopCoroutine(ref hitCoroutineNode);
		BeginAttack(3, actionKeys);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
	}

	private IEnumerator HitMove(AreaEffectEntity area, bool firstMove, int times)
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 tSVector = new TSVector2(0, -32.2);
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			tSVector = TSVector2.zero;
		}
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
			TSVector2 position = area.tsTransform.Position;
			TSVector2 b = tSVector2 - position;
			FP fP2 = TSVector2.SignedAngle(tSVector3, b);
			if (fP2 > MaxHitAngle)
			{
				b = TSVector2.Rotate(tSVector3, MaxHitAngle);
			}
			else if (fP2 < -MaxHitAngle)
			{
				b = TSVector2.Rotate(tSVector3, -MaxHitAngle);
			}
			tSVector2 = position + b.normalized;
		}
		if (!firstMove)
		{
			if (area == leftArea)
			{
				tSVector2 = ((times != 1) ? HitPositionForLeft : HitPositionForRight);
			}
			else
			{
				tSVector2 = ((times != 1) ? HitPositionForRight : HitPositionForLeft);
			}
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

	private IEnumerator ContinueHit()
	{
		while (true)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, GetPosition(), 11, 100);
			Skill_UltraLaserDouble skill_UltraLaserDouble = this;
			FP knockBackForce = 10;
			FP knockBackDistance = 2;
			FP stiffDuration = 0.3;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_UltraLaserDouble.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, stiffDuration, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 13051041, 0.5, HitBox.HurtAnimType.Small, "HitByLaser");
			yield return null;
		}
	}

	private IEnumerator ChargeFXPlay()
	{
		TSVector2 Warning_FXPos = new TSVector2(0, -32.2);
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			Warning_FXPos = GetPlaceHolderPosition("UltraWarningLoopFXPos");
		}
		yield return WaitTime(0.75);
		PlayEffect(Warning2);
		PlayEffect(Warning1, 1f, default, Warning_FXPos);
		yield return WaitTime(1);
		WarningChargingFX = PlayEffect(Warning_Charging, 0.8f, default, Warning_FXPos);
	}
}
