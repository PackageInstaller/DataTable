using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class Parallel : ParallelBase
{
	public int fireHit = CommonHelper.StringToHash("103_FireTag1_Boom");

	public int hitTag_Normal = CommonHelper.StringToHash("Normal");

	public int hitTag_Skill = CommonHelper.StringToHash("Skill");

	public int hitTag_Skill_P3 = CommonHelper.StringToHash("103_P3");

	public int hitTag_Skill_P9 = CommonHelper.StringToHash("103_P9");

	public int hitTag_Skill_P25 = CommonHelper.StringToHash("103_P25");

	public int hitTag_Ultra = CommonHelper.StringToHash("Ultra");

	public int hitTag_Trigger = CommonHelper.StringToHash("FireTag1_Trigger");

	private string areaEffectKey = "fx_common_buff_typel_fire_stamp_burst_6m";

	private int hitDmgId = 103000001;

	private FP innerRadius = 0;

	private FP outerRadius = 6;

	private FP stiffDuration = 1;

	private FP hitStrenth = 1;

	public string areaEffectKey_1 = "fx_10301_buff_typel_fire_stamp_burst_H6";

	private int hitDmgId_1 = 103009061;

	private FP innerRadius_1 = 0;

	private FP outerRadius_1 = 8;

	private FP stiffDuration_1 = 1;

	private FP hitStrenth_1 = 1;

	private const string tipsKey_TriggerMark = "FireMark_Trigger_Effect_01";

	private const int perkId_1 = 510341;

	private const int buff_1 = 10354101;

	private const int perkId_2 = 510342;

	private int cdPercent_2 = 50;

	private int buffId_2 = 10354201;

	private int paramId_2_time = 10354201;

	private const int perkId_3 = 510343;

	private int buffId_3 = 10354311;

	private int paramId_3_energy = 10354301;

	private int once_3 = 10354301;

	private int buffId_F1 = 10396111;

	private int buffId_F2 = 10396211;

	private int buffId_F3 = 10396311;

	private int buffId_F4 = 10396411;

	private int once_F5 = 10396511;

	public PlayerSkillCd skillMgr;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	private FP curTime_2;

	private CommomAreaHitConfig hitCfg = new CommomAreaHitConfig();

	private HitBox.HitBoxFeatureData featureData = new HitBox.HitBoxFeatureData();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		perkCd.Clear();
		curTime_2 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		perkCd.Clear();
	}

	private void OnPrefectDodge(IEvent evt)
	{
		if (evt is AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger && adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPerfectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && _actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent && _actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageBeforeHitEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (adventureActorReceiveDamageBeforeHitEvent != null && playerAdventureActor != null && monsterAdventureActor != null)
		{
			if (_actor == playerAdventureActor)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
			OnGroupBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent && _actor != null && _actor.Id == adventureActorReceiveAttackEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (adventureActorReceiveDamageEvent != null && _actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && monsterAdventureActor != null)
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
		if (evt is AdventureActorFinishReload adventureActorFinishReload && _actor != null && adventureActorFinishReload.sender as AdventureActor == _actor)
		{
			OnFinishReload(adventureActorFinishReload);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		if (evt is AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent && _actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnReceiveDamageBeDeath(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageCanCauseDeadEvent.to as MonsterAdventureActor;
		if (adventureActorReceiveDamageCanCauseDeadEvent != null && _actor != null && _actor.Id == adventureActorReceiveDamageCanCauseDeadEvent.from.Id && monsterAdventureActor != null)
		{
			OnMonsterKilled(adventureActorReceiveDamageCanCauseDeadEvent, monsterAdventureActor);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	public virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (CheckTalentLevel(3) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(buffId_F3, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		int lv;
		switch (evt.skillEventInfo.skillSlotType)
		{
		case HotfixEnum.skillSlotType.D:
			if (GetPerkLv(510341, out lv))
			{
				_actor.buffComponent.AddBuff(10354101, _actor);
			}
			if (GetPerkLv(510342, out lv))
			{
				curTime_2 = _actor.LogicTime;
				_actor.buffComponent.AddBuff(buffId_2, _actor);
			}
			break;
		case HotfixEnum.skillSlotType.B:
			if (GetPerkLv(510342, out lv) && _actor.LogicTime - curTime_2 < CommonUtils.GetScriptValue(_actor, paramId_2_time) && curTime_2 > 0)
			{
				skillMgr.ModifyResumeTimePercent(cdPercent_2, ActionKey.B);
			}
			break;
		}
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerkLv(510343, out var _) && monster.buffComponent.CheckBuffByBuffID(buffId_3))
		{
			AdventureActor.AddFromAttr(once_3, _actor);
		}
		if (CheckTalentLevel(5) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(once_F5, _actor);
		}
	}

	public virtual void OnGroupBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(510343, out var _) && monster.actorHealthInfo.isAlive)
		{
			monster.buffComponent.AddBuff(buffId_3, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CheckTalentLevel(1))
		{
			_actor.buffComponent.AddBuff(buffId_F1, _actor);
		}
		if (CheckTalentLevel(4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent _evt)
	{
	}

	public virtual void OnFinishReload(AdventureActorFinishReload evt)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnMonsterKilled(AdventureActorReceiveDamageCanCauseDeadEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerkLv(510343, out var _) && monster.buffComponent.CheckBuffByBuffID(buffId_3))
		{
			skillMgr.AddEnergy(CommonUtils.GetScriptValue(_actor, paramId_3_energy));
		}
	}

	public void TriggerFireMark(MonsterAdventureActor monster, HotfixEnum.skillSlotType skillSlotType)
	{
		if (CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			string fxAlias = areaEffectKey;
			monster.buffComponent.RemoveBuffByTag(CommonDefine.FireMark1);
			hitCfg.hitDamageId = hitDmgId;
			hitCfg.position = monster.tsTransform.Position;
			hitCfg.direction = _actor.tsTransform.Forward;
			hitCfg.fxAlias = fxAlias;
			hitCfg.hitFlags = HitBox.FeatureFlag.Stiff;
			hitCfg.hitFeatureData = featureData;
			hitCfg.hitFeatureData.StiffDuration = stiffDuration;
			hitCfg.hitFeatureData.hitStrenth = hitStrenth;
			ILRuntimeAPI.CircleAreaHit(_actor, hitCfg, outerRadius, innerRadius);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.FireMark1, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType1, _actor, monster, "FireMark_Trigger_Effect_01");
			if (CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buffId_F2, _actor);
			}
		}
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
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
