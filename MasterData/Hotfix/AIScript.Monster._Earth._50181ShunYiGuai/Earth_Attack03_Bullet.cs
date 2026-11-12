using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Attack03_Bullet : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(GetMonsterCloner(), 501810002) >= 1 && GetBuffNum(GetMonsterCloner(), 501810001) >= 1)
		{
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
			yield return WaitTime(0.8);
			DoShoot03();
			yield return WaitTime(0.4);
			DoShoot03();
			yield return WaitTime(0.4);
			DoShoot03();
			yield return WaitTime(0.4);
			DoShoot03();
		}
		else
		{
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
			yield return WaitTime(0.4);
			DoShoot01();
		}
		yield return WaitTime(5);
	}

	protected void DoShoot01()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.6f), _actor.tsTransform.Rotation);
		LogicEntity currentPlayer = GetCurrentPlayer();
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_4", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, tSVector, 1.2, GetEntityPositionObsoleted(currentPlayer) - tSVector, 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
	}

	protected void DoShoot02()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.6f), _actor.tsTransform.Rotation);
		LogicEntity currentPlayer = GetCurrentPlayer();
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 1.2, GetEntityPositionObsoleted(currentPlayer) - tSVector, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	protected void DoShoot03()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
		FP radius = 5;
		FP innerRadius = 4.9;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		TSVector2 multiShootDirection = entityPositionObsoleted - shapeRandomPoint;
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shapeRandomPoint, 1.2, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	private void OnBulletFinish(IEvent e)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = e as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.finishReason == BulletFinishReason.Timeout)
		{
			if (adventureBulletFinishEvent.tag == "ShunYiGuai_Skill03_A")
			{
				TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
				TSVector2 forward = GetForward();
				CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, bulletPosition, 1.2, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
				CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_1_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, bulletPosition, 1.2, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1.5);
			}
			if (adventureBulletFinishEvent.tag == "ShunYiGuai_Skill03_B")
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
				FP radius = 5;
				FP innerRadius = 4.9;
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
				TSVector2 multiShootDirection = entityPositionObsoleted - shapeRandomPoint;
				CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shapeRandomPoint, 1.2, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			}
		}
	}
}
