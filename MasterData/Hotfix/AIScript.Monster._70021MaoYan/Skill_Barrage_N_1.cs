using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Barrage_N_1 : SkillSimpleBase
{
	private readonly int BarrageIndex = 1;

	private readonly string BarrageCombo = "Barrage";

	private readonly int JumpIndex = 3;

	private readonly string JumpCombo = "B_Dodge";

	private readonly FP DUR_Action = 1.5;

	private readonly FP DUR_Shoot = 0.6;

	private readonly TSVector2 Origin = new TSVector2(0, 0);

	private readonly TSVector2 LookAt = new TSVector2(1, -1);

	private readonly string BulletAlias_1 = "Bullet_Barrage_Slow";

	private readonly bool AlignShoot_1 = true;

	private readonly FP AlignShootDelay_1 = 0;

	private readonly int BulletCount_1 = 12;

	private readonly FP Duration_1 = 0.6;

	private TSVector2 ShootPosition_1;

	private readonly FP ShootPositionY = 1;

	private TSVector2 MulitiShootDirection_1 = new TSVector2(0, 1);

	private readonly FP BulletDirectionOffset = 0;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 1;

	private readonly string BulletAlias_2 = "Bullet_Barrage_Slow";

	private readonly bool AlignShoot_2 = true;

	private readonly FP AlignShootDelay_2 = 0;

	private readonly int BulletCount_2 = 12;

	private readonly FP Duration_2 = 0.6;

	private readonly FP Angle = 15;

	private TSVector2 MulitiShootDirection_2;

	private readonly FP InnerRadius_2 = 1;

	private readonly string BulletAlias_3 = "Bullet_Barrage_Fast";

	private readonly bool AlignShoot_3 = true;

	private readonly FP AlignShootDelay_3 = 0;

	private readonly int BulletCount_3 = 36;

	private readonly FP Duration_3 = 0.6;

	private readonly FP InnerRadius_3 = 1;

	private FP DashDis;

	private FP DashSPD;

	private int ShootTime;

	protected override void OnSkillEnable()
	{
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 700210020);
		RemoveBuffFromTarget(_actor, 700210010);
		AddBuffToTarget(_actor, 700210000);
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
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
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		ShootPosition_1 = GetPosition();
		MulitiShootDirection_1 = GetForward();
		MulitiShootDirection_2 = RotateTo(MulitiShootDirection_1, Angle);
		for (ShootTime = 1; ShootTime <= 3; ShootTime++)
		{
			CircleMultipleShoot(BulletAlias_1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_1, AlignShootDelay_1, BulletCount_1, Duration_1, ShootPosition_1, ShootPositionY, MulitiShootDirection_1, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Radius, InnerRadius);
			yield return WaitTime(DUR_Shoot);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadMULTI");
			CircleMultipleShoot(BulletAlias_2, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_2, AlignShootDelay_2, BulletCount_2, Duration_2, ShootPosition_1, ShootPositionY, MulitiShootDirection_2, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Radius, InnerRadius_2);
			yield return WaitTime(DUR_Shoot);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadMULTI");
		}
		CircleMultipleShoot(BulletAlias_3, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_3, AlignShootDelay_3, BulletCount_3, Duration_3, ShootPosition_1, ShootPositionY, MulitiShootDirection_1, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Radius, InnerRadius_3);
		yield return WaitTime(DUR_Shoot);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_PinkBulletMULTI");
		yield return WaitTime(DUR_Action);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
