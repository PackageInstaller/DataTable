#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50051DanZhuTouShou;

public class Skill_FireRock_Split_CanChaSPVer : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private static readonly string custom_Shoot = "Shoot";

	private static readonly string bulletName = "Weapon_50051DanZhuTouShou_Fire_Throw_Split_CanChaSPVer";

	private static FP MaxDis = 10;

	private static FP MinDis = 7;

	private static FP MaxAngle = 90;

	private TSVector2 SelfPos;

	private TSVector2 PlayerPos;

	private TSVector2 ShootPos;

	private List<LogicEntity> BossSelf;

	private List<LogicEntity> FriendList = new List<LogicEntity>();

	private FP Dis;

	private FP angle;

	protected override IEnumerator DoMainLogic()
	{
		BossSelf = GetTargetByTeammateIndex(0);
		if (BossSelf.Count == 0)
		{
			NovaLogger.Debug("未找到主人,技能中断");
			InterruptSkill();
			yield return null;
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Shoot)
		{
			bool flag = false;
			TSVector2[] array = new TSVector2[2]
			{
				new TSVector2(3.7, -12.5),
				new TSVector2(-3.7, -12.5)
			};
			FP fP = Distance(GetEntityPositionObsoleted(GetCurrentPlayer()), array[0]);
			FP fP2 = Distance(GetEntityPositionObsoleted(GetCurrentPlayer()), array[1]);
			if (GetTargetByTeammateIndex(2).Count != 1)
			{
				flag = true;
			}
			TSVector2 tSVector;
			if (flag)
			{
				tSVector = ((!(fP > fP2)) ? GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, array[0], default, default, 3, default, 360), GetCurrentPlayer(), isReachable: true) : GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, array[1], default, default, 3, default, 360), GetCurrentPlayer(), isReachable: true));
			}
			else
			{
				tSVector = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, array[(int)(long)GetRandomValue(0, 1.5, isInt: true)], default, default, 3, default, 360), GetCurrentPlayer(), isReachable: true);
			}
			CircleMultipleShoot(bulletName, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 1, GetPosition(), 1.7, GetPosition() - tSVector, 0, AimType.Position, BulletDirectionType.ActorToBullet, Distance(GetPosition(), tSVector), 0.5, tSVector);
		}
	}
}
