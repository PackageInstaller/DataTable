#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_Cyclone_SC : SkillSimpleBase
{
	private string hitEffect = "fx_50601JinDuanLiRong_hit_Skill01";

	private CoroutineNode damageCor;

	private CoroutineNode CycloneMoveCor;

	private bool selfForward;

	private bool isMoveFinish;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("龙卷风.SC移动.开始");
		selfForward = false;
		isMoveFinish = false;
	}

	protected override void OnSkillDisable()
	{
		StopCor(CycloneMoveCor);
		StopCor(damageCor);
		NovaLogger.Debug("龙卷风.SC移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		long ljf = PlayEffect("fx_50601JinDuanLiRong_bullet_Cyclone");
		bool flag = false;
		if (GetTargetByTeammateIndex(0) != null && GetTargetByTeammateIndex(0).Count > 0)
		{
			flag = GetLogicTagToggleValue(GetTargetByTeammateIndex(0).get_Item(0), "IsLeftMove");
		}
		if (flag)
		{
			yield return BeginRotateAngle(60, 600);
			selfForward = true;
		}
		else
		{
			yield return BeginRotateAngle(-60, 600);
		}
		CycloneMoveCor = StartCor(CycloneMove());
		damageCor = StartCor(Damage());
		for (int i = 0; i < 100; i++)
		{
			if (isMoveFinish)
			{
				StopCor(CycloneMoveCor);
				break;
			}
			yield return WaitTime(0.1);
		}
		List<LogicEntity> actorList = new List<LogicEntity> { _actor };
		StopEffect(ljf);
		StopCor(damageCor);
		PlayEffect("fx_50601JinDuanLiRong_bullet_Cyclone_end ");
		yield return WaitTime(3);
		KillActors(actorList);
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1000; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 2);
			Skill_Cyclone_SC skill_Cyclone_SC = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_Cyclone_SC.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601092, 0.5, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.1);
		}
		yield return null;
	}

	protected IEnumerator CycloneMove()
	{
		FP dashSpeed = 5;
		while (true)
		{
			dashSpeed = TSMath.Clamp(dashSpeed, 5, 100);
			BeginDashActorForward(10, dashSpeed, 99, 999, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			if (selfForward)
			{
				BeginRotateAngle_NotWait(13, 160);
			}
			else
			{
				BeginRotateAngle_NotWait(-13, 160);
			}
			yield return WaitTime(0.1);
			StopDash();
			dashSpeed += (FP)1.15;
		}
	}

	protected override void DashFinishByObstacle(int index)
	{
		if (index == 10)
		{
			isMoveFinish = true;
		}
	}
}
