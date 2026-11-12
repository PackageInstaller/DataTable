using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._50051DanZhuTouShou;

public class Skill_Water_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private static readonly string BulletName = "Weapon_DanZhuTouShou_Water_Bullet01";

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
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			if (Distance(SelfPos, GetEntityPositionObsoleted(logicEntity)) > 6)
			{
				FP radius = Distance(SelfPos, GetEntityPositionObsoleted(logicEntity));
				TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SelfPos, 1, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, radius, 0);
			}
			else
			{
				CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SelfPos, 1, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 6, 0);
			}
		}
	}
}
