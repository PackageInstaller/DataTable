#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Nothing;

public class Skill_EarthQuake_LD : SkillBaseXingXing
{
	private LogicEntity target;

	private int Times;

	private List<FP> _RelativeDIST = new List<FP>();

	private readonly int CrawlStartIndex = 2;

	private readonly string CrawlStartKey = "Crawl_Start";

	private readonly int CrawlEndIndex = 3;

	private readonly string CrawlEndKey = "Crawl_End";

	private List<long> _ATKLFx = new List<long>();

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
		SetCloseBlockDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(CrawlStartIndex, CrawlStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.8, 225);
		yield return WaitTime(1.2);
		BeginAttack(CrawlEndIndex, CrawlEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(SkillBaseXingXing.WarningFx, 1f, 2f, GetPosition(), default, 3.5f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == CrawlEndIndex)
		{
			Times++;
			if (Times > 2)
			{
				StopDash();
				CancelAttack();
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
				BeginDash(SkillBaseXingXing.earthQuakeDashIndex, GetForward(), fP, distance, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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
