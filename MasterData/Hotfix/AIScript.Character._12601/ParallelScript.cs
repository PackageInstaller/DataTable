using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12601;

public class ParallelScript : ParallelBase
{
	private readonly string areaEffect_PhoenixEgg = "AreaEffect_12601_Ultra_PhoenixEgg";

	private static readonly int fireRingTag = CommonHelper.StringToHash("126_Ultra_FireRing");

	private static readonly int maskTag = CommonHelper.StringToHash("FireMark1");

	private readonly string eggBulltKey = "126_eggTag";

	private readonly string phoenixEggKey = "126Phoenix";

	private readonly FP waitPhoenixEggTime = 0.55;

	private readonly int perkId_41 = 512641;

	private readonly int buffId_41 = 12654111;

	private readonly int perkId_42 = 512642;

	private readonly string areaEffect_PhoenixEgg_Perk42 = "AreaEffect_12601_Ultra_PhoenixEgg_Perk42";

	private readonly int perkId_43 = 512643;

	private readonly string areaEffect_PhoenixEgg_Perk43 = "AreaEffect_12601_Ultra_PhoenixEgg_Perk43";

	private readonly string areaEffect_PhoenixEgg_Perk42Perk43 = "AreaEffect_12601_Ultra_PhoenixEgg_Perk42Perk43";

	private readonly int buffId_fate1 = 12640001;

	private readonly string bullut_fate5 = "0";

	private readonly FP searchEnemyRadius = 20;

	private int buffId_F1 = 12696111;

	private int onceDamage_F2 = 12696211;

	private FP hpPercent_F2 = 0.5;

	private int buffId_F3 = 12696311;

	private int buffId_F4 = 12696411;

	private int buffId_F5 = 12696511;

	public PlayerAdventureActor mainCtrActor;

	public PlayerSkillCd skillMgr;

