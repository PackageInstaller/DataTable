using System.Collections;
using TrueSync;

namespace AIScript.Monster._50051DanZhuTouShou;

public class Skill_Dark_Vampire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private static readonly string BulletName = "Weapon_DanZhuTouShou_Dark_Bullet01";

	private TSVector2 SelfPos;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Turn" && CheckTargetIsValid(GetAttackTarget()))
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == "StopTurn")
		{
			StopWaitLookAt();
		}
		if (eventName == "Shoot")
		{
			SelfPos = GetPosition();
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
			FP radius = 5;
			FP innerRadius = 0;
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SelfPos, 1, GetForward(), 0, AimType.Position, BulletDirectionType.ActorToBullet, Distance(GetPosition(), shapeRandomPoint), 0, shapeRandomPoint);
		}
	}
}
