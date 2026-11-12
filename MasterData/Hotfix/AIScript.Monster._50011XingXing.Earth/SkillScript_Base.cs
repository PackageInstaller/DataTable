#define LOG_DEBUG
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class SkillScript_Base : SkillSimpleBase
{
	private const string aiTypeEasy = "Easy";

	private const string aiTypeHard = "Hard";

	protected static readonly string WarningFx = "fx_common_base_charge_fire_actor";

	protected static readonly int ATKLIndex = 0;

	protected static readonly string ATKLKey = "NormalAttack_Long";

	protected static readonly int TurnATKLIndex = 1;

	protected static readonly string TurnATKLKey = "TurnAttack_L";

	protected static readonly int TurnATKRIndex = 2;

	protected static readonly string TurnATKRKey = "TurnAttack_R";

	protected static readonly int ATKSIndex = 3;

	protected static readonly string ATKSKey = "NormalAttack_Short";

	protected static readonly int DashChargeIndex = 4;

	protected static readonly string DashChargeJumpKey = "Dash_Charge";

	protected static readonly int DashATKIndex = 5;

	protected static readonly string DashATKJumpKey = "Dash_Attack";

	protected static readonly int MoveFIndex = 6;

	protected static readonly string MoveFKey = "Move_F";

	protected static readonly int MoveBIndex = 7;

	protected static readonly string MoveBKey = "Move_B";

	protected static readonly int CrawlStartIndex = 8;

	protected static readonly string CrawlStartKey = "Crawl_Start";

	protected static readonly int CrawlEndIndex = 9;

	protected static readonly string CrawlEndKey = "Crawl_End";

	protected static readonly int DropIndex = 10;

	protected static readonly string DropAttack = "Drop_Attack";

	protected static readonly int DashIndex_Attack = 11;

	protected static readonly int ESJumpIndex = 12;

	protected static readonly string ESJumpKey = "EarthShatter_Jump";

	protected static readonly int ESATKIndex = 13;

	protected static readonly string ESATKKey = "EarthShatter_Attack";

	private readonly string bulletAliasRectangle = "50011XingXing_Earth_nullbullet_rectangle";

	private readonly string bulletAliasCircle = "50011XingXing_Earth_nullbullet_circle";

	private readonly int forwardBulletCount = 3;

	private readonly int backwardBulletCount = 1;

	private readonly FP forwardAngle = 50;

	private readonly FP backwardAngle = 20;

	protected static readonly int jumpIndex = 100;

	protected static readonly int earthQuakeDashIndex = 101;

	protected void GroundAttack(TSVector2 SpawnPos, TSVector2 SpawnForward)
	{
		TSVector2 multiShootDirection = RotateTo(SpawnForward, 180);
		FanMultipleShoot(bulletAliasCircle, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, forwardBulletCount, default, SpawnPos, 0, SpawnForward, 0, AimType.Default, BulletDirectionType.ActorToBullet, forwardAngle, 0, 0);
		FanMultipleShoot(bulletAliasCircle, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, backwardBulletCount, default, SpawnPos, 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, backwardAngle, 0, 0);
		DispatchCustomEvent("StopEnhanceFx");
	}

	protected void UpdateEffectTag()
	{
		if (!GetLogicTagToggleValue(_actor, "IsEnhanced"))
		{
			SetLogicTagToggleValue(_actor, "IsEnhanced", value: true);
			DispatchCustomEvent("PlayEnhanceFx");
			NovaLogger.Debug("猩猩土属性.更新强化状态");
		}
	}

	protected void CheckSkillcondition()
	{
		if (!GetLogicTagToggleValue(_actor, "IsEnhanced"))
		{
			return;
		}
		GroundAttack(GetPosition(), GetForward());
		SetLogicTagToggleValue(_actor, "IsEnhanced", value: false);
		List<long> list = new List<long>();
		if (GetLogicTagListLongValue(_actor, "enhancedFxID") != null && GetLogicTagListLongValue(_actor, "enhancedFxID").Count > 0)
		{
			list.AddRange(GetLogicTagListLongValue(_actor, "enhancedFxID"));
			foreach (long item in list)
			{
				StopEffect(item);
			}
		}
		list.Clear();
		list = null;
	}

	protected void UltimateGroundAttack(TSVector2 SpawnPos, TSVector2 SpawnForward, int bulletcount)
	{
		CircleMultipleShoot(bulletAliasCircle, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletcount, default, SpawnPos, 0, SpawnForward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	protected int GetAiType()
	{
		int num = 0;
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (!(monsterTagValue == "Easy"))
		{
			if (monsterTagValue == "Hard")
			{
				return 1;
			}
			NovaLogger.Debug("猩猩地.通用API.获取AI类型异常,默认为简单");
			return 0;
		}
		return 0;
	}

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			return GetAttackTarget(isUpToDate: true);
		}
		return GetCurrentPlayer();
	}
}
