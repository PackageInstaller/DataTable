#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

public class Skill_EarthQuake_LD : SkillScript_Base
{
	private List<LogicEntity> mateList = new List<LogicEntity>();

	private FP rotateAngleLimit;

	private static LogicEntity target;

	private List<FP> _RelativeDIST = new List<FP>();

	private int Times;

	private static readonly string WarningAreaFx = "WarningArea";

	private List<long> _ATKLFx = new List<long>();

	private TSVector2 ShootPOS;

	private List<long> lightIds = new List<long>();

	private List<CoroutineNode> moveCoroutineNodeList = new List<CoroutineNode>();

	private long FxLoopA;

	private long FxLoopB;

	private long FxLoopC;

	private long FxLoopD;

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly TSVector2 centerPosition1 = new TSVector2(8, -8);

	private readonly TSVector2 centerPosition2 = new TSVector2(-8, 8);

	private readonly TSVector2 centerPosition3 = new TSVector2(5, 5);

	private readonly TSVector2 centerPosition4 = new TSVector2(-5, -5);

	private readonly string lightSpawnFxAlias = "fx_m50011_loop_ground_wind_born";

	private readonly string lightAreaEffectAlias = "Wind_Attack_Area_Damage";

	private readonly FP light1RotateRadius = 13f;

	private readonly FP rotateAnglePerSecond = -40f;

	private readonly FP light1InitPositionAngle = 45f;

	private readonly FP light1RotateRadius2 = 13f;

	private readonly FP rotateAnglePerSecond2 = -40f;

	private readonly FP light1InitPositionAngle2 = 225f;

	private readonly FP light1RotateRadius3 = 7f;

	private readonly FP rotateAnglePerSecond3 = 40f;

	private readonly FP light1InitPositionAngle3 = 135f;

	private readonly FP light1RotateRadius4 = 7f;

	private readonly FP rotateAnglePerSecond4 = 40f;

	private readonly FP light1InitPositionAngle4 = 315f;

	protected override void OnSkillEnable()
	{
		_RelativeDIST.Clear();
		Times = 0;
	}

	protected override void OnSkillDisable()
	{
		if (_isDisableByLostControl)
		{
			Parallel.beDisable = true;
		}
		if (_ATKLFx.Count > 0)
		{
			for (int i = 0; i < _ATKLFx.Count; i++)
			{
				StopEffect(_ATKLFx.get_Item(i));
			}
		}
		mateList.AddRange(GetTargetByTeammateIndex(1));
		if (mateList.Count > 0)
		{
			KillActors(mateList);
		}
		mateList.Clear();
		SetLockToughnessDisable();
		SetCloseBlockDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		SummonTeammate(1, new TSVector2(0, 6), new TSVector2(0, -6));
		SummonTeammate(1, new TSVector2(0, -6), new TSVector2(0, 6));
		SummonTeammate(1, new TSVector2(-6, 0), new TSVector2(6, 0));
		SummonTeammate(1, new TSVector2(6, 0), new TSVector2(-6, 0));
		NovaLogger.Debug("猩猩风.裂地爬行.召唤队友");
		BeginAttack(SkillScript_Base.CrawlStartIndex, SkillScript_Base.CrawlStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.8, 225);
		yield return WaitTime(1.2);
		BeginAttack(SkillScript_Base.CrawlEndIndex, SkillScript_Base.CrawlEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(SkillScript_Base.WarningFx, 1f, 2f, GetPosition(), default, 3.5f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == SkillScript_Base.CrawlEndIndex)
		{
			Times++;
			if (Times > 3)
			{
				StopDash();
				CancelAttack();
				StopLookAt();
			}
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (new List<string> { "MoveBegin", "MoveFinish", "TurnBegin", "TurnFinish", "Attack_L", "Attack_R", "warningFxGround_R", "warningFxGround_L" }.Contains(eventName))
		{
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1.4, 2));
			TSVector2 tSVector2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.5, 1.5));
			FP fP = 3;
			FP fP2 = 60;
			switch (eventName)
			{
			case "MoveBegin":
			{
				FP distance = 99;
				FP angleLimit = 0;
				BeginDash(SkillScript_Base.earthQuakeDashIndex, GetForward(), fP, distance, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				break;
			}
			case "MoveFinish":
				StopDash();
				break;
			case "TurnBegin":
				BeginLookAt_NotWait(target, 99, 360);
				break;
			case "TurnFinish":
				StopLookAt();
				break;
			case "Attack_L":
			{
				FP radius = 3;
				Damage(tSVector, radius);
				break;
			}
			case "Attack_R":
			{
				FP radius = 2.6;
				Damage(tSVector2, radius);
				break;
			}
			case "warningFxGround_R":
			{
				FP fP3 = 19;
				TSVector2 position = TransLocalPosToWorldPos(tSVector2, GetForward(), new TSVector2(0, fP * fP3 / fP2));
				WarningFxGround(position, 2.3f, 1f);
				break;
			}
			case "warningFxGround_L":
			{
				FP fP3 = 21;
				TSVector2 position = TransLocalPosToWorldPos(tSVector, GetForward(), new TSVector2(0, fP * fP3 / fP2));
				WarningFxGround(position, 2.3f, 1f);
				break;
			}
			default:
				NovaLogger.Debug("猩猩.地鸣.无对应自定义事件case");
				break;
			}
		}
	}

	private void ElementalSkill()
	{
		int aiType = GetAiType();
		if (aiType != 0 && aiType == 1)
		{
			StartCor(LongJuanFeng());
		}
	}

	private void Damage(TSVector2 position, FP radius)
	{
		FP innerRadius = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 50011061, 0.5, HitBox.HurtAnimType.Small);
	}

	private long WarningFxGround(TSVector2 position, float playbackSpeed, float spawnSize)
	{
		return PlayEffect("fx_common_base_Fire_YuJing_circular_3", playbackSpeed, default, position, default, spawnSize);
	}
}
