using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot_mod4 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_H = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly string missilebullet = "Strafe_Weapon_XiaoGaoDa_MissileBullet_Earth";

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos(new TSVector2(0, 0), 0, 400);
		yield return WaitTime(0.5);
		FP dis = Distance(GetEntityPositionObsoleted(_actor), new TSVector2(0, 0));
		if (dis < 3)
		{
			MoveToPosition(new TSVector2(0, 0), 0.1f);
			WaitMoveStatus();
		}
		else
		{
			BeginAttack(1, actionKeys_H, flushInputedKeys: true);
			yield return WaitTime(1.3);
			int num = 40;
			doDash(dis, num);
			yield return WaitDashFinish();
			CancelAttack();
		}
		yield return WaitTime(0.1);
		BeginLookAtCameraDir(DirectionType.Down, 0, 700);
		BeginAttack(2, _actionKeys, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.8);
		BeginRotateAngle(720, 120);
		yield return WaitTime(6);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
