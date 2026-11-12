#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Light;

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

	protected void UpdateEffectTag(bool state)
	{
		if (state)
		{
			SetLogicTagToggleValue(_actor, "IsEnhanced", value: true);
		}
		else
		{
			SetLogicTagToggleValue(_actor, "IsEnhanced", value: false);
		}
		NovaLogger.Debug("猩猩光属性.更新强化状态");
	}

	protected IEnumerator Monsterteleport()
	{
		InterruptAttack();
		SetLogicTagFpValue(_actor, "ReleaseInterval", 1);
		TSVector2 position = TeleportSelectionPos();
		SetCloseBlockEnable();
		long hidingFx = PlayEffect("fx_common_loop_hiding");
		NovaLogger.Debug("猩猩光属性.施加隐身");
		SetImmuneControlEnable();
		SkillScript_Base skillScript_Base = this;
		TSVector2 position2 = GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skillScript_Base.PlayEffect("fx_m50011_base_disappear_light", 1.5f, default, position2, tSVectToAngle);
		SkillScript_Base skillScript_Base2 = this;
		position2 = GetPosition();
		tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skillScript_Base2.PlayEffect("fx_m50011_base_change_light", 1f, default, position2, tSVectToAngle);
		long substituteFx = PlayEffect("fx_m50011_loop_substitute_light");
		MoveToPosition(position, 0.3, AdventureActor.MovementMode.Run, 2);
		yield return WaitMoveStatus();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 18600);
		yield return WaitTime(0.2);
		StopEffect(substituteFx);
		SkillScript_Base skillScript_Base3 = this;
		position2 = GetPosition();
		tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skillScript_Base3.PlayEffect("fx_m50011_base_recover_light", 1f, default, position2, tSVectToAngle);
		SkillScript_Base skillScript_Base4 = this;
		position2 = GetPosition();
		tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skillScript_Base4.PlayEffect("fx_m50011_base_appear_light", 1.5f, default, position2, tSVectToAngle);
		SetCloseBlockDisable();
		StopEffect(hidingFx);
		SetImmuneControlDisable();
		SetLogicTagToggleValue(_actor, "AttackTip", value: true);
		yield return null;
		NovaLogger.Debug("猩猩光属性.冲锋.协程结束");
	}

	protected TSVector2 TeleportSelectionPos()
	{
		TSVector2 tSVector = TSVector2.zero;
		TSVector2 position = GetPosition();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		_ = TSVector2.zero;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, Distance(position, entityPositionObsoleted) + 2, Distance(position, entityPositionObsoleted), 90, GetTSVectToAngle(entityPositionObsoleted - position, 0));
		for (int i = 0; i < 5; i++)
		{
			tSVector = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			if (QueryPositionReachable(_actor, tSVector))
			{
				break;
			}
			if (i != 4)
			{
				continue;
			}
			shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, 3, 1.5);
			for (int j = 0; j < 5; j++)
			{
				tSVector = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				if (QueryPositionReachable(_actor, tSVector))
				{
					break;
				}
			}
			tSVector = entityPositionObsoleted;
			break;
		}
		return tSVector;
	}

	protected bool TeleportCondition()
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "ReleaseInterval");
		bool result = false;
		if (logicTagFpValue <= 0)
		{
			result = true;
			NovaLogger.Debug("猩猩光.通用API.条件检测满足");
			return result;
		}
		SetLogicTagFpValue(_actor, "ReleaseInterval", logicTagFpValue - 1);
		NovaLogger.Debug("猩猩光.通用API.条件检测不满足,更新count为:" + (logicTagFpValue - 1).ToString());
		return result;
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
