using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Base : SkillSimpleBase
{
	protected List<long> fxIndexList = new List<long>();

	protected List<long> bulletIdList = new List<long>();

	protected readonly int StartLIndex;

	protected readonly string StartLKey = "Attack_Start_Long";

	protected readonly int StartSIndex = 1;

	protected readonly string StartSKey = "Attack_Start_Short";

	protected readonly int ACTLIndex = 2;

	protected readonly string ACTLKey = "Attack_ACT_L";

	protected readonly int ACTRIndex = 3;

	protected readonly string ACTRKey = "Attack_ACT_R";

	protected readonly int EndLIndex = 4;

	protected readonly string EndLKey = "Attack_End_L";

	protected readonly int EndRIndex = 5;

	protected readonly string EndRKey = "Attack_End_R";

	protected readonly int WaitLIndex = 6;

	protected readonly string WaitLKey = "Attack_Wait_L";

	protected readonly int WaitRIndex = 7;

	protected readonly string WaitRKey = "Attack_Wait_R";

	protected readonly int IndexDodge = 8;

	protected readonly string DodgeKey = "Dodge";

	protected readonly int ThrowSLJIndex = 9;

	protected readonly string ThrowSLJKey = "Throw_SLJ";

	protected readonly int ThrowMIndex = 10;

	protected readonly string ThrowMKey = "Throw_M";

	protected readonly int ThrowMTraceIndex = 11;

	protected readonly string ThrowMTraceKey = "Throw_M_Trace";

	protected readonly int dashIndex = 12;

	protected readonly string dashKey = "Dash";

	protected readonly int FlashIndex = 13;

	protected readonly string FlashKey = "Flash";

	protected readonly int JumpIndex = 14;

	protected readonly string JumpKey = "Jump";

	protected int ninjutsuIndex = 15;

	protected string ninjutsuKey = "Ninjutsu_G";

	protected int ninjutsuIndex_Loop = 16;

	protected string ninjutsuKey_Loop = "Nijutsu_Loop";

	protected readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	protected readonly string fx_standIn = "fx_70022_loop_Substitute_StandIn";

	protected readonly string fx_smoke = "fx_70022_base_Substitute_Flash";

	protected readonly string AttackFx_L = "fx_70022_atk_Acition_L";

	protected readonly string AttackFx_R = "fx_70022_atk_Acition_R";

	protected readonly string Fx_Dogde = "fx_70022_loop_Dodge_Shukuchi";

	protected readonly string BulletAlias_N = "SThrow_N";

	protected readonly string BulletAlias_S = "SThrow_S";

	protected readonly string lineFx = "fx_70022_laser_STrow";

	protected long WarningFxIndex_Cir;

	protected readonly string WarningFX_Cir = "fx_70022_loop_warning_Skill01";

	protected readonly string BaseFX_Cir = "fx_70022_base_Skill01_Start";

	protected readonly string DamageFx_Cir = "fx_70022_atk_Skill01";

	protected readonly string master_Dot_Cir = "Master_Cir_atk";

	protected readonly string bunsin_Dot_Cir = "Bunsin_Cir_atk";

	protected long WarningFxIndex_Ring;

	protected readonly string WarningFX_Ring = "fx_70022_loop_warning_Skill02";

	protected readonly string BaseFX_Ring = "fx_70022_base_Skill02_Start";

	protected readonly string DamageFx_Ring = "fx_70022_atk_Skill02";

	protected readonly string master_Dot_Ring = "Master_Ring_atk";

	protected readonly string bunsin_Dot_Ring = "Bunsin_Ring_atk";

	protected long WarningFxIndex_Fan;

	protected readonly string WarningFX_Fan = "fx_70022_loop_warning_Skill03";

	protected readonly string BaseFX_Fan = "fx_70022_base_Skill03_Start";

	protected readonly string DamageFx_Fan = "fx_70022_atk_Skill03";

	protected readonly string Dot_Fan = "Fan_atk";

	protected readonly string clockFx = "fx_70022_ground_Kagebunsin_Clock";

	protected readonly int bezierMoveIndex = 10;

	protected readonly int normalATKDashIndex = 11;

	protected readonly int dashMoveIndex = 12;

	private FP dashDistance;

	private TSVector2 dashDirection;

	private string MThrow_Trace = "MThrow_Trace";

	private string MThrow_NOTrace = "MThrow_NoTrace";

	protected void ClearBulletList()
	{
		ClearShootBulletIdList();
		if (bulletIdList != null && bulletIdList.Count > 0)
		{
			bulletIdList.Clear();
		}
	}

	protected void StopEffectList()
	{
		if (fxIndexList == null || fxIndexList.Count <= 0)
		{
			return;
		}
		foreach (long fxIndex in fxIndexList)
		{
			StopEffect(fxIndex);
		}
		fxIndexList.Clear();
	}

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			return GetAttackTarget();
		}
		return GetCurrentPlayer();
	}

	protected IEnumerator Move()
	{
		LogicEntity target = GetAttackTarget();
		SetSearchedImmunityEnable();
		BeginLookAt_NotWait(GetAttackTarget(), 0.2, 2000);
		BeginAttack(IndexDodge, DodgeKey, flushInputedKeys: true, forceInterruptAttack: true);
		long fxID = PlayEffect(Fx_Dogde);
		fxIndexList.Add(fxID);
		TSVector2 targetPosition = TransLocalPosToWorldPos(GetEntityPosition(target), GetEntityPosition(target) - GetPosition(), new TSVector2(0, 2));
		BeginBezierPathMove(bezierMoveIndex, targetPosition, 1.2, 0.8, comboWithAttack: true, 9, AdventureActor.MovementMode.None, 4);
		yield return WaitBezierPathMoveFinish();
		CancelAttack();
		StopEffect(fxID);
		BeginLookAt_NotWait(target, 0.3, 2000);
		SetSearchedImmunityDisable();
	}

	protected IEnumerator MeleeAttack()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 9999);
		BeginAttack(StartLIndex, StartLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.45);
		long item = PlayEffect(WarningFx_Actor, 1f, 3.1, GetPosition(), default, 1.4f);
		fxIndexList.Add(item);
		yield return WaitTime(0.8);
		CancelAttack();
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		long item2 = PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		fxIndexList.Add(item2);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(target)) > 1)
		{
			BeginDash(normalATKDashIndex, GetForward(), 30, 1.5, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		long item3 = PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		fxIndexList.Add(item3);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(target)) > 1)
		{
			BeginDash(normalATKDashIndex, GetForward(), 30, 1.5, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		long item4 = PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		fxIndexList.Add(item4);
		BeginAttack(StartSIndex, StartSKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		long item5 = PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		fxIndexList.Add(item5);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(target)) > 1)
		{
			BeginDash(normalATKDashIndex, GetForward(), 30, 1.5, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		long item6 = PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		fxIndexList.Add(item6);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(target)) > 1)
		{
			BeginDash(normalATKDashIndex, GetForward(), 30, 1.5, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RangeAtkSLJ()
	{
		BeginAttack(ThrowSLJIndex, ThrowSLJKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 999);
		yield return WaitTime(0.4);
		PlayEffect(WarningFx_Actor, 0.8f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.65);
		CancelAttack();
		StopWaitLookAt();
		int bulletCount = 1;
		TSVector2 shootPOS = GetPosition();
		TSVector2 shootDirection = GetForward();
		FanMultipleShoot(BulletAlias_N, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, shootPOS, 1.8, shootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		bulletIdList.AddRange(GetShootBulletIdList());
		yield return WaitTime(0.07);
		if (bulletIdList != null && bulletIdList.Count > 0)
		{
			shootPOS = GetBulletPosition(bulletIdList.get_Item(0));
			shootDirection = GetBulletDirection(bulletIdList.get_Item(0));
		}
		FanMultipleShoot(BulletAlias_S, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 2, 0, shootPOS, 1.8, shootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 24, 0, 0);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RangeAtkFM()
	{
		LogicEntity target = GetTarget();
		BeginAttack(ThrowMIndex, ThrowMKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 1200);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.06);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.44);
		CancelAttack();
		BeginLookAt_NotWait(target, 0.3, 1200);
		yield return WaitTime(0.5);
		TSVector2 ShootPOS_FM = GetPosition();
		GetForward();
		if (GetLogicTagToggleValue(_actor, "SkillTag_FMTrace"))
		{
			string mThrow_Trace = MThrow_Trace;
			FanMultipleShoot(mThrow_Trace, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, GetPosition(), 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
			yield return WaitTime(0.3);
			BeginAttack(ThrowMTraceIndex, ThrowMTraceKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.1);
			bulletIdList.AddRange(GetShootBulletIdList());
			TSVector2 targetPosition = TSVector2.zero;
			if (bulletIdList != null && bulletIdList.Count > 0)
			{
				targetPosition = GetBulletPosition(bulletIdList.get_Item(0));
			}
			for (int i = 0; i < 5; i++)
			{
				long lineFxID = PlayLinkEffect(lineFx, useCustomSource: true, null, ShootPOS_FM, 2.5, null, targetPosition, 1.8, breakWhenLostSourceOrTarget: false, 1f, actorScale: true);
				fxIndexList.Add(lineFxID);
				yield return WaitTime(0.025);
				StopEffect(lineFxID);
				fxIndexList.Remove(lineFxID);
				targetPosition = GetBulletPosition(bulletIdList.get_Item(0));
			}
			StopEffectList();
		}
		else
		{
			string mThrow_Trace = MThrow_NOTrace;
			FanMultipleShoot(mThrow_Trace, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, GetPosition(), 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator FlashMove()
	{
		BeginAttack(FlashIndex, FlashKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		SetHideModelEnable();
		SetSearchedImmunityEnable();
		long fxIndex = PlayEffect(fx_standIn, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		PlayEffect(fx_smoke, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.4);
		for (int i = 0; i < 20; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, TSVector2.zero, default, default, 8, 0), _actor, isReachable: true);
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(shapeRandomPoint, entityPosition) >= 7)
			{
				Teleport(shapeRandomPoint);
				break;
			}
			if (i == 19)
			{
				Teleport(shapeRandomPoint);
				break;
			}
		}
		yield return WaitTime(0.6);
		StopEffect(fxIndex);
		SetUnparalleledDisable();
		SetCloseBlockDisable();
		SetHideModelDisable();
		SetSearchedImmunityDisable();
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 999);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopLookAt();
	}

	protected long WarningFlashFx()
	{
		return PlayEffect(WarningFx_Actor, 1f, 1.5, GetPosition(), default, 3f);
	}

	protected IEnumerator BackToZeroPos()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		BeginAttack(JumpIndex, JumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Teleport(TSVector2.zero);
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator RingAOE(FP durationOfAction)
	{
		BeginAttack(ninjutsuIndex_Loop, ninjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		WarningFxIndex_Ring = PlayEffect(WarningFX_Ring, 1f, 0.3, GetPosition());
		yield return WaitTime(1.7);
		StopEffect(WarningFxIndex_Ring);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.3);
		PlayEffect(BaseFX_Ring, 1f, default, GetPosition());
		PlayAreaEffect(master_Dot_Ring, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Ring, 1f, default, GetPosition());
		yield return WaitTime(durationOfAction);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator CircleAOE(FP durationOfAction)
	{
		BeginAttack(ninjutsuIndex_Loop, ninjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		WarningFxIndex_Cir = PlayEffect(WarningFX_Cir, 1f, 0.3, GetPosition());
		yield return WaitTime(1.7);
		StopEffect(WarningFxIndex_Cir);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.3);
		PlayEffect(BaseFX_Cir, 1f, default, GetPosition());
		PlayAreaEffect(master_Dot_Cir, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Cir, 1f, default, GetPosition());
		yield return WaitTime(durationOfAction);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator FanAOE()
	{
		BeginAttack(ninjutsuIndex_Loop, ninjutsuKey_Loop, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		WarningFxIndex_Fan = PlayEffect(WarningFX_Fan, 1f, 0.3, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.7);
		PlayEffect(BaseFX_Fan, 1f, default, GetPosition());
		yield return WaitTime(0.3);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.6);
		PlayAreaEffect(Dot_Fan, GetPosition(), GetRotation());
		PlayEffect(DamageFx_Fan, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		StopEffect(WarningFxIndex_Fan);
		yield return WaitTime(0.6);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
