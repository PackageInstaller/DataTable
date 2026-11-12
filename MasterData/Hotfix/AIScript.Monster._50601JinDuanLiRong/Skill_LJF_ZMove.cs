#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_LJF_ZMove : SkillSimpleBase
{
	private string hitEffect = "fx_50601JinDuanLiRong_hit_Skill01";

	private CoroutineNode damageCor;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("龙卷风.Z字移动.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(damageCor);
		NovaLogger.Debug("龙卷风.Z字移动.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect("fx_common_base_Fire_YuJing_circular_2", 0.5f, default, GetPosition());
		yield return WaitTime(2);
		long ljf = PlayEffect("fx_50601JinDuanLiRong_bullet_Cyclone");
		yield return WaitTime(0.5);
		TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 6));
		bool direction = GetLogicTagToggleValue(GetTargetByTeammateIndex(0).get_Item(0), "IsLeftMove");
		tSVector = ((!direction) ? RotateTo(tSVector, -60) : RotateTo(tSVector, 60));
		MoveToPosition(tSVector, 0.3, AdventureActor.MovementMode.Walk, 3f, _stopDisIgnoreRadius: false);
		damageCor = StartCor(Damage());
		Debug.Log("禁断丽容分身.Z龙卷风.等待移动结束");
		yield return WaitMoveStatus();
		NovaLogger.Debug("禁断丽容分身.Z龙卷风.移动结束");
		yield return WaitTime(0.3);
		PlayEffect("fx_50601JinDuanLiRong_bullet_Cyclone_end_02");
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 5);
		Skill_LJF_ZMove skill_LJF_ZMove = this;
		FP hitStrenth = 2;
		HitFeatureData hitFeatureData = skill_LJF_ZMove.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601083, 0, HitBox.HurtAnimType.Small, hitEffect);
		tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4));
		tSVector = ((!direction) ? RotateTo(tSVector, 60) : RotateTo(tSVector, -60));
		MoveToPosition(tSVector, 0.2, AdventureActor.MovementMode.Walk, 2f, _stopDisIgnoreRadius: false);
		yield return WaitMoveStatus();
		List<LogicEntity> actorList = new List<LogicEntity> { _actor };
		StopEffect(ljf);
		PlayEffect("fx_50601JinDuanLiRong_bullet_Cyclone_end_02");
		shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 5);
		Skill_LJF_ZMove skill_LJF_ZMove2 = this;
		hitStrenth = 2;
		hitFeatureData = skill_LJF_ZMove2.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601083, 0, HitBox.HurtAnimType.Small, hitEffect);
		StopCor(damageCor);
		yield return WaitTime(3);
		KillActors(actorList);
		yield return null;
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1000; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 2);
			Skill_LJF_ZMove skill_LJF_ZMove = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_LJF_ZMove.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601083, 0, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.5);
		}
		yield return null;
	}
}
