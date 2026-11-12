using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._12701;

public class ParallelScript : ParallelBase
{
	public int hitTag_Normal = CommonHelper.StringToHash("127_NormalAtk");

	public int hitTag_MainSkill = CommonHelper.StringToHash("127_B1Atk");

	public int hitTag_MainSkill_S2 = CommonHelper.StringToHash("127_B1Atk_Derive");

	public int hitTag_SupportSkill = CommonHelper.StringToHash("127_B2Atk");

	public int hitTag_Ultra = CommonHelper.StringToHash("127UltraAtk");

	public int hitTag_WaterTag1 = CommonHelper.StringToHash("WaterTag1");

	public int hitTag_Water = CommonHelper.StringToHash("127_B2Water");

	public int hitTag_Water_P24 = CommonHelper.StringToHash("127_B2Water");

	public int buffA = 4011;

	public int buffTag_Water = CommonHelper.StringToHash("WaterMark1");

	public int buffTag_Frozen = CommonHelper.StringToHash("Frozen");

	public int buffTag_Cold = CommonHelper.StringToHash("Cold");

	public int shieldTag = CommonHelper.StringToHash("127_SupportSkill");

	public int shielId = 12750002;

	private const int perkId_42 = 512742;

	private int buffId_42 = 12754211;

	private const int perkId_43 = 512743;

	private int once_43 = 12754301;

	private int once_F1 = 12796111;

	private int buffId_F2 = 12796211;

	public int buffId_F3 = 12796311;

	private int buffId_F4 = 12796411;

	private int buffId_F5 = 12796511;

	public PlayerSkillCd skillMgr;

	public PlayerAdventureActor mainCtrActor;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (!CheckTalentLevel(5))
		{
			return;
		}
		bool flag = true;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType != HotfixEnum.elementType.WE)
			{
				flag = false;
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		perkCd.Clear();
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
		if (_actor != null && adventureActorCastSkillEvent.sender is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor == _actor)
			{
				OnCastSkill(adventureActorCastSkillEvent);
			}
			else
			{
				OnAssistCastSkill(adventureActorCastSkillEvent);
			}
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

	protected void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveAttackEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
		if (_actor != null && playerAdventureActor != null && monsterAdventureActor != null)
		{
			if (_actor == playerAdventureActor)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
			else
			{
				OnAssistHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (!(_actor != null))
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageEvent.from as PlayerAdventureActor;
		if (playerAdventureActor != null && monsterAdventureActor != null)
		{
			if (playerAdventureActor.Id == _actor.Id)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
			}
			else
			{
				OnOtherHitPost(adventureActorReceiveDamageEvent, playerAdventureActor, monsterAdventureActor);
			}
		}
		playerAdventureActor = adventureActorReceiveDamageEvent.to as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			if (playerAdventureActor.Id == _actor.Id)
			{
				OnHurt(adventureActorReceiveDamageEvent);
			}
			else
			{
				OnOtherHurt(adventureActorReceiveDamageEvent, playerAdventureActor);
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
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageBeforeHitEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (playerAdventureActor != null && monsterAdventureActor != null)
		{
			if (_actor == playerAdventureActor)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
			else
			{
				OnAssistBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
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

	private void OnShieldChange(IEvent evt)
	{
		AdventureActorRemoveShield evt2 = evt as AdventureActorRemoveShield;
		if (_actor != null)
		{
			OnShieldChange(evt2);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent evt2 = evt as AdventureElementMarkTriggerEvent;
		OnElementMarkTrigger(evt2);
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && GetPerkLv(512742, out var _))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_42, _actor);
		}
	}

	public virtual void OnAssistCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnOtherHurt(AdventureActorReceiveDamageEvent evt, PlayerAdventureActor player)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(512743, out var _) && (monster.buffComponent.CheckBuffByBuffTag(buffTag_Water) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold)))
		{
			AdventureActor.AddFromAttr(once_43, _actor);
		}
		if (CheckTalentLevel(1) && (monster.buffComponent.CheckBuffByBuffTag(buffTag_Water) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold)))
		{
			AdventureActor.AddFromAttr(once_F1, _actor);
		}
	}

	public virtual void OnAssistBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (CheckTalentLevel(1) && (monster.buffComponent.CheckBuffByBuffTag(buffTag_Water) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold)))
		{
			PlayerAdventureActor playerAdventureActor = evt.from as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				AdventureActor.AddFromAttr(once_F1, playerAdventureActor);
			}
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnAssistHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_WaterTag1))
		{
			monster.buffComponent.AddBuff(buffA, _actor);
			if (CheckTalentLevel(3))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F3, _actor);
			}
		}
	}

	public virtual void OnOtherHitPost(AdventureActorReceiveDamageEvent evt, PlayerAdventureActor player, MonsterAdventureActor monster)
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

	public virtual void OnShieldAdd(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorAddShield adventureActorAddShield && CheckTalentLevel(2) && adventureActorAddShield.to == mainCtrActor && adventureActorAddShield.shieldTags.Contains(shieldTag))
		{
			mainCtrActor.buffComponent.AddBuff(buffId_F2, _actor);
		}
	}

	public virtual void OnShieldChange(AdventureActorRemoveShield evt)
	{
		if (CheckTalentLevel(2) && evt.sender as AdventureActor == mainCtrActor && evt.shieldTags.Contains(shieldTag))
		{
			mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_F2);
		}
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		if (CheckTalentLevel(4) && evt.elementType == HotfixEnum.elementType.WE)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_F4, _actor);
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
