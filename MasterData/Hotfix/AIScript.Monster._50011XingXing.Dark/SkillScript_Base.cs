#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Dark;

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

	protected static readonly int jumpIndex = 100;

	protected static readonly int earthQuakeDashIndex = 101;

	protected IEnumerator SummonMateBullet()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, 10, 7);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		PlayEffect("fx_m50011_base_ground_appear_dark", 1f, default, GetPosition());
		string bulletAlias = "50011XingXing_Dark_decorativeBullet";
		FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, shapeRandomPoint - GetPosition(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 1, 0, 0);
		yield break;
	}

	protected bool ReleaseCondition()
	{
		bool result = false;
		int num = (int)(long)GetLogicTagFpValue(_actor, "ReleaseInterval");
		if (num > 0)
		{
			NovaLogger.Debug("猩猩暗.通用技能脚本.不满足属性释放条件");
			SetLogicTagFpValue(_actor, "ReleaseInterval", num - 1);
		}
		else
		{
			result = true;
			SetLogicTagFpValue(_actor, "ReleaseInterval", 1);
			NovaLogger.Debug("猩猩暗.通用技能脚本.满足属性释放条件");
		}
		return result;
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
			NovaLogger.Debug("猩猩暗.通用技能.获取AI类型异常,默认为简单");
			return 0;
		}
		return 0;
	}
}
