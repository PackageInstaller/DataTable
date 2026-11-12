#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_EarthQuake_LD : SkillScript_Base
{
	private int aiType;

	private LogicEntity target;

	private int Times;

	private FP rotateAngleLimit;

	protected override void OnSkillEnable()
	{
		Times = 0;
	}

	protected override void OnSkillDisable()
	{
		if (_isDisableByLostControl)
		{
			Parallel.beDisable = true;
		}
		SetInvincibleDisable();
		SetCloseBlockDisable();
		SetSearchedImmunityDisable();
		StopLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		yield return StartCor(ElementAttack());
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
				StopLookAt();
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
		if (comboIndex == SkillScript_Base.CrawlEndIndex && eventName == "RightHandClap")
		{
			NovaLogger.Debug("猩猩土属性.右手拍地产生地刺");
			TSVector2 spawnPos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.5, 1.5));
			TSVector2 spawnForward = RotateTo(GetForward(), -30);
			int bulletcount = 3;
			switch (GetPlayerJobType((AdventureActor)GetCurrentPlayer()))
			{
			case 1:
				bulletcount = 3;
				break;
			case 2:
				bulletcount = 5;
				spawnForward = RotateTo(GetForward(), -30 - Times * 10);
				break;
			}
			UltimateGroundAttack(spawnPos, spawnForward, bulletcount);
		}
		if (comboIndex == SkillScript_Base.CrawlEndIndex && eventName == "LeftHandClap")
		{
			NovaLogger.Debug("猩猩土属性.左手拍地产生地刺");
			TSVector2 spawnPos2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1.4, 2));
			TSVector2 spawnForward2 = RotateTo(GetForward(), 30);
			int bulletcount2 = 3;
			switch (GetPlayerJobType((AdventureActor)GetCurrentPlayer()))
			{
			case 1:
				bulletcount2 = 3;
				break;
			case 2:
				bulletcount2 = 5;
				spawnForward2 = RotateTo(GetForward(), 30 + Times * 10);
				break;
			}
			UltimateGroundAttack(spawnPos2, spawnForward2, bulletcount2);
		}
	}

	private IEnumerator ElementAttack()
	{
		switch (aiType)
		{
		case 0:
			NovaLogger.Debug("猩猩土.爬行.元素攻击进入简单判断");
			break;
		case 1:
			UpdateEffectTag();
			break;
		default:
			NovaLogger.Debug("猩猩土.爬行.获取AI类型错误,默认简单");
			break;
		}
		yield break;
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
