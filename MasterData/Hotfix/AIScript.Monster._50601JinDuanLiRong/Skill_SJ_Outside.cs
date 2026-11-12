#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_SJ_Outside : SkillSimpleBase
{
	private long sjOut;

	private CoroutineNode MoveCor;

	private CoroutineNode DamageCor;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("梳子.外移动.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamageCor);
		NovaLogger.Debug("梳子.外移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		sjOut = PlayEffect("fx_50601JinDuanLiRong_loop_FA_shuiziC", 1f, default, default, default, 0.9f);
		StartCor(CheckState());
		BeginLookAtByPos_NotWait(TSVector2.zero, 99, 9999);
		yield return WaitTime(1);
		MoveCor = StartCor(Move());
		DamageCor = StartCor(Damage());
		yield return WaitTime(99);
		StopLookAt();
		yield return null;
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 10000; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -2.5)), 0.8, 4.5, default, default, default, GetTSVectToAngle(GetForward(), 180));
			Skill_SJ_Outside skill_SJ_Outside = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_SJ_Outside.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601090, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return null;
		}
		yield return null;
	}

	protected IEnumerator Move()
	{
		Dash dash = BeginDash(12, RotateTo(GetPosition() - TSVector2.zero, 90), 17, 999, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), TSVector2.zero) <= 13.2)
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 80);
			}
			else if (Distance(GetPosition(), TSVector2.zero) >= 13.7)
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 100);
			}
			else
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 90);
			}
			yield return WaitFrame(1);
		}
	}

	protected IEnumerator CheckState()
	{
		for (int i = 0; i < 999; i++)
		{
			if (GetLogicTagToggleValue(_actor, "Stop"))
			{
				StopEffect(sjOut);
				PlayEffect("fx_50601JinDuanLiRong_base_FA_shuiziC_end");
				StopCor(MoveCor);
				StopCor(DamageCor);
				break;
			}
			yield return WaitTime(0.1);
		}
		yield return WaitTime(1);
		KillActors(new List<LogicEntity> { _actor });
		yield return null;
	}
}
