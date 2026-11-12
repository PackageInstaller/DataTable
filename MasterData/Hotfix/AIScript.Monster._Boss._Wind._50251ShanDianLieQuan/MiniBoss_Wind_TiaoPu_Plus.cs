using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Wind._50251ShanDianLieQuan;

public class MiniBoss_Wind_TiaoPu_Plus : SkillSimpleBase
{
	private readonly string StrongJumpAttack = "StrongJumpAttack";

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private readonly FP JumpTime = 0.35;

	private readonly string WindBall = "Bullet_50251_MiniBoss_Wind_TiaoPu";

	private LogicEntity Targetenemy;

	private TSVector2 JumpPos;

	private long WarningArea;

	private int BulletNum;

	private CoroutineNode BulletFinishNode;

	protected override void OnSkillEnable()
	{
		BulletNum = 0;
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopCor(BulletFinishNode);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 5, 360);
		BeginAttack(1, StrongJumpAttack, flushInputedKeys: true);
		WarningArea = PlayAreaEffect("Area_50251_MiniBoss_Wind_TiaoPuPlus_Warning_2m");
		yield return WaitCustomEvent("Fire");
		JumpPos = GetEntityPosition(Targetenemy);
		StopWaitLookAt();
		WindBallFire();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		StartCor(ref BulletFinishNode, BulletFinish());
		yield return WaitTime(1.5);
		PlayEffect("fx_m50251_base_Wind_Atk04_ElectricEnergy");
		CancelAttack();
		yield return WaitCustomEvent("A1");
		Dash();
		yield return WaitDashFinish();
		DashMove();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, Move, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		yield return BeginLookAt(Targetenemy, 2, 60);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, Distance(GetPosition(), JumpPos) / JumpTime, Distance(GetPosition(), JumpPos), 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 2, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void WindBallFire()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			FanMultipleShoot(WindBall, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0.5, 2, 0, GetPosition(), 1, GetForward(), 0, AimType.Position, BulletDirectionType.ActorToBullet, 120, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true), 2, JumpPos);
		}
		else
		{
			Shoot(WindBall, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5)), 1, 0, GetForward(), AimType.Position, BulletDirectionType.ActorToBullet, JumpPos);
		}
	}

	private void OnBulletFinish(IEvent e)
	{
		if (!(e is AdventureBulletFinishEvent { tag: "Bullet_50251_MiniBoss_Wind_TiaoPu" }))
		{
			return;
		}
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			BulletNum++;
			if (BulletNum == 2)
			{
				PlayAreaEffect("Area_50251_MiniBoss_Wind_4m", JumpPos);
			}
		}
		else
		{
			PlayAreaEffect("Area_50251_MiniBoss_Wind_3m", JumpPos);
		}
	}

	protected IEnumerator BulletFinish()
	{
		while (true)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(0.5, JumpPos, list, 32768);
			for (int i = 0; i < list.Count; i++)
			{
				AdventureBullet adventureBullet = list.get_Item(i).Entity as AdventureBullet;
				if (adventureBullet != null && adventureBullet.owner == _actor)
				{
					adventureBullet.Finish(cancel: true);
				}
			}
			yield return null;
		}
	}
}
