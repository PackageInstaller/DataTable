using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class ParallelScript : ParallelBase
{
	public int hitTag_Normal = CommonHelper.StringToHash("159_NormalAtk");

	public int hitTag_MS = CommonHelper.StringToHash("159_Ray");

	public int hitTag_Ultra = CommonHelper.StringToHash("159_Ultra");

	public int hitTag_Ultra_Charm = CommonHelper.StringToHash("159_Ultra_Charm");

	public int hitTag_Common = CommonHelper.StringToHash("159_Common");

	public int hitTag_Mask = CommonHelper.StringToHash("159_LandTrigger");

	public string tipsKey_TriggerMark = "LandMark_Trigger_Effect_02";

	public string areaEffect_Mask = "AreaEffect_15901_LandTag1_Stone";

	private const int perkId_41 = 515941;

	private int buff_41 = 15941011;

	private int once_41 = 15941001;

	private FP delayTime_41 = 0;

	private int hitDmg_41_1 = 159400003;

	private string hurtFx_41 = "fx_buff_Charm_hit";

	private const int perkId_42 = 515942;

	private int once_42 = 15942001;

	private const int perkId_43 = 515943;

	private int buff_43 = 15943011;

	private int once_43 = 15943001;

	private int buffId_F1 = 15996111;

	private int buffId_F2 = 15996211;

	private int once_F2 = 15996211;

	private int buffId_F3 = 15996311;

	private int buffId_F4 = 15996411;

	private int once_F5 = 15996511;

	public PlayerSkillCd skillMgr;

	public List<PlayFX> playFxList = new List<PlayFX>();

	private CoroutineNode corDelayHit;

	public List<CoroutineNode> corList = new List<CoroutineNode>();

	public PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		foreach (PlayFX playFx in playFxList)
		{
			playFx.Stop();
		}
		playFxList.Clear();
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
		StopCoroutine(ref corDelayHit);
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPrefectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender is AdventureActor adventureActor && adventureActor == _actor)
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
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor, _actor.Id == adventureActorReceiveAttackEvent.from.Id);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null)
		{
			if (monsterAdventureActor != null)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor, _actor.Id == adventureActorReceiveDamageEvent.from.Id);
			}
			if (_actor.Id == adventureActorReceiveDamageEvent.to.Id)
			{
				OnHurt(adventureActorReceiveDamageEvent);
			}
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

	private void OnAreaEffectBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (_actor != null && adventureAreaEffectBeginEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectBegin(adventureAreaEffectBeginEvent);
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectFinish(adventureAreaEffectFinishEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor, adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id);
			}
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
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

	private void OnSummonSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent evt2)
		{
			OnSummonSpawned(evt2);
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent evt2)
		{
			OnMonsterDied(evt2);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner != null && adventureBulletFinishEvent.owner.Id == _actor.Id)
		{
			OnBulletFinish(adventureBulletFinishEvent);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff evt2)
		{
			OnGetBuff(evt2);
		}
	}

	private void OnBuffRemove(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff evt2)
		{
			OnBuffRemove(evt2);
		}
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (CheckTalentLevel(4) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf && GetPerk(515941) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && monster.monsterInfo.epicType != HotfixEnum.monsterEpicType.NORMAL)
		{
			AdventureActor.AddFromAttr(once_41, _actor);
		}
		if (GetPerk(515942))
		{
			int currentBindSkillId = skillMgr.GetCurrentBindSkillId(ActionKey.D);
			if ((skillMgr.CheckCD(currentBindSkillId) || (FP)skillMgr.GetEnergyPercent() < 100) && evt.from is AdventureActor adventureActor && adventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && (adventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard || adventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance))
			{
				AdventureActor.AddFromAttr(once_42, adventureActor);
			}
		}
		if (isSelf && GetPerk(515943) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Common))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_43);
			AdventureActor.AddFromAttr(once_43, _actor, buffNumByID);
		}
		if (CheckTalentLevel(2) && _actor.buffComponent.CheckBuffByBuffID(buffId_F2))
		{
			AdventureActor.AddFromAttr(once_F2, _actor);
		}
		if (CheckTalentLevel(5) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(once_F5, _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf)
		{
			if (CheckTalentLevel(1) && evt.damageType == HotfixEnum.damageType.SKILL)
			{
				monster.buffComponent.AddBuff(buffId_F1, _actor);
			}
			if (CheckTalentLevel(3) && evt.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				monster.buffComponent.AddBuff(buffId_F3, _actor);
			}
			if (GetPerk(515941) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra_Charm) && monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL)
			{
				monster.buffComponent.AddBuff(buff_41, _actor);
			}
			if (GetPerk(515943) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
			{
				_actor.buffComponent.AddBuff(buff_43, _actor);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Mask))
			{
				TriggerMask(evt.from as AdventureActor, monster);
			}
		}
	}

	public void TriggerMask(AdventureActor from, MonsterAdventureActor monster)
	{
		if (TriggerMaskInneral(monster))
		{
			OnTriggerMasked(from);
		}
	}

	private bool TriggerMaskInneral(MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Earth, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.Earth);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Mask, monster.tsTransform.Position);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Earth, HotfixEnum.AdventureActorElementTriggerType.EarthElementTriggerType, _actor, monster, tipsKey_TriggerMark);
			return true;
		}
		return false;
	}

	public virtual void OnTriggerMasked(AdventureActor actor)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
	}

	public virtual void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
	}

	public virtual void OnBattleReady(AdventureBattleReadyEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnSummonSpawned(AdventureMonsterSummonerSpawnedEvent evt)
	{
	}

	public virtual void OnMonsterDied(AdventureMonsterDiedEvent evt)
	{
	}

	public virtual void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
	}

	public virtual void OnGetBuff(AdventureActorGetBuff evt)
	{
		if (CheckTalentLevel(2) && evt.from is PlayerAdventureActor && evt.eventInfo.buffTags.Contains(CommonDefine.Earth))
		{
			_actor.buffComponent.AddBuff(buffId_F2, _actor);
		}
	}

	private void OnBuffRemove(AdventureActorRemoveBuff evt)
	{
		if (GetPerk(515941) && evt.eventInfo.buffId == buff_41 && evt.sender is MonsterAdventureActor monster && evt.froms.Contains(_actor))
		{
			CoroutineNode item = StartCoroutine(DoDelayHit(monster));
			corList.Add(item);
		}
	}

	private IEnumerator DoDelayHit(MonsterAdventureActor monster)
	{
		yield return _actor.WaitTime(delayTime_41);
		if (monster != null)
		{
			ILRuntimeAPI.HitActor(_actor, monster, hitDmg_41_1, hurtFx_41);
		}
	}
}
