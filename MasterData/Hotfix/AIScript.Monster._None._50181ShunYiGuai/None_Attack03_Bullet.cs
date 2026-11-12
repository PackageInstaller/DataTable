using System.Collections;
using TrueSync;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_Attack03_Bullet : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.8);
		DoShoot03();
		yield return WaitTime(0.6);
		DoShoot03();
		yield return WaitTime(0.6);
		DoShoot03();
		yield return WaitTime(0.6);
		DoShoot03();
		yield return WaitTime(2);
	}

	protected void DoShoot01()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.6f), _actor.tsTransform.Rotation);
		LogicEntity currentPlayer = GetCurrentPlayer();
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_4", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, tSVector, 1.2, GetEntityPosition(currentPlayer) - tSVector, 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
	}

	protected void DoShoot02()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.6f), _actor.tsTransform.Rotation);
		LogicEntity currentPlayer = GetCurrentPlayer();
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 1.2, GetEntityPosition(currentPlayer) - tSVector, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	protected void DoShoot03()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPosition = GetEntityPosition(currentPlayer);
		FP radius = 8;
		FP innerRadius = 7.9;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		TSVector2 multiShootDirection = entityPosition - shapeRandomPoint;
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
				TSVector2 entityPosition = GetEntityPosition(currentPlayer);
				FP radius = 5;
				FP innerRadius = 4.9;
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
				TSVector2 multiShootDirection = entityPosition - shapeRandomPoint;
				CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill03_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shapeRandomPoint, 1.2, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			}
		}
	}
}
