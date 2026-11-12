#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Fire;

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

	protected IEnumerator AreaDamage()
	{
		int num = 0;
		int num2 = 8;
		int num3 = 360 / num2;
		int num4 = 99;
		FP fP = 7;
		FP fP2 = 1;
		FP fP3 = num3;
		TSVector2 normalized = GetForward().normalized;
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < num2; i++)
		{
			TSVector2 tSVector = RotateTo(normalized, fP3 * i);
			int num5 = TSRandom.Range(-4, 6);
			while (num5 == num4 && num < 50)
			{
				num5 = TSRandom.Range(-4, 6);
				num++;
			}
			list.Add((fP + fP2 * TSRandom.Range(-4, 6)) * tSVector + TSVector2.zero);
			num4 = num5;
		}
		foreach (TSVector2 item in list)
		{
			PlayAreaEffect("Fire_Attack_Area_Damage", item, GetRandomValue(0, 360, isInt: true));
			yield return WaitTime(GetRandomValue(0.1, 0.3));
		}
	}

	protected IEnumerator AreaDamageULT()
	{
		int num = 0;
		int num2 = 8;
		int num3 = 360 / num2;
		int num4 = 99;
		FP fP = 7;
		FP fP2 = 1;
		FP fP3 = num3;
		TSVector2 normalized = GetForward().normalized;
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < num2; i++)
		{
			TSVector2 tSVector = RotateTo(normalized, fP3 * i);
			int num5 = TSRandom.Range(-4, 6);
			while (num5 == num4 && num < 50)
			{
				num5 = TSRandom.Range(-4, 6);
				num++;
			}
			list.Add((fP + fP2 * TSRandom.Range(-4, 6)) * tSVector + TSVector2.zero);
			num4 = num5;
		}
		foreach (TSVector2 item in list)
		{
			PlayAreaEffect("Fire_Attack_Area_Damage", item, GetRandomValue(0, 360, isInt: true));
			yield return WaitTime(GetRandomValue(0.1, 0.3));
		}
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
