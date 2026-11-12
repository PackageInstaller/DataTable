#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_SJ_Inside : SkillSimpleBase
{
	private CoroutineNode DamageCor;

	private long sjIn;

	private CoroutineNode MoveCor;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("梳子.内移动.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamageCor);
		NovaLogger.Debug("梳子.内移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		sjIn = PlayEffect("fx_50601JinDuanLiRong_loop_FA_shuiziA", 1f, default, default, default, 0.9f);
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
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -3)), 0.8, 4.5, default, default, default, GetTSVectToAngle(GetForward(), 180));
			Skill_SJ_Inside skill_SJ_Inside = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_SJ_Inside.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601088, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return null;
		}
		yield return null;
	}

	protected IEnumerator Move()
	{
		Dash dash = BeginDash(11, RotateTo(GetPosition() - TSVector2.zero, 90), 1.2, 999, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), TSVector2.zero) <= 0.7)
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 87);
			}
			else if (Distance(GetPosition(), TSVector2.zero) >= 1.3)
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 93);
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
				StopEffect(sjIn);
				PlayEffect("fx_50601JinDuanLiRong_base_FA_shuiziA_end");
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
