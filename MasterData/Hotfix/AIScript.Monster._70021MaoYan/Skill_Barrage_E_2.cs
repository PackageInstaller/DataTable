#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Barrage_E_2 : SkillSimpleBase
{
	private readonly int BarrageIndex = 1;

	private readonly string BarrageCombo = "Barrage";

	private readonly int JumpIndex = 3;

	private readonly string JumpCombo = "B_Dodge";

	private readonly FP DUR_2 = 3.5;

	private readonly TSVector2 Origin = new TSVector2(0, 0);

	private readonly TSVector2 LookAt = new TSVector2(1, -1);

	private readonly string BulletAlias_1_Born = "fx_m70021_base_atk_Eyes_born";

	private long GroundFx;

	private readonly string BulletAlias_3 = "Bullet_Barrage_Slow";

	private readonly bool AlignShoot_3 = true;

	private readonly FP AlignShootDelay_3 = 0;

	private readonly int BulletCount_3 = 15;

	private readonly FP Duration_3 = 0;

	private TSVector2 ShootPosition_3;

	private readonly FP ShootPositionY_3 = 1;

	private readonly FP BulletDirectionOffset_3 = 0;

	private readonly FP Angle_3 = 140;

	private readonly FP Deflection_3 = 0;

	private TSVector2 MulitiShootDirection_3_1;

	private TSVector2 MulitiShootDirection_3_2;

	private TSVector2 MulitiShootDirection_3_3;

	private readonly FP Radius_3 = 0;

	private readonly FP InnerRadius_3 = 1.5;

	private FP DashDis;

	private FP DashSPD;

	private int BulletSUM = 32;

	private int BulletCount;

	private FP FxPositionY = 1;

	private TSVector2 FxPosition_01;

	private TSVector2 FxPosition_02;

	private FP FxAngle_01;

	private FP FxAngle_02;

	private FP SafeAngle;

	private List<long> FXID_01 = new List<long>
	{
		0L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L,
		10L, 11L, 12L, 13L, 14L
	};

	private List<long> FXID_02 = new List<long>
	{
		0L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L,
		10L, 11L, 12L, 13L, 14L
	};

	private int FxAngleValue = 90;

	private int FxAngleValue02 = 30;

	private LogicEntity Target;

	protected override void OnSkillEnable()
	{
		BulletCount = 0;
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 700210020);
		RemoveBuffFromTarget(_actor, 700210000);
		AddBuffToTarget(_actor, 700210010);
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopEffect(GroundFx);
		for (int i = 0; i < FXID_01.Count; i++)
		{
			StopEffect(FXID_01.get_Item(i));
		}
		for (int j = 0; j < FXID_02.Count; j++)
		{
			StopEffect(FXID_02.get_Item(j));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("减益"));
		BeginAttack(JumpIndex, JumpCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return BeginLookAtByPos(Origin, 0, 720);
		DashDis = Distance(GetPosition(), Origin);
		DashSPD = DashDis / 0.4;
		BeginDashActorForward(2, DashSPD, DashDis, 360, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return BeginLookAtByPos(LookAt, 0, 720);
		yield return WaitTime(0.3);
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			Target = _actor;
		}
		BeginAttack(BarrageIndex, BarrageCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		GroundFx = PlayEffect("fx_m70021_loop_atk_Eyes_Loop_ground", 1f, default, GetPosition());
		yield return WaitTime(0.5);
		SafeAngle = GetTSVectToAngle(GetEntityPositionObsoleted(Target) - GetPosition(), GetRandomValue(-45, 45));
		FxAngle_01 = SafeAngle + 20;
		FxAngle_02 = SafeAngle - 20;
		FxPosition_01 = RotateTo(new TSVector2(0, 1.5), FxAngle_01);
		FxPosition_02 = RotateTo(new TSVector2(0, 1.5), FxAngle_02);
		for (int i = 0; i < 15; i++)
		{
			FXID_01.set_Item(i, PlayEffect(BulletAlias_1_Born, 1f, FxPositionY, FxPosition_01, FxAngle_01));
			FXID_02.set_Item(i, PlayEffect(BulletAlias_1_Born, 1f, FxPositionY, FxPosition_02, FxAngle_02));
			FxPosition_01 = RotateTo(FxPosition_01, 10);
			FxAngle_01 += (FP)10;
			FxPosition_02 = RotateTo(FxPosition_02, -10);
			FxAngle_02 -= (FP)10;
		}
		yield return WaitTime(1);
		StopEffect(GroundFx);
		for (int j = 0; j < 15; j++)
		{
			StopEffect(FXID_01.get_Item(j));
			StopEffect(FXID_02.get_Item(j));
		}
		ShootPosition_3 = GetPosition();
		MulitiShootDirection_3_1 = RotateTo(new TSVector2(0, 1.5), SafeAngle + 90);
		MulitiShootDirection_3_2 = RotateTo(new TSVector2(0, 1.5), SafeAngle - 90);
		for (int k = 0; k < 6; k++)
		{
			FanMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_3, ShootPositionY_3, MulitiShootDirection_3_1, BulletDirectionOffset_3, AimType.Default, BulletDirectionType.ActorToBullet, Angle_3, Radius_3, InnerRadius_3);
			FanMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_3, ShootPositionY_3, MulitiShootDirection_3_2, BulletDirectionOffset_3, AimType.Default, BulletDirectionType.ActorToBullet, Angle_3, Radius_3, InnerRadius_3);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadMULTI");
			MulitiShootDirection_3_1 = RotateTo(MulitiShootDirection_3_1, -10);
			MulitiShootDirection_3_2 = RotateTo(MulitiShootDirection_3_2, -10);
			yield return WaitTime(0.2);
		}
		NovaLogger.Debug("射击结束");
		yield return WaitTime(0.3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
