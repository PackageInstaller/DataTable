using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50051DanZhuTouShou;

public class Skill_FireRock_Split_CanChaSPVer_Test : SkillSimpleBase
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
		BossSelf = GetTargetByDataID(9999551);
		if (BossSelf.Count == 0)
		{
			BossSelf = GetTargetByDataID(5050700);
		}
		if (BossSelf.Count != 0)
		{
			AttackHint();
			BeginAttack(1, _actionKeys, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			AttackHintEnd();
		}
	}

	protected override void OnSkillDisable()
	{
		AttackHintCancel();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn)
		{
			WaitLookAt_NoWait(BossSelf.get_Item(0), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
		if (!(eventName == custom_Shoot))
		{
			return;
		}
		FriendList = GetTargetByDataID(9999973);
		if (FriendList.Count == 0)
		{
			FriendList = GetTargetByDataID(5002113);
		}
		if (FriendList.Contains(_actor))
		{
			FriendList.Remove(_actor);
		}
		if (FriendList.Count > 0)
		{
			SetLogicTagFpValue(_actor, "FriendPos_x", FriendList.get_Item(0).tsTransform.Position.x);
			SetLogicTagFpValue(_actor, "FriendPos_y", FriendList.get_Item(0).tsTransform.Position.y);
			SetLogicTagToggleValue(_actor, "SPThrowOver", value: false);
			SelfPos = GetPosition();
			if (BossSelf.Count > 0)
			{
				PlayerPos = GetEntityPositionObsoleted(BossSelf.get_Item(0));
				Dis = Distance(SelfPos, PlayerPos);
				Dis = TSMath.Clamp(Dis, MinDis, MaxDis);
				Dis += TSRandom.Range(FP.Zero, 3);
				angle = TSRandom.Range(-2, 2);
				CircleMultipleShoot(bulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 1, SelfPos, 1.7, _actor.tsTransform.Forward, angle, AimType.Default, BulletDirectionType.ActorToBullet, Dis, 0.5);
			}
		}
		else if (!GetLogicTagToggleValue(_actor, "SPThrowOver"))
		{
			SetLogicTagToggleValue(_actor, "SPThrowOver", value: true);
			ShootPos.x = GetLogicTagFpValue(_actor, "FriendPos_x");
			ShootPos.y = GetLogicTagFpValue(_actor, "FriendPos_y") + 1;
			SelfPos = GetPosition();
			CircleMultipleShoot(bulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 1, SelfPos, 1.7, _actor.tsTransform.Forward, angle, AimType.Position, BulletDirectionType.BulletToTarget, Dis, 0.5, ShootPos);
		}
	}
}
