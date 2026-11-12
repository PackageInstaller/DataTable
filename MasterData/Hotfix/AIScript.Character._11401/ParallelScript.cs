using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class ParallelScript : ParallelBase
{
	public int hitTag_Normal = CommonHelper.StringToHash("Normal");

	public int hitTag_Skill = CommonHelper.StringToHash("Skill");

	public int hitTag_Ultra = CommonHelper.StringToHash("Ultra");

	public int hitTag_Ultra_P41 = CommonHelper.StringToHash("Ultra_P41");

	public int hitTag_MS1 = CommonHelper.StringToHash("114_Long_Bullet");

	public int hitTag_MS2 = CommonHelper.StringToHash("114_Short_Bullet");

	public int hitTag_MS2_2 = CommonHelper.StringToHash("114_Short_DoT");

	public int hitTag_MS2_P3 = CommonHelper.StringToHash("114_Short_DoT");

	public int hitTag_SS = CommonHelper.StringToHash("114_B2");

	public int hitTag_SS_1 = CommonHelper.StringToHash("114_B2_Bullet");

	public int hitTag_P22 = CommonHelper.StringToHash("114_P22");

	public int hitTag_TriggerFire = CommonHelper.StringToHash("114_FireTag1_Trigger");

	public string fireAreaEffect = "AreaEffect_114_FireTag1_Boom";

	private const string tipsKey_TriggerMark = "FireMark_Trigger_Effect_02";

	private int buffMark = 11440001;

	private int perkId_12 = 511412;

	private int buff_12_atkspk = 11412012;

	private const int perkId_41 = 511441;

	private int hitDmgId_41 = 114541001;

	private string hittedFx_41 = "fx_11401_hit_Ultra_Shoot_P41_Boom";

	private const int perkId_42 = 511442;

	private const int once_42 = 11442001;

	private const int perkId_43 = 511443;

	private int once_43 = 11443001;

	public static int perkId_mt = 9114999;

	private const int maxAmmount_mt = 99999;

	public static int perkId_st = 9114998;

	public static FP totleTime_st = 999;

	private int buffId_T1 = 11496111;

	private int buffId_T2 = 11496211;

	private int buffId_T3 = 11496311;

	private int once_T4 = 11496411;

	private int once_T5 = 11496511;

	public PlayerSkillCd skillMgr;

	private List<LogicEntity> entities = new List<LogicEntity>();

	public int eventHashCode_EnterBerserk = CommonHelper.StringToHash("EnterBerserk");

	private FP _reduceTimingBuffInterval;

	private CoroutineNode _berserkCor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawn);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		entities.Clear();
		if (GetPerk(perkId_mt))
		{
			_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, 99999, 1);
			_actor.ammoInfo.ammoCount = _actor.ammoInfo.ammoCountMax;
		}
		PlayerAdventureActor playerAdventureActor = _actor as PlayerAdventureActor;
		if (playerAdventureActor != null && playerAdventureActor.status == ActorStatus.Special && playerAdventureActor.specialStatusTime > 0)
		{
			EnterBerserk(playerAdventureActor.specialStatusTime.AsInt());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawn);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StopCoroutine(ref _berserkCor);
		entities.Clear();
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPerfectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
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

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (_actor != null)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && monsterAdventureActor != null)
		{
			OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
		}
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnFinishReload(IEvent evt)
	{
		AdventureActorFinishReload adventureActorFinishReload = evt as AdventureActorFinishReload;
		if (_actor != null && adventureActorFinishReload.sender as AdventureActor == _actor)
		{
			OnFinishReload(adventureActorFinishReload);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveCritDamageEvent.from as PlayerAdventureActor;
		if (_actor != null && playerAdventureActor != null)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnCrit(adventureActorReceiveCritDamageEvent, _actor.Id == adventureActorReceiveCritDamageEvent.from.Id, playerAdventureActor, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamageBeDeath(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageCanCauseDeadEvent.to as MonsterAdventureActor;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageCanCauseDeadEvent.from.Id && monsterAdventureActor != null)
		{
			OnMonsterKilled(adventureActorReceiveDamageCanCauseDeadEvent, monsterAdventureActor);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		_ = evt is AdventureElementMarkTriggerEvent;
	}

	private void OnGetBuff(IEvent evt)
	{
		if (CheckTalentLevel(1) && evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.from is PlayerAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Fire))
		{
			_actor.buffComponent.AddBuff(buffId_T1, _actor);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	public virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (CheckTalentLevel(3) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(buffId_T3, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerk(511442) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			AdventureActor.AddFromAttr(11442001, _actor);
		}
		if (GetPerk(511443) && monster.buffComponent.CheckBuffByBuffID(buffMark))
		{
			AdventureActor.AddFromAttr(once_43, _actor);
		}
		if (CheckTalentLevel(4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && _actor.buffComponent.CheckBuffByBuffID(Config.buffStrong))
		{
			AdventureActor.AddFromAttr(once_T4, _actor);
		}
		if (CheckTalentLevel(5) && monster.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(once_T5, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerk(perkId_mt) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal))
		{
			TestTriggerMask(monster);
		}
		if (GetPerk(perkId_st) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			TestTriggerMask(monster);
		}
		if (GetPerk(511441) && monster.buffComponent.CheckBuffByBuffID(buffMark) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && !CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra_P41))
		{
			ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_41, hittedFx_41);
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_TriggerFire) && TriggerMask(CommonDefine.Fire, monster))
		{
			OnTriggerMask(evt);
		}
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	private void TestTriggerMask(MonsterAdventureActor monster)
	{
		TriggerMask(CommonDefine.Fire, monster);
		TriggerMask(CommonDefine.Water, monster);
		TriggerMask(CommonDefine.Light, monster);
		TriggerMask(CommonDefine.Wind, monster);
		TriggerMask(CommonDefine.Dark, monster);
		TriggerMask(CommonDefine.Earth, monster);
	}

	private bool TriggerMask(int mask, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(mask, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.FireMark1);
			CommonUtils.TriggerElementMarkEvent(mask, HotfixEnum.AdventureActorElementTriggerType.None, _actor, monster, "FireMark_Trigger_Effect_02");
			ILRuntimeAPI.PlayAreaEffect(_actor, fireAreaEffect, monster.tsTransform.Position);
			return true;
		}
		return false;
	}

	public virtual void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent _evt)
	{
	}

	public virtual void OnFinishReload(AdventureActorFinishReload evt)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt, bool isSelf, PlayerAdventureActor actor, MonsterAdventureActor monster)
	{
		if (isSelf && CheckTalentLevel(2))
		{
			_actor.buffComponent.AddBuff(buffId_T2, _actor);
		}
	}

	public virtual void OnMonsterKilled(AdventureActorReceiveDamageCanCauseDeadEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == eventHashCode_EnterBerserk)
		{
			EnterBerserk(GetPerk(511442) ? Config.addTimingBuffCount_EnterBerserk_42 : Config.addTimingBuffCount_EnterBerserk);
		}
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	private void OnPlayerSpawn(IEvent evt)
	{
		if (evt is AdventurePlayeSpawnCompleteEvent && _actor is PlayerAdventureActor { isAssist: not false, status: ActorStatus.Special } playerAdventureActor && playerAdventureActor.specialStatusTime > 0)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
		}
	}

	protected void EnterBerserk(int timingBuffCount)
	{
		int buffID = (GetPerk(511442) ? Config.buffId_BerserkTiming_42 : Config.buffId_BerserkTiming);
		for (int i = 0; i < timingBuffCount; i++)
		{
			_actor.buffComponent?.AddBuff(buffID, _actor);
		}
		_reduceTimingBuffInterval = Config.interval_ReduceTimingBuffCount;
		StartCoroutine(ref _berserkCor, BerserkState());
	}

	private IEnumerator BerserkState()
	{
		int timingBuffId = (GetPerk(511442) ? Config.buffId_BerserkTiming_42 : Config.buffId_BerserkTiming);
		((PlayerAdventureActor)_actor).status = ActorStatus.Special;
		((PlayerAdventureActor)_actor).specialStatusTime = _actor.buffComponent.GetBuffNumByID(timingBuffId);
		_actor.buffComponent.AddBuff(Config.buffStrong, _actor);
		if (GetPerk(perkId_12))
		{
			_actor.buffComponent.AddBuff(buff_12_atkspk, _actor);
		}
		while (((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			if (_reduceTimingBuffInterval > 0)
			{
				_reduceTimingBuffInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent?.RemoveBuffByBuffId(timingBuffId, 1);
				((PlayerAdventureActor)_actor).specialStatusTime = _actor.buffComponent.GetBuffNumByID(timingBuffId);
				_reduceTimingBuffInterval = Config.interval_ReduceTimingBuffCount;
			}
			yield return null;
		}
		_actor.buffComponent?.RemoveBuffByBuffId(Config.buffStrong);
		if (GetPerk(perkId_12))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_12_atkspk);
		}
		((PlayerAdventureActor)_actor).status = ActorStatus.Default;
		((PlayerAdventureActor)_actor).specialStatusTime = 0;
	}
}
