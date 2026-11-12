using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14701;

public class ParallelScript : ParallelBase
{
	public int hitTag_NA = CommonHelper.StringToHash("147NrmAtk");

	public int hitTag_NA_Final = CommonHelper.StringToHash("147NrmAtkP1");

	public int hitTag_MS = CommonHelper.StringToHash("147SkillMainAtk");

	public int hitTag_SS1 = CommonHelper.StringToHash("147SkillSupHengSao");

	public int hitTag_SS2 = CommonHelper.StringToHash("147SkillSupYinBo");

	public int hitTag_Ultra = CommonHelper.StringToHash("147UltraAtk");

	public int hitTag_Dark = CommonHelper.StringToHash("147DarkTagTrigger");

	public int buffId_Dark = 14790000;

	public string hitEffect_Dark = "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo";

	public int hitDmgId_Dark = 147100000;

	private const string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_03";

	private const int perkId_1 = 514701;

	private const int perkId_41 = 514741;

	private int once_41 = 14741001;

	private const int perkId_42 = 514742;

	private int buff_42 = 14742011;

	private const int perkId_43 = 514743;

	private int buff_43 = 14743011;

	private int buffId_F1 = 14796111;

	private int buffId_F2 = 14796211;

	private int buffId_F3 = 14796311;

	private int buffId_F4 = 14796411;

	private int buffId_F5 = 14796511;

	public PlayerSkillCd skillMgr;

	public FP fateCD;

	private List<PlayFX> playFxList = new List<PlayFX>();

	private List<FP> castTimeList_t2 = new List<FP>();

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		fateCD = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		foreach (PlayFX playFx in playFxList)
		{
			playFx.Stop();
		}
		playFxList.Clear();
		castTimeList_t2.Clear();
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
		AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
		if (adventureActor != null)
		{
			OnCastSkill(adventureActorCastSkillEvent, adventureActor.Id == _actor.Id);
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

	private void OnReceiveDamageBeforeSettlement(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageBeforeSettlementEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveDamageBeforeSettlementEvent, monsterAdventureActor);
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

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt, bool isSelf)
	{
		if (isSelf && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && GetPerkLv(514742, out var _))
		{
			_actor.buffComponent.AddBuff(buff_42, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (CheckTalentLevel(5))
			{
				_actor.buffComponent.AddBuff(buffId_F5, _actor);
			}
		}
		else if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buffId_F2, _actor);
			}
			if (CheckTalentLevel(3))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_F3);
			}
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf && GetPerkLv(514741, out var _) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && monster.buffComponent.CheckBuffByBuffID(buffId_Dark))
		{
			AdventureActor.AddFromAttr(once_41, _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Dark))
		{
			TriggerMask(evt, monster);
		}
		if (isSelf)
		{
			if (GetPerkLv(514701, out var lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA_Final))
			{
				TriggerMask(evt, monster);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(514743, out lv))
			{
				_actor.buffComponent.AddBuff(buff_43, _actor);
			}
			if (CheckTalentLevel(3) && evt.isKill)
			{
				_actor.buffComponent.AddBuff(buffId_F3, _actor);
			}
			if (CheckTalentLevel(4) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA_Final)))
			{
				_actor.buffComponent.AddBuff(buffId_F4, _actor);
			}
		}
	}

	private bool TriggerMask(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.DarkMark1, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.DarkMark1);
			monster.buffComponent.AddBuff(buffId_Dark, _actor);
			ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dark, hitEffect_Dark);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.DarkMark1, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1, _actor, monster, "DarkMark_Trigger_Effect_03");
			OnTriggerMask(evt);
			return true;
		}
		return false;
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
		_ = ILRuntimeAPI.GetAreaEffect(evt.entityID) != null;
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

	public virtual void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		if (CheckTalentLevel(1))
		{
			_actor.buffComponent.AddBuff(buffId_F1, _actor);
		}
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
