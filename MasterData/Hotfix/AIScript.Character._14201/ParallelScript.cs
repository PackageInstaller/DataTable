using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14201;

public class ParallelScript : ParallelBase
{
	public int hitTag_Normal = CommonHelper.StringToHash("142NrmAtk");

	public int hitTag_MainSkill = CommonHelper.StringToHash("142SkillMainAtk");

	public int hitTag_MainSkill_2 = CommonHelper.StringToHash("ShengLongAtk2");

	public int hitTag_SupportSkill = CommonHelper.StringToHash("142SkillSupAtk");

	public int hitTag_Ultra = CommonHelper.StringToHash("142UltraAtk");

	public int hitTag_AddDark = CommonHelper.StringToHash("142AddDarkMark1");

	public string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_03";

	public int buff_Dark = 5011;

	private int ultraEvent = CommonHelper.StringToHash("UltraAreaEffect");

	private const int perkId_41 = 514241;

	private int once_41 = 14241001;

	private int paramId_41_range = 14241011;

	private const int perkId_42 = 514242;

	private int buff_42 = 14242011;

	private const int perkId_43 = 514243;

	private int buff_43 = 14243011;

	private int buffId_F1 = 14296111;

	private int buffId_F2 = 14296211;

	private int buffId_F3 = 14296311;

	private int buffId_F4 = 14296411;

	private int prob_F4 = 25;

	private int buffId_F5 = 14296511;

	public PlayerSkillCd skillMgr;

	private PlayFX playFX = new PlayFX();

	private long areaId;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnAddBuff);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		if (!CheckTalentLevel(5))
		{
			return;
		}
		bool flag = true;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType != HotfixEnum.elementType.DE)
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnAddBuff);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		playFX.Stop();
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

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageBeforeHitEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (_actor != null && playerAdventureActor != null && monsterAdventureActor != null)
		{
			OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor, _actor.Id == playerAdventureActor.Id);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null)
		{
			PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageEvent.from as PlayerAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor, playerAdventureActor != null && playerAdventureActor.Id == _actor.Id);
			}
			playerAdventureActor = adventureActorReceiveDamageEvent.to as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				OnHurt(adventureActorReceiveDamageEvent, playerAdventureActor.Id == _actor.Id);
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

	private void OnAreaEffectEnd(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectEnd(adventureAreaEffectFinishEvent);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnCrit(adventureActorReceiveCritDamageEvent, monsterAdventureActor);
			}
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

	private void OnAddBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff evt2)
		{
			OnAddBuff(evt2);
		}
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (CheckTalentLevel(1))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F1, _actor);
			}
		}
		else if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && CheckTalentLevel(2))
		{
			mainCtrActor.buffComponent.AddBuff(buffId_F2, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(514241, out var _))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_41_range);
			if (TSVector2.Distance(_actor.tsTransform.Position, monster.tsTransform.Position) < scriptValue)
			{
				AdventureActor.AddFromAttr(once_41, _actor);
			}
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (!isSelf)
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			if (GetPerkLv(514242, out var lv))
			{
				monster.buffComponent.AddBuff(buff_42, _actor);
			}
			if (GetPerkLv(514243, out lv))
			{
				monster.buffComponent.AddBuff(buff_43, _actor);
			}
		}
		if (CheckTalentLevel(4) && TSRandom.Range(0, 100) < prob_F4)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt, bool isSelf)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt, MonsterAdventureActor mosnter)
	{
	}

	public virtual void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
	}

	public virtual void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
	}

	public virtual void OnShieldChange(AdventureActorRemoveShield evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	public virtual void OnAddBuff(AdventureActorGetBuff evt)
	{
		if (CheckTalentLevel(3) && evt.eventInfo.buffId == buff_Dark && evt.from is PlayerAdventureActor)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F3, _actor);
		}
	}

	public void ClearCd(int perkId)
	{
		perkCd.Remove(perkId);
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
