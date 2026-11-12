using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_BassATK : SkillSimpleBase
{
	private static readonly FP DISTLimit01 = 4;

	private static readonly FP DISTLimit02 = 8;

	private static readonly int ACTLIndex = 0;

	private static readonly string ACTLKey = "Attack_ACT_L";

	private static readonly int ACTRIndex = 1;

	private static readonly string ACTRKey = "Attack_ACT_R";

	private static readonly int EndLIndex = 2;

	private static readonly string EndLKey = "Attack_End_L";

	private static readonly int EndRIndex = 3;

	private static readonly string EndRKey = "Attack_End_R";

	private static readonly int WaitLIndex = 4;

	private static readonly string WaitLKey = "Attack_Wait_L";

	private static readonly int WaitRIndex = 5;

	private static readonly string WaitRKey = "Attack_Wait_R";

	private static readonly int StartLIndex = 6;

	private static readonly string StartLKey = "Attack_Start_Long";

	private static readonly int StartSIndex = 7;

	private static readonly string StartSKey = "Attack_Start_Short";

	private static readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private static readonly string AttackFx_L = "fx_70022_atk_Acition_L";

	private static readonly string AttackFx_R = "fx_70022_atk_Acition_R";

	private static int DashIndex = 10;

	private static TSVector2 Direction;

	private static FP Speed = 30;

	private static FP DIST = 1.5;

	private static FP AngleLimit = 999;

	private static LogicEntity Target;

	private static TSVector2 TargetPOS;

	private static readonly int ThrowSLJIndex = 0;

	private static readonly string ThrowSLJKey = "Throw_SLJ";

	private static readonly string BulletAlias_N = "SThrow_N";

	private static readonly string BulletAlias_S = "SThrow_S";

	private static bool AlignShoot = true;

	private static readonly FP AlignShootDelay = 0;

	private static int BulletCount;

	private static readonly FP Duration = 0;

	private static TSVector2 ShootPOS;

	private static readonly FP ShootPOSY = 1.8;

	private static TSVector2 MultishootDirection;

	private static readonly FP BulletDirectionOffset = 0;

	private static FP Angle;

	private static readonly FP Radius = 0;

	private static readonly FP InnerRadius = 0;

	private static List<long> bulletIdList = new List<long>();

	private static readonly int ThrowMIndex = 8;

	private static readonly string ThrowMKey = "Throw_M";

	private static readonly int ThrowMTraceIndex = 9;

	private static readonly string ThrowMTraceKey = "Throw_M_Trace";

	private string MThrow;

	private static string MThrow_Trace = "MThrow_Trace";

	private static string MThrow_NOTrace = "MThrow_NoTrace";

	private static bool AlignShoot_FM = true;

	private static readonly FP AlignShootDelay_FM = 0;

	private static int BulletCount_FM = 1;

	private static readonly FP Duration_FM = 0;

	private static TSVector2 ShootPOS_FM;

	private static readonly FP ShootPOSY_FM = 1.8;

	private static TSVector2 MultishootDirectio_FMn;

	private static readonly FP BulletDirectionOffset_FM = 0;

	private static FP Angle_FM = 0;

	private static readonly FP Radius_FM = 0;

	private static readonly FP InnerRadius_FM = 0;

	private TSVector2 LinePOS;

	private static string LineFx = "fx_70022_laser_STrow";

	private static List<long> LineFxList = new List<long>();

	private List<long> BulletIDList = new List<long>();

	protected override void OnSkillEnable()
	{
		LineFxList.Clear();
		BulletIDList.Clear();
		bulletIdList.Clear();
	}

	protected override void OnSkillDisable()
	{
		ClearShootBulletIdList();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= DISTLimit01)
		{
			yield return StartCor(MeleeAttack());
		}
		else if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > DISTLimit01 && Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= DISTLimit02)
		{
			yield return StartCor(FM());
		}
		else
		{
			yield return StartCor(SLJ());
		}
	}

	protected IEnumerator MeleeAttack()
	{
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 9999);
		BeginAttack(StartLIndex, StartLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.8, 180);
		yield return WaitTime(0.25);
		PlayEffect(WarningFx_Actor, 1f, 3.1, GetPosition(), default, 1.4f);
		yield return WaitTime(0.8);
		CancelAttack();
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		BeginAttack(StartSIndex, StartSKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator SLJ()
	{
		BeginAttack(ThrowSLJIndex, ThrowSLJKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 999);
		yield return WaitTime(0.4);
		PlayEffect(WarningFx_Actor, 0.8f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.65);
		CancelAttack();
		StopWaitLookAt();
		Angle = 0;
		BulletCount = 1;
		ShootPOS = GetPosition();
		MultishootDirection = GetForward();
		FanMultipleShoot(BulletAlias_N, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPOS, ShootPOSY, MultishootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
		bulletIdList.AddRange(GetShootBulletIdList());
		ClearShootBulletIdList();
		yield return WaitTime(0.07);
		Angle = 24;
		BulletCount = 2;
		ShootPOS = GetBulletPosition(bulletIdList.get_Item(0));
		MultishootDirection = GetBulletDirection(bulletIdList.get_Item(0));
		FanMultipleShoot(BulletAlias_S, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPOS, ShootPOSY, MultishootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator FM()
	{
		BeginAttack(ThrowMIndex, ThrowMKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 1200);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.06);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		yield return WaitTime(0.44);
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 1200);
		yield return WaitTime(0.5);
		ShootPOS_FM = GetPosition();
		MultishootDirectio_FMn = GetForward();
		if (GetLogicTagToggleValue(_actor, "SkillTag_FMTrace"))
		{
			MThrow = MThrow_Trace;
			FanMultipleShoot(MThrow, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_FM, AlignShootDelay_FM, BulletCount_FM, Duration_FM, ShootPOS_FM, ShootPOSY_FM, MultishootDirectio_FMn, BulletDirectionOffset_FM, AimType.Default, BulletDirectionType.ActorToBullet, Angle_FM, Radius_FM, InnerRadius_FM);
			yield return WaitTime(0.3);
			BeginAttack(ThrowMTraceIndex, ThrowMTraceKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.1);
			TargetPOS = GetEntityPosition(GetCurrentPlayer());
			BulletIDList.AddRange(GetShootBulletIdList());
			LinePOS = GetBulletPosition(BulletIDList.get_Item(0));
			for (int i = 0; i < 5; i++)
			{
				LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, ShootPOS_FM, 2.5, null, LinePOS, ShootPOSY_FM, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
				yield return WaitTime(0.025);
				for (int j = 0; j < LineFxList.Count; j++)
				{
					StopEffect(LineFxList.get_Item(j));
				}
				LinePOS = GetBulletPosition(BulletIDList.get_Item(0));
			}
		}
		else
		{
			MThrow = MThrow_NOTrace;
			FanMultipleShoot(MThrow, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_FM, AlignShootDelay_FM, BulletCount_FM, Duration_FM, ShootPOS_FM, ShootPOSY_FM, MultishootDirectio_FMn, BulletDirectionOffset_FM, AimType.Default, BulletDirectionType.ActorToBullet, Angle_FM, Radius_FM, InnerRadius_FM);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
