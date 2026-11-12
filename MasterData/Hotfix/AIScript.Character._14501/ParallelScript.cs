using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class ParallelScript : ParallelBase
{
	public int hitTag_NA = CommonHelper.StringToHash("145NrmAtk");

	public int hitTag_MS = CommonHelper.StringToHash("145SkillMainAtk");

	public int hitTag_MS_Shoot = CommonHelper.StringToHash("145SkillMainShot");

	public int hitTag_SS_All = CommonHelper.StringToHash("145SkillSupAllAtk");

	public int hitTag_SS = CommonHelper.StringToHash("145SkillSupRain");

	public int hitTag_SD = CommonHelper.StringToHash("145SkillSupDot");

	public int hitTag_Ultra = CommonHelper.StringToHash("145UltraAtk");

	public int hitTag_Mark = CommonHelper.StringToHash("145AddDarkMark1");

	public int buffId_Mark = 5011;

	public int buffId_Dark = 5031;

	public int buffId_Dark2 = 5041;

	public int buffTag_Dark = CommonHelper.StringToHash("DarkAnSuo");

	private int hitDmgId_Dark = 145000001;

	private int hitTag_Dark = CommonHelper.StringToHash("145DarkTagTrigger");

	private string hitEffect_Dark = "FX/ActorCommon/fx_common_base_DarkTrigger_AnSuo";

	private string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_05";

	public Dictionary<int, string> dicAreaEffectAim = new Dictionary<int, string>
	{
		[0] = "AreaEffect_145_AidSniper_1",
		[1] = "AreaEffect_145_AidSniper_2",
		[2] = "AreaEffect_145_AidSniper_3",
		[3] = "AreaEffect_145_AidSniper_4"
	};

	public Dictionary<int, int> dicAreaEffectHitId = new Dictionary<int, int>
	{
		[0] = 145300002,
		[1] = 145300002,
		[2] = 145300002,
		[3] = 145300002
	};

	private string areaEffect_Boom = "AreaEffect_145_Ultra_HuaSanBoom";

	private FP delayTime = 0.6f;

	private string areaEffect_Boom1 = "AreaEffect_145_Ultra_RingBoom";

	private int castAreaEffect = CommonHelper.StringToHash("castAreaEffect");

	private const int perkId_42 = 514542;

	private int once_42 = 14542001;

	private const int perkId_43 = 514543;

	private int buffId_43 = 14543011;

	public const int buffId_D1 = 14596111;

	public const int buffId_D2 = 14596211;

	public const int buffId_D3 = 14596311;

	public const int buffId_D4 = 14596411;

	public const int additionalAttrId_D5 = 14596511;

	public PlayerSkillCd skillMgr;

	private CoroutineNode corDelay;

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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StopCoroutine(ref corDelay);
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
			OnCastSkill(adventureActorCastSkillEvent, _actor.dataID == playerAdventureActor.dataID);
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

	private void OnShieldChange(IEvent evt)
	{
		AdventureActorRemoveShield evt2 = evt as AdventureActorRemoveShield;
		if (_actor != null)
		{
			OnShieldChange(evt2);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.DE } && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(14596411, _actor);
		}
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt, bool isSelf)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
			{
				_actor.buffComponent.AddBuff(14596211, _actor);
			}
			if (GetPerk(514543))
			{
				_actor.buffComponent.AddBuff(buffId_43, _actor);
			}
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
		if (isSelf)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && monster.IsEliteOrBossMonster())
			{
				AdventureActor.AddFromAttr(14596511, _actor);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerk(514542) && monster.buffComponent.CheckBuffByBuffTag(buffTag_Dark))
			{
				AdventureActor.AddFromAttr(once_42, _actor);
			}
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && evt.damageType == HotfixEnum.damageType.SKILL)
			{
				monster.buffComponent.AddBuff(14596111, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && evt.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.DE)
					{
						continue;
					}
					actorL.buffComponent.AddBuff(14596311, _actor);
					foreach (AdventureActor selfMinion in ILRuntimeAPI.GetSelfMinions(actorL))
					{
						selfMinion.buffComponent.AddBuff(14596311, _actor);
					}
				}
			}
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Dark))
		{
			TriggerMask(evt, monster);
		}
	}

	public bool TriggerMask(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Dark, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.Dark);
			monster.buffComponent.AddBuff(buffId_Dark, _actor);
			monster.buffComponent.AddBuff(buffId_Dark2, _actor);
			ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dark, hitEffect_Dark);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Dark, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType2, _actor, monster, tipsKey_TriggerMark);
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
	}

	public virtual void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
	}

	public virtual void OnBattleReady(AdventureBattleReadyEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == castAreaEffect)
		{
			TSVector2 pos = evt.tsVector2ParamList.get_Item(0);
			StartCoroutine(ref corDelay, DelayCast(pos));
		}
	}

	public virtual void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnShieldChange(AdventureActorRemoveShield evt)
	{
	}

	private IEnumerator DelayCast(TSVector2 pos)
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Boom, pos);
		yield return _actor.WaitTime(delayTime);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Boom1, pos);
	}
}
