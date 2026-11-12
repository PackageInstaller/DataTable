using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Atk02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._2
	};

	private List<int> RotateList = new List<int> { -90, 180, 180, 90, 0, 0 };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(GetMonsterCloner(), 503010004) >= 1)
		{
			BeginAttack(1, Atk02, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.4, 150);
			yield return WaitCustomEvent("Spawn");
			DoAddBuff();
			DoBack();
			yield return WaitCustomEvent("Start");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 1.5, 120);
			yield return WaitTime(1.8);
			PlayEffect("Skill05_Loop_ready", 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.5)), 0);
			yield return WaitTime(0.2);
			CancelAttack();
			DoShoot02();
		}
		else
		{
			BeginAttack(1, Atk01, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.4, 150);
			yield return WaitCustomEvent("Spawn");
			DoAddBuff();
			DoBack();
			yield return WaitCustomEvent("Start");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 1.5, 120);
			yield return WaitTime(1.8);
			PlayEffect("Skill05_Loop_ready", 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.5)), 0);
			yield return WaitTime(0.2);
			CancelAttack();
			DoShoot01();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	protected void DoShoot01()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill05", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.8, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
	}

	protected void DoShoot02()
	{
		TSVector2 position = GetPosition();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill05", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.8, RotateTo(GetForward(), 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill05", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.8, RotateTo(GetForward(), 30), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill05", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.8, RotateTo(GetForward(), -30), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
	}

	protected void DoAddBuff()
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex == null || targetByTeammateIndex.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < targetByTeammateIndex.Count; i++)
		{
			LogicEntity target = targetByTeammateIndex.get_Item(i);
			if (GetBuffNum(_actor, 503010004) >= 1)
			{
				AddBuffToTarget(target, 503010001, 6);
			}
			else
			{
				AddBuffToTarget(target, 503010001, 3);
			}
		}
	}

	protected void AddNuji()
	{
		if (GetBuffNum(_actor, 503010000) < 6)
		{
			for (int i = GetBuffNum(_actor, 503010000); i < 6; i++)
			{
				int buffNum = GetBuffNum(_actor, 503010000);
				TSVector2 tSVector = new TSVector2(0, 16);
				int num = 90 - 60 * buffNum;
				TSVector2 spawnPosition = RotateTo(tSVector, num);
				int num2 = RotateList.get_Item(buffNum);
				TSVector2 spawnDirection = RotateTo(tSVector, num2);
				SummonTeammate(1, spawnPosition, spawnDirection);
				AddBuffToTarget(_actor, 503010000, 5);
			}
		}
	}

	protected void DoBack()
	{
		BeginDash(1, RotateTo(GetForward(), 180), 10, 5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
