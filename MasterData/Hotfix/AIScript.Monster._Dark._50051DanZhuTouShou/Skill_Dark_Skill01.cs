using System.Collections;
using TrueSync;

namespace AIScript.Monster._Dark._50051DanZhuTouShou;

public class Skill_Dark_Skill01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string BulletName = "Weapon_DanZhuTouShou_Dark_Bullet02";

	private TSVector2 SelfPos;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, Attack01, flushInputedKeys: true);
		WaitLookAt_NoWait(logicEntity, 5, 60);
		yield return WaitFrame(70);
		CancelAttack();
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
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
