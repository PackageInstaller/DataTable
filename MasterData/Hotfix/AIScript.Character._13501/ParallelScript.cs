using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13501;

public class ParallelScript : ParallelBase
{
	public int hitTag_Normal = CommonHelper.StringToHash("135NrmAtk");

	public int hitTag_MainSkill = CommonHelper.StringToHash("135MainSkillAtk");

	public int hitTag_SupportSkill = CommonHelper.StringToHash("135SupportSkillAtk");

	public int hitTag_Ultra = CommonHelper.StringToHash("135UltraAtk");

	public int hitTag_Dark = CommonHelper.StringToHash("135DarkTagBoom");

	public int buffId_Dark = 13590000;

	public string hitEffect_Dark = "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo";

	public int hitDmgId_Dark = 135000000;

	private int summonId_1 = 13500020;

	private int summonId_2 = 13500010;

	private const string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_03";

	private const int perkId_41 = 513541;

	private const int buff_41 = 13554111;

	private string effect_41 = "fx_13501_base_T41_FaZhen";

	private const int perkId_42 = 513542;

	private const int buff_42 = 13554211;

	private const int perkId_43 = 513543;

	private const int buff_43 = 13554311;

	private int buffId_F1 = 13596111;

	private int buffId_F2 = 13596211;

	private int buffId_F3 = 13596311;

	private int buffId_F4 = 13596411;

	private int buffId_F5 = 13596511;

	private int buffId_F5_Mark = 13596521;

	private int param1_F5_Cd = 13596511;

	public PlayerSkillCd skillMgr;

	public PlayerAdventureActor mainCtrActor;

	private List<PlayFX> playFxList = new List<PlayFX>();

	private int curSummonCount;

	private bool hasSummon;

	private int summonCountF5;

	private FP curTime_F5;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		curSummonCount = 0;
		hasSummon = false;
		summonCountF5 = 0;
		curTime_F5 = 0;
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
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		foreach (PlayFX playFx in playFxList)
		{
			playFx.Stop();
		}
		playFxList.Clear();
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

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (!GetPerkLv(513541, out lv))
			{
				return;
			}
			List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
			List<LogicEntity> list = new List<LogicEntity>();
			for (int i = 0; i < monsterSummonInfos.Count; i++)
			{
				if (monsterSummonInfos.get_Item(i).dataID == summonId_1 || monsterSummonInfos.get_Item(i).dataID == summonId_2)
				{
					LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
					if (logicEntity != null)
					{
						list.Add(logicEntity);
					}
				}
			}
			{
				foreach (LogicEntity item in list)
				{
					PlayFX playFX = new PlayFX();
					playFX.Play(_actor, effect_41, 1f, 0, item.tsTransform.Position, item.transform.rotation);
					playFxList.Add(playFX);
					(item as AdventureActor).DestroySelf();
					_actor.buffComponent.AddBuff(13554111, _actor);
				}
				return;
			}
		}
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerkLv(513542, out lv))
		{
			_actor.buffComponent.AddBuff(13554211, _actor);
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
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (CheckTalentLevel(4) && evt.from is MonsterAdventureActor monsterAdventureActor && (monsterAdventureActor.dataID == summonId_1 || monsterAdventureActor.dataID == summonId_2))
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
			monsterAdventureActor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (isSelf)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(513543, out var _))
			{
				_actor.buffComponent.AddBuff(13554311, _actor);
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Dark) && CommonUtils.CheckElementMark(CommonDefine.Dark, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
			{
				monster.buffComponent.RemoveBuffByTag(CommonDefine.Dark);
				monster.buffComponent.AddBuff(buffId_Dark, _actor);
				ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_Dark, hitEffect_Dark);
				CommonUtils.TriggerElementMarkEvent(CommonDefine.Dark, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1, _actor, monster, "DarkMark_Trigger_Effect_03");
			}
		}
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
		if (evt.dataId != summonId_1 && evt.dataId != summonId_2)
		{
			return;
		}
		if (CheckTalentLevel(1))
		{
			foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
			{
				(item as AdventureActor)?.buffComponent.AddBuff(buffId_F1, _actor);
			}
		}
		if (CheckTalentLevel(2))
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(evt.id);
			if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_F2, _actor);
			}
		}
		if (!CheckTalentLevel(5))
		{
			return;
		}
		if (_actor.buffComponent.CheckBuffByBuffID(buffId_F5_Mark))
		{
			LogicEntity logicEntity2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(evt.id);
			if (logicEntity2 != null && logicEntity2 is MonsterAdventureActor monsterAdventureActor2)
			{
				monsterAdventureActor2.buffComponent.AddBuff(buffId_F5, _actor);
			}
		}
		else
		{
			summonCountF5++;
		}
		if (summonCountF5 >= 5)
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, param1_F5_Cd);
			if (_actor.LogicTime - curTime_F5 > scriptValue || curTime_F5 <= 0)
			{
				curTime_F5 = _actor.LogicTime;
				summonCountF5 = 0;
				_actor.buffComponent.AddBuff(buffId_F5_Mark, _actor);
			}
		}
	}

	public virtual void OnMonsterDied(AdventureMonsterDiedEvent evt)
	{
		if (evt.monsterID != summonId_1 && evt.monsterID != summonId_2)
		{
			return;
		}
		curSummonCount--;
		if (!CheckTalentLevel(3))
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			(item as AdventureActor)?.buffComponent.AddBuff(buffId_F3, _actor);
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
