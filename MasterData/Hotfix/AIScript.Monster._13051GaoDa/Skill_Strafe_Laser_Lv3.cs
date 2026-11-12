#define LOG_ERROR
using System.Collections;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Strafe_Laser_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_left;

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_right;

	private static readonly string AimlinkFxAlias;

	private static readonly string AttacklinkFxAlias;

	private static readonly string areaEffectAlias;

	private static readonly string Skill2ChargeLFxAlias;

	private static readonly string Skill2ChargeRFxAlias;

	private static readonly string Skill2ShootingLFxAlias;

	private static readonly string Skill2ShootingRFxAlias;

	private static readonly string CustomEvent_LaserChargeStart;

	private static readonly TSVector2 originalHitPositionForLeft;

	private static readonly TSVector2 originalHitPositionForRight;

	private static readonly FP fixedMoveDistance;

	private static readonly int laserExtendLenght;

	private static readonly FP MaxHitAngle;

	private static readonly FP hitDelay;

	private static readonly FP hitMoveDelay;

	private static readonly FP hitMoveSpeed;

	private static readonly int speedUpDownFrame;

	private static readonly FP MoveInterval1;

	private ComboInputBuffer.ActionKey[] actionKeys;

	private long areaEffectId;

	private AreaEffectEntity area;

	private AreaEffectEntity extendArea;

	private PlayFX laserFx;

	private PlayFX aimLaserFx;

	private long Skill2ChargeLFx;

	private long Skill2ChargeRFx;

	private long Skill2Skill2ShootingLFx;

	private long Skill2Skill2ShootingRFx;

	private FP speedUpDownDistance;

	private bool areaInPlat;

	private int skillType;

	private CoroutineNode hitMoveCoroutine1;

	private CoroutineNode hitMoveCoroutine2;

	private TSVector2 HitPositionForLeft;

	private TSVector2 HitPositionForRight;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		if (skillType == 1)
		{
			actionKeys = actionKeys_left;
		}
		else if (skillType == 2)
		{
			actionKeys = actionKeys_right;
		}
		FP fP = speedUpDownFrame;
		FP fP2 = hitMoveSpeed;
		speedUpDownDistance = fP2 * fP * 0.5;
		areaInPlat = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (GetTargetByTeammateIndex(4).Count > 0)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(4).get_Item(0), "AttackMessage", "");
			SetLogicTagStringValue(GetTargetByTeammateIndex(5).get_Item(0), "AttackMessage", "");
		}
		laserFx?.Stop();
		laserFx?.Clear();
		aimLaserFx?.Stop();
		aimLaserFx?.Clear();
		StopEffect(Skill2ChargeLFx);
		StopEffect(Skill2ChargeRFx);
		StopEffect(Skill2Skill2ShootingLFx);
		StopEffect(Skill2Skill2ShootingRFx);
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
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		if (skillType == 1)
		{
			Skill2ChargeLFx = PlayEffect(Skill2ChargeLFxAlias);
			Skill2Skill2ShootingLFx = PlayEffect(Skill2ShootingLFxAlias);
		}
		else
		{
			Skill2ChargeRFx = PlayEffect(Skill2ChargeRFxAlias);
			Skill2Skill2ShootingRFx = PlayEffect(Skill2ShootingRFxAlias);
		}
		yield return WaitCustomEvent(CustomEvent_LaserChargeStart);
		HitPositionForLeft = originalHitPositionForLeft;
		HitPositionForRight = originalHitPositionForRight;
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			HitPositionForLeft = GetPlaceHolderPosition("StrafeLaserHitPosLeft");
			HitPositionForRight = GetPlaceHolderPosition("StrafeLaserHitPosRight");
		}
		GameObject sourceGO = _actor.slotConfig.extraSlot_1.gameObject;
		TSVector2 originalHitPosition = HitPositionForLeft;
		if (skillType == 2)
		{
			sourceGO = _actor.slotConfig.extraSlot_2.gameObject;
			originalHitPosition = HitPositionForRight;
		}
		aimLaserFx = PlayLinkFX(AimlinkFxAlias, useCustomSource: true, sourceGO, TSVector.zero, 0, null, new TSVector(originalHitPosition.x, 0, originalHitPosition.y), _actor.tsTransform.PositionY);
		yield return WaitTime(hitDelay);
		aimLaserFx.Stop();
		aimLaserFx.Clear();
		areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, originalHitPosition);
		area = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		area.tsTransform.PositionY = _actor.tsTransform.PositionY;
		long extendId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, originalHitPosition);
		extendArea = ILRuntimeAPI.GetAreaEffect(extendId);
		extendArea.tsTransform.PositionY = _actor.tsTransform.PositionY - laserExtendLenght;
		laserFx = PlayLinkFX(AttacklinkFxAlias, useCustomSource: true, sourceGO, TSVector.zero, 0, area.gameObject, TSVector.zero, 0);
		yield return WaitTime(hitMoveDelay - 0.25);
		StartCor(SendMessageToPhantom(4, "LeftPhantomAttack"));
		PlayEffect("LaserLineWarningFlash", 1f, position: area.tsTransform.Position, fxPositionY: 0.5f, angle: default, spawnSize: 2f);
		yield return WaitTime(0.25);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_FB");
		hitMoveCoroutine1 = _actor.StartLogicCoroutine(HitMove(area, firstMove: true));
		yield return WaitTime(MoveInterval1 - 0.25);
		StartCor(SendMessageToPhantom(5, "RightPhantomAttack"));
		PlayEffect("LaserLineWarningFlash", 1f, position: area.tsTransform.Position, fxPositionY: 0.5f, angle: default, spawnSize: 2f);
		yield return WaitTime(0.25);
		hitMoveCoroutine2 = _actor.StartLogicCoroutine(HitMove(area, firstMove: false));
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_13051_laser_BF");
		yield return WaitTime(2);
		ILRuntimeAPI.StopAreaEffect(areaEffectId);
		laserFx.Stop();
		laserFx.Clear();
		ILRuntimeAPI.StopAreaEffect(extendId);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator HitMove(AreaEffectEntity area, bool firstMove)
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
		if (firstMove)
		{
			TSVector2 tSVector4 = HitPositionForLeft;
			if (skillType == 2)
			{
				tSVector4 = HitPositionForRight;
			}
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
			tSVector2 = (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)) ? GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)) : tSVector);
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
		if (skillType == 2)
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
				if (areaInPlat)
				{
					areaInPlat = false;
					laserFx.fxInstance.target = extendArea.transform;
				}
			}
			else if (flag && !areaInPlat)
			{
				areaInPlat = true;
				laserFx.fxInstance.target = area.transform;
			}
			yield return null;
		}
	}

	private IEnumerator SendMessageToPhantom(int index, string message)
	{
		if (GetTargetByTeammateIndex(4).Count * GetTargetByTeammateIndex(5).Count != 0)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", message);
			yield return WaitTime(0.2);
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", "");
		}
	}

	static Skill_Strafe_Laser_Lv3()
	{
		//IL_0022: Field data (rva=0x528) could not be found in any section!
		//IL_0022: Field data (rva=0x528) could not be found in any section!
		//IL_000c: Field data (rva=0x698) could not be found in any section!
		//IL_000c: Field data (rva=0x698) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2AFC299AE2C44DBAD6B479482D2D7467D7DEFD66041659ED28CA5E8D83236E82));
		actionKeys_left = array;
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._0A389783AF9AC112B6DE32EB03659EAB9F1CA425FE8EF2B08F60454BC1F7395B));
		actionKeys_right = array2;
		AimlinkFxAlias = "AimLaser";
		AttacklinkFxAlias = "Laser";
		areaEffectAlias = "LaserAttackEffect";
		Skill2ChargeLFxAlias = "Skill2ChargeL";
		Skill2ChargeRFxAlias = "Skill2ChargeR";
		Skill2ShootingLFxAlias = "Skill2ShootingL";
		Skill2ShootingRFxAlias = "Skill2ShootingR";
		CustomEvent_LaserChargeStart = "LaserChargeStart";
		originalHitPositionForLeft = new TSVector2(2, -19.2);
		originalHitPositionForRight = new TSVector2(-2, -19.2);
		fixedMoveDistance = 40;
		laserExtendLenght = 1000;
		MaxHitAngle = 65;
		hitDelay = 0.5;
		hitMoveDelay = 0.5;
		hitMoveSpeed = 2f;
		speedUpDownFrame = 10;
		MoveInterval1 = 1;
	}
}
