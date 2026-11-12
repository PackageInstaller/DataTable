#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_SplitThrow_LD : SkillSimpleBase
{
	private int branch;

	private const int diffTag1 = 500810000;

	private const int diffTag2 = 500810001;

	private const int diffTag3 = 500810002;

	private readonly ComboInputBuffer.ActionKey[] _ThrowKeys = new ComboInputBuffer.ActionKey[1];

	private readonly int Index_ThrowKeys = 1;

	private const string Turn = "Turn";

	private const string StopTurn = "StopTurn";

	private FP RotSpd = 180;

	private string BulletAlias = "Slime_SplitThrow_Bullet";

	private readonly bool AlignShoot;

	private readonly FP AlignShootDelay = 0;

	private readonly int BulletCount = 1;

	private readonly FP Duration = 1;

	private readonly TSVector2 RelativePoint = new TSVector2(2, 0);

	private readonly FP ShootPositionY = 0;

	private readonly FP BulletDirectionOffset = 8;

	private readonly FP Angle = 1;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 0;

	private static LogicEntity ThrowTarget;

	private static TSVector2 MultiShootDirection;

	private static TSVector2 CsOrigin;

	private static TSVector2 CsForward;

	private static TSVector2 ShootPosition;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		ThrowTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(ThrowTarget))
		{
			ThrowTarget = GetCurrentPlayer();
		}
		BeginAttack(Index_ThrowKeys, _ThrowKeys);
		yield return WaitTime(1.3);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2f, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 500810000);
		if (buffFromTarget.Count != 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 500810000:
				branch = 0;
				break;
			case 500810001:
				branch = 1;
				break;
			case 500810002:
				branch = 2;
				break;
			default:
				branch = 2;
				break;
			}
		}
		else
		{
			branch = 2;
		}
		CsOrigin = GetPosition();
		CsForward = GetForward();
		ShootPosition = TransLocalPosToWorldPos(CsOrigin, CsForward, RelativePoint);
		switch (branch)
		{
		case 0:
			BulletAlias = "Slime_SplitThrow_Bullet_E";
			break;
		case 1:
			BulletAlias = "Slime_SplitThrow_Bullet_N";
			break;
		case 2:
			BulletAlias = "Slime_SplitThrow_Bullet_H";
			break;
		default:
			BulletAlias = "Slime_SplitThrow_Bullet_H";
			break;
		}
		MultiShootDirection = GetForward();
		FanMultipleShoot(BulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopWaitLookAt();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (!(eventName == "Turn"))
		{
			if (eventName == "StopTurn")
			{
				StopWaitLookAt();
				NovaLogger.Debug("停止转向");
			}
		}
		else
		{
			WaitLookAt_NoWait(ThrowTarget, 3.3, RotSpd);
			NovaLogger.Debug("开始转向");
		}
	}
}
