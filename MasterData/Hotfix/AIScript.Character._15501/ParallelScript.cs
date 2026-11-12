using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Character._15501;

public class ParallelScript : ParallelBase
{
	public int hitTag_LB = CommonHelper.StringToHash("155_Black_Attack");

	public int hitTag_LW = CommonHelper.StringToHash("155_White_Attack");

	public int hitTag_Boom_1 = CommonHelper.StringToHash("155_P01_Boom");

	public int hitTag_Boom_2 = CommonHelper.StringToHash("155_P02_Boom");

	public int hitTag_LB_Berize_P3 = CommonHelper.StringToHash("155_P03_Missile");

	public int hitTag_BB = CommonHelper.StringToHash("155_Black_Main_Skill_Shoot");

	public int hitTag_BW = CommonHelper.StringToHash("155_White_Main_Skill_Shoot");

	public int hitTag_BB_Berize_P4 = CommonHelper.StringToHash("155_P04_Missile");

	public int hitTag_MB = CommonHelper.StringToHash("155_Black_Support_Skill_Shoot");

	public int hitTag_MW = CommonHelper.StringToHash("155_White_Support_Skill_Shoot");

	public int hitTag_MS = CommonHelper.StringToHash("155_XiYa_Support_Surf");

	public int hitTag_SS = CommonHelper.StringToHash("155_XiYa_Support_Surf");

	public int hitTag_SS_P25 = CommonHelper.StringToHash("155_P25");

	public int hitTag_Ultra = CommonHelper.StringToHash("155_Ultra");

	public string runEffect = "fx_15501_Loop_run02";

	public string runEffect1 = "fx_15501_Loop_run";

	public AnimationSlotConfigComponent.SlotType slotType = AnimationSlotConfigComponent.SlotType.Extra_1;

	public int hitTag_Mask = CommonHelper.StringToHash("155_LightMark_Hurt");

	public string tipsKey_TriggerMark = "LightMark_Trigger_Effect_02";

	public string areaEffect_Mask = "AreaEffect_15501_LightTag_Boom";

	private const int perkId_41 = 515541;

	private const int buff_41 = 15541011;

	private const int perkId_42 = 515542;

	private const int once_42 = 15542001;

	private int buff_42 = 15542011;

	private const int perkId_43 = 515543;

	private const int once_43 = 15543001;

	private int buffId_F1 = 15596111;

	private int once_F2 = 15596211;

	private int buffId_F3 = 15596311;

	private int buffId_F4 = 15596411;

	private int buffId_F5 = 15596511;

	public PlayerSkillCd skillMgr;

	public PlayerAdventureActor mainCtrActor;

	public List<PlayFX> playFxList = new List<PlayFX>();

	public PlayFX playFX_Run = new PlayFX();

	public PlayFX playFX_Run1 = new PlayFX();

	public float defaultScale;

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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ANIMATORSTATE_ENTER", OnAnimatorStateEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ANIMATORSTATE_EXIT", OnAnimatorStateExit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		Transform slotNode = _actor.slotConfig.GetSlotNode(slotType);
		defaultScale = slotNode.lossyScale.x;
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ANIMATORSTATE_ENTER", OnAnimatorStateEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ANIMATORSTATE_EXIT", OnAnimatorStateExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		foreach (PlayFX playFx in playFxList)
		{
			playFx.Stop();
		}
		playFxList.Clear();
		playFX_Run.Stop();
		playFX_Run1.Stop();
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
		if (_actor != null && adventureActorCastSkillEvent.sender is AdventureActor adventureActor && _actor.Id == adventureActor.Id)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender is AdventureActor adventureActor && _actor.Id == adventureActor.Id)
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

	private void OnAnimatorStateEnter(IEvent evt)
	{
		if (evt is AdventureActorAnimatorStateEnterEvent evt2)
		{
			OnAnimatorStateEnter(evt2);
		}
	}

	private void OnAnimatorStateExit(IEvent evt)
	{
		if (evt is AdventureActorAnimatorStateExitEvent evt2)
		{
			OnAnimatorStateExit(evt2);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent evt2 = evt as AdventureElementMarkTriggerEvent;
		OnElementMarkTrigger(evt2);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff evt2)
		{
			OnGetBuff(evt2);
		}
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.D || !GetPerk(515542))
		{
			return;
		}
		bool flag = true;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.Id != _actor.Id)
			{
				int currentBindSkillId = playerAdventureActor.playerSkillCd.GetCurrentBindSkillId(ActionKey.D);
				if (playerAdventureActor.playerSkillCd.CanUseCD(currentBindSkillId))
				{
					flag = false;
					break;
				}
			}
		}
		if (flag)
		{
			_actor.buffComponent.AddBuff(buff_42, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (CheckTalentLevel(4) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_F4);
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			if (GetPerk(515542) && _actor.buffComponent.CheckBuffByBuffID(buff_42))
			{
				AdventureActor.AddFromAttr(15542001, _actor);
			}
			if (GetPerk(515543))
			{
				AdventureActor.AddFromAttr(15543001, _actor);
			}
		}
		if (CheckTalentLevel(2) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(once_F2, _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf)
		{
			if (CheckTalentLevel(1) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
			{
				_actor.buffComponent.AddBuff(buffId_F1, _actor);
			}
			if (CheckTalentLevel(4) && evt.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				_actor.buffComponent.AddBuff(buffId_F4, _actor);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Mask) && TriggerMask(monster, evt.hitDamageTag))
			{
				OnTriggerMasked(evt.from as AdventureActor);
			}
		}
	}

	public virtual void OnTriggerMasked(AdventureActor actor)
	{
		if (CheckTalentLevel(3))
		{
			_actor.buffComponent.AddBuff(buffId_F3, _actor);
		}
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerk(515541))
		{
			_actor.buffComponent.AddBuff(15541011, _actor);
		}
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

	public virtual void OnAnimatorStateEnter(AdventureActorAnimatorStateEnterEvent evt)
	{
	}

	public virtual void OnAnimatorStateExit(AdventureActorAnimatorStateExitEvent evt)
	{
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	public virtual void OnGetBuff(AdventureActorGetBuff evt)
	{
		if (CheckTalentLevel(5) && evt.from is PlayerAdventureActor && evt.eventInfo.buffTags.Contains(CommonDefine.Light))
		{
			_actor.buffComponent.AddBuff(buffId_F5, _actor);
		}
	}

	private bool TriggerMask(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Light, monster) && CommonUtils.CheckHitByTag(hitDamageTag, hitTag_Mask) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.Light);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Mask, monster.tsTransform.Position);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Light, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1, _actor, monster, tipsKey_TriggerMark);
			return true;
		}
		return false;
	}
}
