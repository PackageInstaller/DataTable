#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Water;

public class SkillBaseXingXing : SkillSimpleBase
{
	protected static List<long> waterAreaFxId = new List<long>();

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

	protected IEnumerator WaterArea()
	{
		if (waterAreaFxId.Count > 6)
		{
			yield break;
		}
		List<TSVector2> targetPos = new List<TSVector2>();
		targetPos.AddRange(GetAreaPos());
		if (targetPos.Count > 0 && targetPos != null)
		{
			for (int i = 0; i < targetPos.Count; i++)
			{
				waterAreaFxId.Add(PlayAreaEffect("50011XingXing_Water_warning_circle", targetPos.get_Item(i)));
				yield return WaitTime(0.2);
			}
		}
	}

	protected void TriggerArea()
	{
		List<long> list = new List<long>();
		list.AddRange(waterAreaFxId);
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (long item in list)
		{
			StopAreaEffect(item);
			if (waterAreaFxId.Contains(item))
			{
				waterAreaFxId.Remove(item);
			}
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
			NovaLogger.Debug("猩猩水.通用API.获取AI类型异常,默认为简单");
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

	private List<TSVector2> GetAreaPos()
	{
		List<TSVector2> list = new List<TSVector2>();
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
		int num = 1;
		FP radius = 2;
		int num2 = 2;
		FP radius2 = 6;
		FP innerRadius = 4;
		int num3 = 1;
		FP radius3 = 10;
		FP innerRadius2 = 9;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius);
		DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius2, innerRadius);
		DeterministicShape shapeData3 = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius3, innerRadius2);
		for (int i = 0; i < num; i++)
		{
			list.Add(GetShapeRandomPoint(shapeData, _actor, isReachable: true));
		}
		for (int j = 0; j < num2; j++)
		{
			list.Add(GetShapeRandomPoint(shapeData2, _actor, isReachable: true));
		}
		for (int k = 0; k < num3; k++)
		{
			list.Add(GetShapeRandomPoint(shapeData3, _actor, isReachable: true));
		}
		return list;
	}
}
