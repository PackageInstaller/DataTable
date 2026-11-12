using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._15801;

public class ParallelScript_Support : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515832, out var _))
		{
			_damageTag_AddFireMark.Add(Config_Support.damageTag_AddFireMark_P32);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void GenerateSummonerController()
	{
		_summonedController = new SummonedController_Support(_actor as PlayerAdventureActor);
	}

	private void OnPlayerSpawnComplete(IEvent _)
	{
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Special && ((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent) || !(adventureBulletFinishEvent.owner == _actor))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
		if (adventureBulletBase.CheckBulletTag(Config_Support.bulletTag_Skill) && adventureBulletFinishEvent.finishReason != BulletFinishReason.Timeout && CommonUtils.HavePersonalPerk(_actor.dataID, 515821, out var perkLevel))
		{
			string fxAlias = "AreaEffect_15801_Support_Skill_Cannon_Boom_P21_Fire";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515822, out perkLevel))
			{
				fxAlias = "AreaEffect_15801_Support_Skill_Cannon_Boom_P21P22_BigFire";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, adventureBulletBase.tsTransform.Position);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor target = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515822, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			AdventureActor.AddFromAttr(15822011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515825, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			AdventureActor.AddFromAttr(15825001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515827, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27) && CommonUtils.CheckElementMark(CommonDefine.Fire, target))
		{
			AdventureActor.AddFromAttr(15827001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515822, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22) && CheckTeamIsAllFireElement())
		{
			monsterAdventureActor.buffComponent.AddBuff(15822011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515826, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			_actor.buffComponent.AddBuff(15826011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515833, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P33) && CheckTeamIsAllFireElement())
		{
			monsterAdventureActor.buffComponent.AddBuff(15833011, _actor);
		}
	}

	private bool CheckTeamIsAllFireElement()
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.FE)
			{
				return false;
			}
		}
		return true;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}
}
