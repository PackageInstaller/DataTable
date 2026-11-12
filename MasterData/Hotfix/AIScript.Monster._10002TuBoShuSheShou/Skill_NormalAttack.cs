using System.Collections;
using TrueSync;

namespace AIScript.Monster._10002TuBoShuSheShou;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private static readonly string custom_Shoot = "Shoot";

	private static readonly FP MaxDis = 15;

	private static readonly FP MinDis = 3;

	private static readonly FP MaxAngle = 90;

	private static readonly TSVector2 DefaultPoint = new TSVector2(0, 5);

	private TSVector2 SelfPos;

	private TSVector2 PlayerPos;

	private FP Dis;

	private FP angle;

	private string BulletType;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn)
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
		if (eventName == custom_Shoot)
		{
			SelfPos = GetPosition();
			LogicEntity attackTarget = GetAttackTarget();
			if (attackTarget != null)
			{
				PlayerPos = GetEntityPositionObsoleted(attackTarget);
				Dis = Distance(SelfPos, PlayerPos);
				angle = CalcAngleBetweenSelfAndAttackTarget();
				Dis = TSMath.Clamp(Dis, MinDis, MaxDis);
				angle = TSMath.Clamp(angle, angle, MaxAngle);
			}
			else
			{
				PlayerPos = TransLocalPosToWorldPos(SelfPos, _actor.tsTransform.Forward, DefaultPoint);
			}
			if (GetLogicTagStringValue(_actor, "Type") == "Purple")
			{
				BulletType = "Weapon_10002TuBoShuSheShou_Throw_Purple";
			}
			else
			{
				BulletType = "Weapon_10002TuBoShuSheShou_Throw";
			}
			CircleMultipleShoot(BulletType, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 1, SelfPos, 1.7, _actor.tsTransform.Forward, angle, AimType.Default, BulletDirectionType.ActorToBullet, Dis, 0.5);
		}
	}
}
