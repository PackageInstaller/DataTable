#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Vine : SkillSimpleBase
{
	private static readonly int VineIndex = 4;

	private static readonly string VineAttack = "Vine";

	private static readonly string FxFlash = "fx_common_base_charge_monster_2";

	private static readonly TSVector2 BulletPOS01 = new TSVector2(-2, 3);

	private static readonly TSVector2 BulletPOS02 = new TSVector2(4, 2);

	private static readonly string BulletAlias = "VineBullet";

	private static readonly bool AlignShoot = false;

	private static readonly FP AlignShootDelay = 0;

	private static readonly int BulletCount = 1;

	private static readonly FP Duration = 1;

	private static TSVector2 ShootPoint;

	private static readonly FP ShootPositionY = 0;

	private static TSVector2 MultiShootDirection;

	private static readonly FP BulletDirectionOffset = 0;

	private static readonly FP Radius = 0;

	private static readonly FP InnerRadius = 0;

	private static TSVector2 TargetPosition;

	private FP Angle = 0;

	private static int AttackTimes;

	private static CoroutineNode TimeLimit;

	private static LogicEntity Target;

	private static TSVector2 SelfPOS;

	private static TSVector2 SelfForward;

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
		StopCor(TimeLimit);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(Vine_Logic());
	}

	protected IEnumerator Vine_Logic()
	{
		SelfPOS = GetPosition();
		SelfForward = GetForward();
		TimeLimit = StartCor(SkillDuration());
		BeginAttack(VineIndex, VineAttack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		PlayEffect(FxFlash, 1f, 5, SelfPOS);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.3);
		Target = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(Target))
		{
			for (int i = 0; i < 2; i++)
			{
				switch (i)
				{
				case 0:
					ShootPoint = TransLocalPosToWorldPos(SelfPOS, SelfForward, BulletPOS01);
					break;
				case 1:
					ShootPoint = TransLocalPosToWorldPos(SelfPOS, SelfForward, BulletPOS02);
					break;
				}
				TargetPosition = GetEntityPositionObsoleted(Target);
				MultiShootDirection = TargetPosition - ShootPoint;
				FanMultipleShoot(BulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPoint, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Target, BulletDirectionType.BulletToTarget, Angle, Radius, InnerRadius, TargetPosition, Target);
			}
		}
		else
		{
			yield return WaitTime(1);
			CancelAttack();
		}
		TriggerOpLisener("Bubble2");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(TimeLimit);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == VineIndex)
		{
			AttackTimes++;
			if (AttackTimes == 1)
			{
				CancelAttack();
			}
		}
	}

	protected IEnumerator SkillDuration()
	{
		yield return WaitTime(10);
		CancelAttack();
		NovaLogger.Debug("异常结束");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}
}
