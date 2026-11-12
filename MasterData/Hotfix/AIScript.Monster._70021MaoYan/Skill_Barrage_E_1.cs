#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Barrage_E_1 : SkillSimpleBase
{
	private readonly int BarrageIndex = 1;

	private readonly string BarrageCombo = "Barrage";

	private readonly int JumpIndex = 3;

	private readonly string JumpCombo = "B_Dodge";

	private readonly FP DUR_2 = 2;

	private readonly TSVector2 Origin = new TSVector2(0, 0);

	private readonly TSVector2 LookAt = new TSVector2(1, -1);

	private readonly string BulletAlias_1 = "Bullet_Barrage_Slow";

	private readonly string BulletAlias_1_Born = "fx_m70021_base_atk_Eyes_born";

	private readonly bool AlignShoot_1 = true;

	private readonly FP AlignShootDelay_1 = 0;

	private readonly int BulletCount_1 = 18;

	private readonly FP Duration_1 = 0;

	private TSVector2 ShootPosition_1;

	private readonly FP ShootPositionY = 1;

	private TSVector2 MulitiShootDirection_1 = new TSVector2(0, 1);

	private readonly FP BulletDirectionOffset = 0;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 1.5;

	private long GroundFX;

	private readonly string BulletAlias_2 = "Bullet_Barrage_Fast";

	private readonly string BulletAlias_2_Born = "fx_m70021_base_atk_Eyes_born_2";

	private readonly bool AlignShoot_2 = true;

	private readonly FP AlignShootDelay_2 = 0;

	private readonly int BulletCount_2 = 18;

	private readonly FP Duration_2 = 0;

	private readonly FP Angle = 10;

	private TSVector2 MulitiShootDirection_2;

	private readonly FP InnerRadius_2 = 1.5;

	private readonly string BulletAlias_3 = "Bullet_Barrage_Slow";

	private readonly bool AlignShoot_3 = true;

	private readonly FP AlignShootDelay_3 = 0;

	private readonly int BulletCount_3 = 6;

	private readonly FP Duration_3 = 1;

	private TSVector2 ShootPosition_3;

	private readonly FP ShootPositionY_3 = 1;

	private readonly FP BulletDirectionOffset_3 = 0;

	private readonly FP Angle_3 = 60;

	private readonly FP Deflection_3 = 120;

	private TSVector2 MulitiShootDirection_3_1 = new TSVector2(1, -1);

	private TSVector2 MulitiShootDirection_3_2;

	private TSVector2 MulitiShootDirection_3_3;

	private readonly FP Radius_3 = 0;

	private readonly FP InnerRadius_3 = 1.5;

	private TSVector2 FxPOS;

	private FP DashDis;

	private FP DashSPD;

	private int BulletSUM = 2;

	private int BulletCount;

	private FP FxPositionY = 1;

	private TSVector2 FxPosition;

	private FP FxAngle;

	private List<long> FXID = new List<long>
	{
		0L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L,
		10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 19L,
		20L, 21L, 22L, 23L
	};

	private int FxAngleValue = 90;

	private int FxAngleValue02 = 30;

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
		for (int i = 0; i < FXID.Count; i++)
		{
			StopEffect(FXID.get_Item(i));
		}
		StopEffect(GroundFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		BeginAttack(JumpIndex, JumpCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return BeginLookAtByPos(Origin, 0, 720);
		DashDis = Distance(GetPosition(), Origin);
		DashSPD = DashDis / 0.4;
		BeginDashActorForward(2, DashSPD, DashDis, 360, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return BeginLookAtByPos(LookAt, 0, 720);
		yield return WaitTime(0.3);
		BeginAttack(BarrageIndex, BarrageCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		FxPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5));
		FxAngle = GetTSVectToAngle(new TSVector2(0, 1) - new TSVector2(0, 0), 0);
		FxPOS = GetPosition();
		GroundFX = PlayEffect("fx_m70021_loop_atk_Eyes_Loop_ground", 1f, default, FxPOS);
		yield return WaitTime(0.5);
		while (BulletCount <= BulletSUM)
		{
			if (BulletCount == 0)
			{
				for (int i = 0; i < 4; i++)
				{
					FXID.set_Item(i, PlayEffect(BulletAlias_1_Born, 1f, FxPositionY, RotateTo(FxPosition, FxAngleValue * i), GetTSVectToAngle(RotateTo(FxPosition, FxAngleValue * i), 0)));
				}
			}
			else if (BulletCount == 1)
			{
				for (int j = 4; j < 8; j++)
				{
					FXID.set_Item(j, PlayEffect(BulletAlias_1_Born, 1f, FxPositionY, RotateTo(FxPosition, FxAngleValue * j), GetTSVectToAngle(RotateTo(FxPosition, FxAngleValue * j), 0)));
				}
			}
			else if (BulletCount == 2)
			{
				for (int k = 8; k < 12; k++)
				{
					FXID.set_Item(k, PlayEffect(BulletAlias_1_Born, 1f, FxPositionY, RotateTo(FxPosition, FxAngleValue * k), GetTSVectToAngle(RotateTo(FxPosition, FxAngleValue * k), 0)));
				}
			}
			FxPosition = RotateTo(FxPosition, 30);
			FxAngle = GetTSVectToAngle(FxPosition, 0);
			yield return WaitTime(0.5);
			NovaLogger.Debug(BulletCount);
			BulletCount++;
		}
		yield return WaitTime(0.3);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		ShootPosition_1 = GetPosition();
		MulitiShootDirection_1 = GetForward();
		for (int l = 0; l < 12; l++)
		{
			StopEffect(FXID.get_Item(l));
		}
		CircleMultipleShoot(BulletAlias_1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_1, AlignShootDelay_1, BulletCount_1, Duration_1, ShootPosition_1, ShootPositionY, MulitiShootDirection_1, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Radius, InnerRadius);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadMULTI");
		FxPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5));
		FxAngle = GetTSVectToAngle(FxPosition, 0);
		yield return WaitTime(0.5);
		for (int m = 0; m < 24; m++)
		{
			FXID.set_Item(m, PlayEffect(BulletAlias_2_Born, 1f, FxPositionY, FxPosition, FxAngle));
			FxPosition = RotateTo(FxPosition, 15);
			FxAngle += (FP)15;
		}
		yield return WaitTime(0.5);
		for (int n = 0; n < 24; n++)
		{
			StopEffect(FXID.get_Item(n));
		}
		MulitiShootDirection_2 = RotateTo(MulitiShootDirection_1, Angle);
		CircleMultipleShoot(BulletAlias_2, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_2, AlignShootDelay_2, BulletCount_2, Duration_2, ShootPosition_1, ShootPositionY, MulitiShootDirection_2, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Radius, InnerRadius_2);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_PinkBulletMULTI");
		ShootPosition_3 = GetPosition();
		MulitiShootDirection_3_2 = RotateTo(MulitiShootDirection_3_1, Deflection_3);
		MulitiShootDirection_3_3 = RotateTo(MulitiShootDirection_3_2, Deflection_3);
		FanMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_3, ShootPositionY_3, MulitiShootDirection_3_1, BulletDirectionOffset_3, AimType.Default, BulletDirectionType.ActorToBullet, Angle_3, Radius_3, InnerRadius_3);
		FanMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_3, ShootPositionY_3, MulitiShootDirection_3_2, BulletDirectionOffset_3, AimType.Default, BulletDirectionType.ActorToBullet, Angle_3, Radius_3, InnerRadius_3);
		FanMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_3, ShootPositionY_3, MulitiShootDirection_3_3, BulletDirectionOffset_3, AimType.Default, BulletDirectionType.ActorToBullet, Angle_3, Radius_3, InnerRadius_3);
		yield return WaitTime(Duration_3);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadMULTI");
		yield return WaitTime(1);
		StopEffect(GroundFX);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
