using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class ParallelScript_MainControl : ParallelScript
{
	private List<MonsterAdventureActor> _summonedList_P2;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511613, out var _))
		{
			_damageTag_TriggerLandMark?.Add(Config_MainControl.damageTag_TriggerLandMark_P13);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.eventInfo.buffTags.Contains(Config_MainControl.buffTag_Strength_Skill))
		{
			FP leftTime = adventureActorGetBuff.buff.LeftTime;
			int currentBindSkillId = ((PlayerAdventureActor)_actor).playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", currentBindSkillId, leftTime.AsFloat(), a3: true);
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffTags.Contains(Config_MainControl.buffTag_Strength_Skill))
		{
			int currentBindSkillId = ((PlayerAdventureActor)_actor).playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (evt is AdventureBulletBornEvent adventureBulletBornEvent && adventureBulletBornEvent.owner == _actor)
		{
			AdventureBulletBase adventureBulletBase = adventureBulletBornEvent.sender as AdventureBulletBase;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511603, out var _) && adventureBulletBase.CheckBulletTag(Config_MainControl.bulletTag_Trigger_P3))
			{
				FP logicTagValue = _actor.logicVariable.GetLogicTagValue("TriggerBulletCount_P3");
				_actor.logicVariable.SetLogicTagValue("TriggerBulletCount_P3", logicTagValue + 1);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent) || !(adventureBulletFinishEvent.owner == _actor))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511602, out var _) && adventureBulletBase.CheckBulletTag(Config_MainControl.bulletTag_Summoned_P2))
		{
			TSVector2 dir = adventureBulletBase.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dir = (_actor.attackTarget.tsTransform.Position - adventureBulletBase.tsTransform.Position).normalized;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, 11601111, adventureBulletBase.tsTransform.Position, dir, Config_MainControl.summonCfg_Summon_P2);
		}
	}

	private void OnSummonedSpawned(IEvent evt)
	{
		if (!(evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent) || adventureMonsterSummonerSpawnedEvent.summonerId != _actor.Id || !CommonUtils.HavePersonalPerk(_actor.dataID, 511602, out var perkLevel))
		{
			return;
		}
		int num = 2;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511607, out perkLevel))
		{
			num = 3;
		}
		if (adventureMonsterSummonerSpawnedEvent.dataId != 11601111 || num <= 0)
		{
			return;
		}
		if (_summonedList_P2 == null)
		{
			_summonedList_P2 = new List<MonsterAdventureActor>();
		}
		if (_summonedList_P2.Count >= num)
		{
			_summonedList_P2.Sort((MonsterAdventureActor x, MonsterAdventureActor y) => x.monsterSummonInfo.LeftTime.CompareTo(y.monsterSummonInfo.LeftTime));
			MonsterAdventureActor monsterAdventureActor = _summonedList_P2.First();
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = monsterAdventureActor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_Summoned_DestroySelf_P2;
			monsterAdventureActor.DispatchEvent(adventureActorCustomEvent);
			_summonedList_P2.Remove(monsterAdventureActor);
		}
		MonsterAdventureActor monsterAdventureActor2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
		if (monsterAdventureActor2 != null)
		{
			_summonedList_P2.Add(monsterAdventureActor2);
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender } && sender.IsPlayerSummoned(out var summoner, out var _) && summoner == _actor && sender.dataID == 11601111 && _summonedList_P2 != null && _summonedList_P2.Count > 0)
		{
			_summonedList_P2.Remove(sender);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511606, out var perkLevel) && monsterAdventureActor.buffComponent.GetBuffNum(0, 0, Config_MainControl.buffTag_ReduceSpeed_Skill_P6) >= 3)
		{
			AdventureActor.AddFromAttr(11606001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511609, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9))
		{
			AdventureActor.AddFromAttr(11609001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511612, out perkLevel) && _actor.DistanceWithRadius(monsterAdventureActor) > Config_MainControl.addDamageDistance_P12)
		{
			AdventureActor.AddFromAttr(11612001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Bullet_Skill))
		{
			int buffID = 11690012;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511606, out var _))
			{
				buffID = 11606011;
			}
			monsterAdventureActor.buffComponent.AddBuff(buffID, _actor);
		}
	}

	protected override bool CheckWeaponCanTriggerLandMark(AdventureWeapon hitWeapon)
	{
		if (hitWeapon is AdventureBulletBase adventureBulletBase && adventureBulletBase.CheckSubTag(Config_MainControl.bulletSubTag_IsStrength))
		{
			return true;
		}
		return false;
	}

	protected override void OnTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerLandMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511613, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_TriggerLandMark_P13))
		{
			_actor.buffComponent.AddBuff(11613011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		int? a = ((PlayerAdventureActor)_actor)?.playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", a);
		_summonedList_P2?.Clear();
	}
}
