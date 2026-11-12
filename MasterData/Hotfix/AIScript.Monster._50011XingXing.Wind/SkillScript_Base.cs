#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

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

	protected IEnumerator LongJuanFeng()
	{
		int num = TSRandom.Range(0, 100);
		int num2 = 30;
		if (num < num2)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 7, 5);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			PlayAreaEffect("Wind_Attack_Bullet", shapeRandomPoint);
		}
		yield break;
	}

	protected void PlayWarningFx()
	{
		if (GetLogicTagToggleValue(_actor, "AttackTip"))
		{
			PlayEffect(WarningFx, 1f, 1.5, GetPosition(), default, 2.5f);
			SetLogicTagToggleValue(_actor, "AttackTip", value: false);
		}
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
			NovaLogger.Debug("猩猩光.通用API.获取AI类型异常,默认为简单");
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