	private CoroutineNode corPhoenixEgg;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BLOCK", OnBulletBlock);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_BULLUT_HIT", OnBulletHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (!ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5))
		{
			return;
		}
		bool flag = true;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType != HotfixEnum.elementType.FE)
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F5, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BLOCK", OnBulletBlock);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_BULLUT_HIT", OnBulletHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StopCoroutine(ref corPhoenixEgg);
	}

	public virtual void OnUpdate()
	{
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor != null))
		{
			return;
		}
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor)
		{
			OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && adventureActorReceiveDamageBeforeHitEvent.from.Id == mainCtrActor.Id && mainCtrActor.actorHealthInfo.hpPercentage >= hpPercent_F2)
			{
				AdventureActor.AddFromAttr(onceDamage_F2, mainCtrActor);
			}
		}
		else if (adventureActorReceiveDamageBeforeHitEvent.to is PlayerAdventureActor)
		{
			OnBeforeHurt(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	private void OnReceiveHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeSettlementEvent.from is PlayerAdventureActor)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveDamageBeforeSettlementEvent);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && monsterAdventureActor != null && CommonUtils.CheckElementMark(CommonDefine.Fire, monsterAdventureActor))
			{
				(adventureActorReceiveDamageBeforeSettlementEvent.from as PlayerAdventureActor).buffComponent.AddBuff(buffId_F1, _actor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && adventureActorReceiveDamageEvent.from is PlayerAdventureActor && monsterAdventureActor != null)
		{
			OnHitPost(adventureActorReceiveDamageEvent);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (_actor != null && adventureBulletBornEvent.owner is PlayerAdventureActor)
		{
			OnBulletBorn(adventureBulletBornEvent);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (_actor != null && adventureBulletFinishEvent.owner is PlayerAdventureActor)
		{
			OnBulletFinish(adventureBulletFinishEvent);
		}
	}

	private void OnBulletBlock(IEvent evt)
	{
		AdventureBulletBlockEvent adventureBulletBlockEvent = evt as AdventureBulletBlockEvent;
		if (_actor != null && adventureBulletBlockEvent.owner is PlayerAdventureActor)
		{
			OnBulletBlock(adventureBulletBlockEvent);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
			{
				OnCrit(adventureActorReceiveCritDamageEvent);
			}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.froms.Count > 0 && adventureActorRemoveBuff.froms.Contains(_actor))
		{
			OnRemoveBuff(adventureActorRemoveBuff);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void MonsterDeath(IEvent evt)
	{
		MonsterAdventureActor monsterAdventureActor = ((AdventureMonsterDiedEvent)evt).sender as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			OnMonsterDeath(monsterAdventureActor);
		}
	}

	private void OnBulletHit(IEvent evt)
	{
		MonsterAdventureActor monsterAdventureActor = (evt as AdventureBullutHitTrigger).toActor as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			BulletHitMonster(monsterAdventureActor);
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (!(_actor != null) || adventureAreaEffectBeginEvent.owner.Id != _actor.Id)
		{
			return;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(adventureAreaEffectBeginEvent.entityID);
		if (areaEffect != null && areaEffect.CheckTag(eggBulltKey))
		{
			AreaEffect_GenerateAreaEffectComponent[] components = areaEffect.GetComponents<AreaEffect_GenerateAreaEffectComponent>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].enabled = false;
			}
			AreaEffect_PlayFxComponent[] components2 = areaEffect.GetComponents<AreaEffect_PlayFxComponent>();
			if (GetPerkLv(perkId_42, out var _))
			{
				components[0].enabled = true;
				components2[0].enabled = true;
			}
			else
			{
				components2[0].enabled = false;
			}
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		AdventureBattleReadyEvent evt2 = evt as AdventureBattleReadyEvent;
		if (_actor != null)
		{
			OnBattleReady(evt2);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	protected virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	protected virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
	}

	protected virtual void OnBeforeHurt(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
	}

	protected virtual void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && _evt.hitDamageTag != null && GetPerkLv(perkId_41, out var _) && CommonUtils.CheckHitByTag(_evt.hitDamageTag, fireRingTag))
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_41, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
	}

	protected virtual void OnBulletBorn(AdventureBulletBornEvent _evt)
	{
	}

	protected virtual void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		if (_evt.owner is PlayerAdventureActor && _evt.tag.Equals(phoenixEggKey))
		{
			StartCoroutine(ref corPhoenixEgg, PlayPhoenixEggAreaEffect(_evt.bulletPosition));
		}
	}

	protected virtual void OnBulletBlock(AdventureBulletBlockEvent _evt)
	{
	}

	protected virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	protected virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		if (mainCtrActor.Id == evt.from.Id && mainCtrActor.buffComponent.CheckBuffByBuffID(buffId_fate1))
		{
			mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_fate1);
		}
	}

	protected virtual void OnRemoveBuff(AdventureActorRemoveBuff evt)
	{
	}

	protected virtual void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.FireMark1))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F3, _actor);
		}
	}

	protected virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	protected virtual void OnMonsterDeath(MonsterAdventureActor monster)
	{
	}

	protected virtual void BulletHitMonster(MonsterAdventureActor monster)
	{
	}

	protected virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	protected virtual void OnBattleReady(AdventureBattleReadyEvent evt)
	{
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}

	private IEnumerator PlayPhoenixEggAreaEffect(TSVector2 position)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitPhoenixEggTime));
		string fxAlias = areaEffect_PhoenixEgg;
		if (GetPerkLv(perkId_43, out var lv) && GetPerkLv(perkId_42, out lv))
		{
			fxAlias = areaEffect_PhoenixEgg_Perk42Perk43;
		}
		else if (GetPerkLv(perkId_43, out lv))
		{
			fxAlias = areaEffect_PhoenixEgg_Perk43;
		}
		else if (GetPerkLv(perkId_42, out lv))
		{
			fxAlias = areaEffect_PhoenixEgg_Perk42;
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, _actor.tsTransform.Rotation);
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.FE)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}
}
