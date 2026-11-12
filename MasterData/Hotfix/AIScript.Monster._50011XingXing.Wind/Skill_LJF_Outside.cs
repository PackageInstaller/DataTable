#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

public class Skill_LJF_Outside : SkillSimpleBase
{
	private bool interrupted;

	private long sjOut;

	private CoroutineNode MoveCor;

	private CoroutineNode DamageCor;

	protected override void OnSkillEnable()
	{
		interrupted = true;
		NovaLogger.Debug("龙卷风.外移动.开始");
		SetImmuneControlEnable();
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override void OnSkillDisable()
	{
		if (interrupted)
		{
			StopEffect(sjOut);
		}
		StopCor(DamageCor);
		StopCor(MoveCor);
		NovaLogger.Debug("龙卷风.外移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		sjOut = PlayEffect("fx_common_base_Fire_YuJing_circular_2", 0.5f, default, GetPosition());
		yield return WaitTime(2.2);
		PlayEffect("fx_m50011_loop_ground_atk_wind_root");
		NovaLogger.Debug("龙卷风.外移动.播放特效");
		BeginLookAtByPos_NotWait(TSVector2.zero, 99, 9999);
		yield return WaitTime(1);
		MoveCor = StartCor(Move());
		DamageCor = StartCor(Damage());
		yield return WaitTime(8);
		interrupted = false;
		StopLookAt();
		KillActors(new List<LogicEntity> { _actor });
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 10000; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 2);
			Skill_LJF_Outside skill_LJF_Outside = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_LJF_Outside.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601098, 0.5, HitBox.HurtAnimType.Small, "fx_common_hit_wind_strike");
			yield return WaitTime(0.5);
		}
		yield return null;
	}

	protected IEnumerator Move()
	{
		Dash dash = BeginDash(12, RotateTo(GetPosition() - TSVector2.zero, 90), 10, 999, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 9999; i++)
		{
			if (Distance(GetPosition(), TSVector2.zero) <= 12.2)
			{
				dash._direction = RotateTo(GetPosition() - TSVector2.zero, 80);
			}
			else if (Distance(GetPosition(), TSVector2.zero) >= 12.7)
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
}
