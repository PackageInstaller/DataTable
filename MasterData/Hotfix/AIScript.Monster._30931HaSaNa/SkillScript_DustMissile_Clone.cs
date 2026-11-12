using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustMissile_Clone : SkillSimpleBase
{
	private readonly FP startDelay = 1;

	private readonly FP shootInterval = 0;

	private readonly string fxKey_TriggerShockWave = "fx_m30931_base_Skill01_snap_lightring";

	private MonsterAdventureActor summoner;

	protected override IEnumerator DoMainLogic()
	{
		summoner = GetMonsterCloner() as MonsterAdventureActor;
		StartCor(SkillStopWhenOwnerControlled());
		int missileCount = GetLogicTagFpValue(summoner, "MissileCount").AsInt();
		yield return WaitTime(startDelay);
		while (missileCount > 0 && !summoner.IsDead())
		{
			LogicEntity attackTargetWithOwnerTauntFrom = GetAttackTargetWithOwnerTauntFrom(summoner.Id);
			TSVector2 targetPosition = GetEntityPosition(attackTargetWithOwnerTauntFrom);
			SkillScript_DustMissile_Clone skillScript_DustMissile_Clone = this;
			FP radius = 1.75;
			DeterministicShape attackShape = skillScript_DustMissile_Clone.GetShapeData(DeterministicShape.ShapeType.Circle, targetPosition, default, default, radius);
			SkillScript_DustMissile_Clone skillScript_DustMissile_Clone2 = this;
			FP knockBackForce = 15;
			FP knockBackDistance = 2;
			radius = 0.25;
			FP hitStrenth = 4;
			HitFeatureData feature = skillScript_DustMissile_Clone2.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, radius, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth, UseHitBoxPosition: true);
			PlayEarlyWarningEffect("fx_common_base_Earth_YuJing_circular_2", 1f, default, targetPosition);
			yield return WaitTime(1);
			PlayEffect("fx_m30931_base_Skill02_sandmissile_down", 1f, default, targetPosition);
			yield return WaitTime(0.26);
			PlayEffect("fx_m30931_base_Skill02_sandmissile_atk", 1f, default, targetPosition);
			long MissileLoop = PlayEffect("fx_m30931_loop_Skill02_sandmissile", 1f, default, targetPosition);
			AreaHit_Simple(_actor, attackShape, feature, 30931061, 0, HitBox.HurtAnimType.Small, "fx_common_hit_earth_magic");
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = summoner;
			adventureActorCustomEvent.eventName = "HaSaNaTriggerDevice";
			if (adventureActorCustomEvent.tsVector2ParamList == null)
			{
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>();
			}
			else
			{
				adventureActorCustomEvent.tsVector2ParamList.Clear();
			}
			PlayFx(fxKey_TriggerShockWave, 1f, 0, targetPosition, 0, null, 0.25f);
			adventureActorCustomEvent.tsVector2ParamList.Add(targetPosition);
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
			yield return WaitTime(0.25);
			StopEffect(MissileLoop);
			PlayEffect("fx_m30931_base_Skill02_sandmissile_boom", 1f, default, targetPosition);
			missileCount--;
			yield return WaitTime(shootInterval);
		}
	}

	private IEnumerator SkillStopWhenOwnerControlled()
	{
		while (true)
		{
			if (summoner.monsterToughnessInfo.isToughnessBroken)
			{
				InterruptSkill();
			}
			yield return null;
		}
	}
}
