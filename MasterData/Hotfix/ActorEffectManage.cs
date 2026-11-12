using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class ActorEffectManage : LogicMonoComponent
{
	private AdventureActor _actor;

	private int _uniqueEffectId;

	public readonly Dictionary<int, AdventureEffect> effectsDict = new Dictionary<int, AdventureEffect>();

	private readonly List<AdventureEffect> _timeTriggerEffects = new List<AdventureEffect>();

	private readonly List<int> _delayRemovedEffectUniqueIds = new List<int>();

	private int _beingProcessedRC;

	private readonly Dictionary<int, AdventureEffect> _delayAddedEffectDict = new Dictionary<int, AdventureEffect>();

	protected readonly List<int> onceAttackEffectUniqueAttackIds = new List<int>();

	private List<int> _changeEffectIdList;

	private List<AddEffectInfo> _addEffectInfoList;

	private List<int> _removeEffectIds;

	protected readonly List<ChangeBuffTimeEffectInfo> _changeBuffTimeEffectInfos = new List<ChangeBuffTimeEffectInfo>();

	protected readonly List<ChangeBuffLaminatedNumEffectInfo> _changeBuffLaminatedNumEffectInfos = new List<ChangeBuffLaminatedNumEffectInfo>();

	public int uniqueEffectId => ++_uniqueEffectId;

	public List<int> GetEffectIDs
	{
		get
		{
			if (effectsDict == null)
			{
				return null;
			}
			List<int> list = new List<int>();
			foreach (AdventureEffect value in effectsDict.Values)
			{
				if (value?.effectConfig != null)
				{
					list.Add(value.effectConfig.Id);
				}
			}
			return list;
		}
	}

	public override void OnActive()
	{
		_actor = (AdventureActor)Entity;
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (instance != null)
		{
			instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
			instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnDamageBeforeSettlement);
			instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnDamageBeforeCanCauseDead);
			instance.AddEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnDeadImmunity);
			instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT", OnDamage);
			instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnCritDamage);
			instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
			instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
			instance.AddEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnEnterSwitch);
			instance.AddEventListener("ACTOR_ENTER_BATTLE", OnEnterBattle);
			instance.AddEventListener("ACTOR_LEAVE_BATTLE", OnLeaveBattle);
			instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
			instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
			instance.AddEventListener("ACTOR_BEGIN_RELOAD", OnBeginReload);
			instance.AddEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
			instance.AddEventListener("ACTOR_BREAK_SHIELD", OnBreakShield);
			instance.AddEventListener("ACTOR_EFFECT_EXECUTE", OnEffectExecute);
			instance.AddEventListener("ACTOR_EFFECT_POSTEXECUTE", OnEffectPostExecute);
			instance.AddEventListener("SHARE_EFFECT_CD", OnShareCD);
			instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPerfectDodge);
			instance.AddEventListener("SHARE_EFFECT_TAKE_EFFECT_LIMIT", OnSharTakeEffectLimit);
			instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterClear);
			instance.AddEventListener("CHANGE_BUFF_TIME_EFFECT_EXECUTE", OnChangeBuffTimeEffectExecute);
			instance.AddEventListener("CHANGE_BUFF_TIME_EFFECT_POSTEXECUTE", OnChangeBuffTimeEffectPostExecute);
			instance.AddEventListener("CHANGE_BUFF_LAMINATEDNUM_EFFECT_EXECUTE", OnChangeBuffLaminatedNumEffectExecute);
			instance.AddEventListener("CHANGE_BUFF_LAMINATEDNUM_EFFECT_POSTEXECUTE", OnChangeBuffLaminatedNumEffectPostExecute);
			instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
			instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
			instance.AddEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
			instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
			instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
			instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
			instance.AddEventListener("ACTOR_ADD_SHIELD", OnAddShield);
			instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
			instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
			instance.AddEventListener("ADVENTURE_BATTLE_FINISH_MSG", OnBattleFinish);
		}
	}

	public override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (instance != null)
		{
			instance.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
			instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnDamageBeforeSettlement);
			instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnDamageBeforeCanCauseDead);
			instance.RemoveEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnDeadImmunity);
			instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT", OnDamage);
			instance.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnCritDamage);
			instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
			instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
			instance.RemoveEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnEnterSwitch);
			instance.RemoveEventListener("ACTOR_ENTER_BATTLE", OnEnterBattle);
			instance.RemoveEventListener("ACTOR_LEAVE_BATTLE", OnLeaveBattle);
			instance.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
			instance.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
			instance.RemoveEventListener("ACTOR_BEGIN_RELOAD", OnBeginReload);
			instance.RemoveEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
			instance.RemoveEventListener("ACTOR_BREAK_SHIELD", OnBreakShield);
			instance.RemoveEventListener("ACTOR_EFFECT_EXECUTE", OnEffectExecute);
			instance.RemoveEventListener("ACTOR_EFFECT_POSTEXECUTE", OnEffectPostExecute);
			instance.RemoveEventListener("SHARE_EFFECT_CD", OnShareCD);
			instance.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPerfectDodge);
			instance.RemoveEventListener("SHARE_EFFECT_TAKE_EFFECT_LIMIT", OnSharTakeEffectLimit);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterClear);
			instance.RemoveEventListener("CHANGE_BUFF_TIME_EFFECT_EXECUTE", OnChangeBuffTimeEffectExecute);
			instance.RemoveEventListener("CHANGE_BUFF_TIME_EFFECT_POSTEXECUTE", OnChangeBuffTimeEffectPostExecute);
			instance.RemoveEventListener("CHANGE_BUFF_LAMINATEDNUM_EFFECT_EXECUTE", OnChangeBuffLaminatedNumEffectExecute);
			instance.RemoveEventListener("CHANGE_BUFF_LAMINATEDNUM_EFFECT_POSTEXECUTE", OnChangeBuffLaminatedNumEffectPostExecute);
			instance.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
			instance.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
			instance.RemoveEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
			instance.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
			instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
			instance.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
			instance.RemoveEventListener("ACTOR_ADD_SHIELD", OnAddShield);
			instance.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
			instance.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
			instance.RemoveEventListener("ADVENTURE_BATTLE_FINISH_MSG", OnBattleFinish);
		}
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed)
			{
				value.Removed = true;
				value.OnDestory();
			}
		}
		effectsDict.Clear();
		_timeTriggerEffects.Clear();
		onceAttackEffectUniqueAttackIds.Clear();
		_changeBuffTimeEffectInfos.Clear();
		_changeBuffLaminatedNumEffectInfos.Clear();
		_uniqueEffectId = 0;
		_delayRemovedEffectUniqueIds.Clear();
		_beingProcessedRC = 0;
		_delayAddedEffectDict.Clear();
	}

	public bool AlreadyTakeEffectByAttack(int uniqueAttackId)
	{
		return onceAttackEffectUniqueAttackIds.Contains(uniqueAttackId);
	}

	public void AddUniquAttackIdByTakeEffect(int uniqueAttackId)
	{
		if (!onceAttackEffectUniqueAttackIds.Contains(uniqueAttackId))
		{
			onceAttackEffectUniqueAttackIds.Add(uniqueAttackId);
		}
	}

	public List<int> AddEffectByBuff(IList<int> effectIds, AdventureActor fromActor, BuffEntity fromBuff = null)
	{
		if (_addEffectInfoList == null)
		{
			_addEffectInfoList = new List<AddEffectInfo>();
		}
		_addEffectInfoList.Clear();
		for (int i = 0; i < effectIds.Count; i++)
		{
			AddEffectInfo item = new AddEffectInfo(effectIds.get_Item(i), -1, 0L);
			_addEffectInfoList.Add(item);
		}
		return AddEffects(EffectSourceType.Buff, _addEffectInfoList, fromActor, shareCD: false, shareTakeEffectLimit: false, fromBuff);
	}

	public int AddEffectByBuff(int effectId, AdventureActor fromActor, BuffEntity fromBuff = null)
	{
		return AddEffect(EffectSourceType.Buff, new AddEffectInfo(effectId, -1, 0L), fromActor, shareCD: false, shareTakeEffectLimit: false, fromBuff);
	}

	public void RemoveEffectByBuff(IList<int> ids)
	{
		if (ids != null && ids.Count > 0)
		{
			RemoveEffects(EffectSourceType.Buff, ids);
		}
	}

	public void RemoveEffectByBuff(int id)
	{
		RemoveEffect(EffectSourceType.Buff, id);
	}

	public List<int> AddEffectByTalent(List<AddEffectInfo> addEffectInfos)
	{
		return AddEffects(EffectSourceType.Talent, addEffectInfos, _actor);
	}

	public void RemoveEffectByTalent(IList<int> ids)
	{
		RemoveEffects(EffectSourceType.Talent, ids);
	}

	public int AddEffectByPerk(AddEffectInfo addEffectInfo, bool shareCD, bool shareTakeEffectLimit)
	{
		return AddEffect(EffectSourceType.Perk, addEffectInfo, _actor, shareCD, shareTakeEffectLimit);
	}

	public void RemoveEffectByPerk(int id)
	{
		RemoveEffect(EffectSourceType.Perk, id);
	}

	public List<int> AddEffectByBorn(int dataId, IList<int> effectIds)
	{
		if (_addEffectInfoList == null)
		{
			_addEffectInfoList = new List<AddEffectInfo>();
		}
		_addEffectInfoList.Clear();
		for (int i = 0; i < effectIds.Count; i++)
		{
			AddEffectInfo item = new AddEffectInfo(effectIds.get_Item(i), -1, 0L);
			_addEffectInfoList.Add(item);
		}
		return AddEffects(EffectSourceType.Born, _addEffectInfoList, _actor);
	}

	public void RemoveEffectByBorn(int dataId, IList<int> ids)
	{
		RemoveEffects(EffectSourceType.Born, ids);
	}

	public List<int> AddEffectByAI(List<int> effectIds)
	{
		if (_addEffectInfoList == null)
		{
			_addEffectInfoList = new List<AddEffectInfo>();
		}
		_addEffectInfoList.Clear();
		for (int i = 0; i < effectIds.Count; i++)
		{
			AddEffectInfo item = new AddEffectInfo(effectIds.get_Item(i), -1, 0L);
			_addEffectInfoList.Add(item);
		}
		return AddEffects(EffectSourceType.AI, _addEffectInfoList, _actor);
	}

	public int AddEffectByAI(int effectId)
	{
		return AddEffect(EffectSourceType.AI, new AddEffectInfo(effectId, -1, 0L), _actor);
	}

	public void RemoveEffectByAI(List<int> ids)
	{
		if (_removeEffectIds == null)
		{
			_removeEffectIds = new List<int>();
		}
		_removeEffectIds.Clear();
		_removeEffectIds.AddRange(ids);
		RemoveEffects(EffectSourceType.AI, _removeEffectIds);
	}

	public void RemoveEffectByAI(int id)
	{
		RemoveEffect(EffectSourceType.AI, id);
	}

	private int AddEffect(EffectSourceType sourceType, AddEffectInfo addEffectInfo, AdventureActor fromActor, bool shareCD = false, bool shareTakeEffectLimit = false, BuffEntity fromBuff = null)
	{
		if (addEffectInfo == null)
		{
			return 0;
		}
		if (!_actor.actorHealthInfo.isAlive)
		{
			return 0;
		}
		Effect effect = Singleton<HotfixDataController>.Instance.GetEffect(addEffectInfo.effectId);
		if (effect == null)
		{
			Debug.LogError($"effect config not exist, id:{addEffectInfo.effectId}");
			return 0;
		}
		if (addEffectInfo.takeEffectLimit == 0)
		{
			return 0;
		}
		int valueConfigIdByLevelType = CommonHelper.GetValueConfigIdByLevelType(fromActor, effect.Id, (HotfixEnum.levelTypeData)effect.LevelTypeData, effect.LevelData);
		EffectValue effectValue = Singleton<HotfixDataController>.Instance.GetEffectValue(valueConfigIdByLevelType);
		if (effectValue == null)
		{
			Debug.LogError($"effect value config not exist, id:{valueConfigIdByLevelType}");
			return 0;
		}
		HotfixEnum.effectType effectType = (HotfixEnum.effectType)effectValue.EffectType;
		AdventureEffect adventureEffect = new AdventureEffect();
		int num = uniqueEffectId;
		if (_beingProcessedRC > 0)
		{
			_delayAddedEffectDict.Add(num, adventureEffect);
		}
		else
		{
			effectsDict.Add(num, adventureEffect);
		}
		int num2 = addEffectInfo.takeEffectLimit;
		if (num2 == -1)
		{
			num2 = effectValue.TakeEffectLimit;
		}
		if (num2 == 0)
		{
			num2 = -1;
		}
		adventureEffect.OnInit(effectType, sourceType, num, effect, effectValue, _actor, fromActor, shareCD, num2, shareTakeEffectLimit, addEffectInfo.initCD, fromBuff);
		if (effect.Trigger == 19 && adventureEffect.TryParseStringParamToInt(adventureEffect.effectConfig.TriggerParam1, out var intValue))
		{
			bool flag = false;
			if (adventureEffect.TryParseStringParamToInt(adventureEffect.effectConfig.TriggerParam2, out var intValue2, allowEmpty: true))
			{
				flag = intValue2 == 1;
			}
			if (flag)
			{
				adventureEffect.nextTriggerTime = _actor.LogicTime + intValue;
			}
			_timeTriggerEffects.Add(adventureEffect);
		}
		return num;
	}

	protected List<int> AddEffects(EffectSourceType sourceType, List<AddEffectInfo> addEffectInfos, AdventureActor fromActor, bool shareCD = false, bool shareTakeEffectLimit = false, BuffEntity fromBuff = null)
	{
		if (!_actor.actorHealthInfo.isAlive)
		{
			return null;
		}
		List<int> list = new List<int>();
		for (int i = 0; i < addEffectInfos.Count; i++)
		{
			int num = AddEffect(sourceType, addEffectInfos.get_Item(i), fromActor, shareCD, shareTakeEffectLimit, fromBuff);
			if (num != 0)
			{
				list.Add(num);
			}
		}
		return list;
	}

	public List<AdventureEffect> GetEffects(List<int> effectIds)
	{
		List<AdventureEffect> list = new List<AdventureEffect>();
		if (effectIds != null && effectIds.Count > 0)
		{
			for (int i = 0; i < effectIds.Count; i++)
			{
				if (effectsDict.TryGetValue(effectIds.get_Item(i), out var value))
				{
					list.Add(value);
				}
			}
		}
		return list;
	}

	protected void RemoveEffects(EffectSourceType sourceType, IList<int> ids)
	{
		foreach (int id in ids)
		{
			if (effectsDict.TryGetValue(id, out var value) && !value.Removed)
			{
				value.Removed = true;
				_delayRemovedEffectUniqueIds.Add(id);
			}
		}
	}

	private void RemoveEffect(EffectSourceType sourceType, int effectId)
	{
		if (effectsDict.TryGetValue(effectId, out var value) && !value.Removed)
		{
			value.Removed = true;
			_delayRemovedEffectUniqueIds.Add(effectId);
		}
	}

	public bool IsHaveEffect(int effectId)
	{
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (!value.Removed && value.effectConfig.Id == effectId)
			{
				return true;
			}
		}
		return false;
	}

	public List<int> GetEffectIdList()
	{
		List<int> list = new List<int>();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (!value.Removed && value.effectConfig != null)
			{
				list.Add(value.effectConfig.Id);
			}
		}
		return list;
	}

	public List<int> GetEffectUniqueIdList()
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, AdventureEffect> item in effectsDict)
		{
			if (!item.Value.Removed)
			{
				list.Add(item.Key);
			}
		}
		return list;
	}

	public AdventureEffect GetEffectById(int effectId)
	{
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (!value.Removed && value.effectConfig.Id == effectId)
			{
				return value;
			}
		}
		return null;
	}

	public List<AdventureEffect> GetEffectByTag(string effectTag)
	{
		List<AdventureEffect> list = new List<AdventureEffect>();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (!value.Removed && string.Equals(value.effectValueConfig.Tag, effectTag))
			{
				list.Add(value);
			}
		}
		return list;
	}

	private void BeginProcess()
	{
		_beingProcessedRC++;
	}

	private void EndProcess()
	{
		_beingProcessedRC--;
		if (_beingProcessedRC > 0 || _delayAddedEffectDict.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, AdventureEffect> item in _delayAddedEffectDict)
		{
			effectsDict.Add(item.Key, item.Value);
		}
		_delayAddedEffectDict.Clear();
	}

	private void OnHpChanged(IEvent evt)
	{
		if (evt is AdventureActorHpChangedEvent { sender: AdventureActor sender } && !(sender != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.HP_CHANGE);
		}
	}

	private void OnDamageBeforeSettlement(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent))
		{
			return;
		}
		if (adventureActorReceiveDamageBeforeSettlementEvent.from == _actor)
		{
			if (!(adventureActorReceiveDamageBeforeSettlementEvent.to is AdventureActor { damageImmunity: false }))
			{
				return;
			}
			BeginProcess();
			foreach (AdventureEffect value in effectsDict.Values)
			{
				if (value == null || value.Removed || value.effectConfig.Trigger != 2)
				{
					continue;
				}
				HitDamage hitDamage = Singleton<HotfixDataController>.Instance.GetHitDamage(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageConfigId);
				List<int> list = new List<int> { hitDamage.ElementType };
				if (adventureActorReceiveDamageBeforeSettlementEvent.from is AdventureActor { actorElementInfo: var actorElementInfo })
				{
					List<int> list2 = actorElementInfo?.hitElementTypeExtension;
					if (list2 != null && list2.Count > 0)
					{
						list.AddRange(list2);
					}
					HitEventInfo hitEventInfo = new HitEventInfo(hitDamage, adventureActorReceiveDamageBeforeSettlementEvent.uniqueAttackId, adventureActorReceiveDamageBeforeSettlementEvent.onceAttackTargetCount, list);
					value.enemyEntity = adventureActorReceiveDamageBeforeSettlementEvent.to;
					AdventureEffectBase adventureEffectBase = value.PreExecute(hitEventInfo);
					if (adventureEffectBase != null)
					{
						value.Execute(adventureEffectBase);
					}
				}
			}
			EndProcess();
		}
		else
		{
			if (!(adventureActorReceiveDamageBeforeSettlementEvent.to == _actor) || _actor.damageImmunity)
			{
				return;
			}
			BeginProcess();
			foreach (AdventureEffect value2 in effectsDict.Values)
			{
				if (value2 == null || value2.Removed || value2.effectConfig.Trigger != 3)
				{
					continue;
				}
				HitDamage hitDamage2 = Singleton<HotfixDataController>.Instance.GetHitDamage(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageConfigId);
				List<int> list3 = new List<int> { hitDamage2.ElementType };
				if (adventureActorReceiveDamageBeforeSettlementEvent.from is AdventureActor { actorElementInfo: var actorElementInfo2 })
				{
					List<int> list4 = actorElementInfo2?.hitElementTypeExtension;
					if (list4 != null && list4.Count > 0)
					{
						list3.AddRange(list4);
					}
					HitEventInfo hitEventInfo2 = new HitEventInfo(hitDamage2, adventureActorReceiveDamageBeforeSettlementEvent.uniqueAttackId, adventureActorReceiveDamageBeforeSettlementEvent.onceAttackTargetCount, list3);
					value2.enemyEntity = adventureActorReceiveDamageBeforeSettlementEvent.from;
					DamageType attackType = adventureActorReceiveDamageBeforeSettlementEvent.attackType;
					if (attackType == DamageType.Melee || attackType == DamageType.Range)
					{
						value2._enemyEntityTs = adventureActorReceiveDamageBeforeSettlementEvent.firstFrom.tsTransform;
					}
					AdventureEffectBase adventureEffectBase2 = value2.PreExecute(hitEventInfo2);
					if (adventureEffectBase2 != null)
					{
						value2.Execute(adventureEffectBase2);
					}
				}
			}
			EndProcess();
		}
	}

	private void OnDamageBeforeCanCauseDead(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent && !(adventureActorReceiveDamageCanCauseDeadEvent.to != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.DAMAGE_CAUSE_DEAD);
		}
	}

	private void OnDeadImmunity(IEvent evt)
	{
		TriggerEffect(HotfixEnum.trigger.ON_IMMUNE_DEAD);
	}

	private void OnDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageForEffectEvent { attackType: not DamageType.DOT } adventureActorReceiveDamageForEffectEvent))
		{
			return;
		}
		if (adventureActorReceiveDamageForEffectEvent.from == _actor)
		{
			BeginProcess();
			foreach (AdventureEffect value in effectsDict.Values)
			{
				if (value == null || value.Removed)
				{
					continue;
				}
				value.Damage = adventureActorReceiveDamageForEffectEvent.damageToShieldAndHp;
				if (value.effectConfig.Trigger == 2)
				{
					value.PostExecute();
				}
				if (value.effectConfig.Trigger == 5)
				{
					value.PostExecute();
				}
				if (value.effectConfig.Trigger != 4 || !adventureActorReceiveDamageForEffectEvent.isKill || adventureActorReceiveDamageForEffectEvent.to is DestructibleStateSingle || adventureActorReceiveDamageForEffectEvent.to is TrapAdventureActor)
				{
					continue;
				}
				HitDamage hitDamage = Singleton<HotfixDataController>.Instance.GetHitDamage(adventureActorReceiveDamageForEffectEvent.hitDamageId);
				List<int> list = new List<int> { hitDamage.ElementType };
				if (adventureActorReceiveDamageForEffectEvent.from is AdventureActor { actorElementInfo: var actorElementInfo })
				{
					List<int> list2 = actorElementInfo?.hitElementTypeExtension;
					if (list2 != null && list2.Count > 0)
					{
						list.AddRange(list2);
					}
					HitEventInfo hitEventInfo = new HitEventInfo(hitDamage, adventureActorReceiveDamageForEffectEvent.uniqueAttackId, adventureActorReceiveDamageForEffectEvent.onceAttackTargetCount, list);
					value.enemyEntity = adventureActorReceiveDamageForEffectEvent.to;
					AdventureEffectBase adventureEffectBase = value.PreExecute(hitEventInfo);
					if (adventureEffectBase != null)
					{
						value.Execute(adventureEffectBase);
					}
				}
			}
			EndProcess();
		}
		else
		{
			if (!(adventureActorReceiveDamageForEffectEvent.to == _actor))
			{
				return;
			}
			BeginProcess();
			foreach (AdventureEffect value2 in effectsDict.Values)
			{
				if (value2 != null && !value2.Removed)
				{
					value2.enemyEntity = adventureActorReceiveDamageForEffectEvent.from;
					value2.Damage = adventureActorReceiveDamageForEffectEvent.damageToShieldAndHp;
					if (value2.effectConfig.Trigger == 3)
					{
						value2.PostExecute();
					}
					if (value2.effectConfig.Trigger == 11)
					{
						value2.PostExecute();
					}
				}
			}
			EndProcess();
		}
	}

	private void OnCritDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent))
		{
			return;
		}
		if (adventureActorReceiveCritDamageEvent.from == _actor)
		{
			BeginProcess();
			foreach (AdventureEffect value in effectsDict.Values)
			{
				if (value == null || value.Removed || value.effectConfig.Trigger != 5)
				{
					continue;
				}
				HitDamage hitDamage = Singleton<HotfixDataController>.Instance.GetHitDamage(adventureActorReceiveCritDamageEvent.hitDamageConfigId);
				List<int> list = new List<int> { hitDamage.ElementType };
				if (adventureActorReceiveCritDamageEvent.from is AdventureActor { actorElementInfo: var actorElementInfo })
				{
					List<int> list2 = actorElementInfo?.hitElementTypeExtension;
					if (list2 != null && list2.Count > 0)
					{
						list.AddRange(list2);
					}
					HitEventInfo hitEventInfo = new HitEventInfo(hitDamage, adventureActorReceiveCritDamageEvent.uniqueAttackId, adventureActorReceiveCritDamageEvent.onceAttackTargetCount, list);
					value.enemyEntity = adventureActorReceiveCritDamageEvent.to;
					AdventureEffectBase adventureEffectBase = value.PreExecute(hitEventInfo);
					if (adventureEffectBase != null)
					{
						value.Execute(adventureEffectBase);
					}
				}
			}
			EndProcess();
		}
		else
		{
			if (!(adventureActorReceiveCritDamageEvent.to == _actor))
			{
				return;
			}
			BeginProcess();
			foreach (AdventureEffect value2 in effectsDict.Values)
			{
				if (value2 == null || value2.Removed || value2.effectConfig.Trigger != 11)
				{
					continue;
				}
				HitDamage hitDamage2 = Singleton<HotfixDataController>.Instance.GetHitDamage(adventureActorReceiveCritDamageEvent.hitDamageConfigId);
				List<int> list3 = new List<int> { hitDamage2.ElementType };
				if (adventureActorReceiveCritDamageEvent.from is AdventureActor { actorElementInfo: var actorElementInfo2 })
				{
					List<int> list4 = actorElementInfo2?.hitElementTypeExtension;
					if (list4 != null && list4.Count > 0)
					{
						list3.AddRange(list4);
					}
					HitEventInfo hitEventInfo2 = new HitEventInfo(hitDamage2, adventureActorReceiveCritDamageEvent.uniqueAttackId, adventureActorReceiveCritDamageEvent.onceAttackTargetCount, list3);
					AdventureEffectBase adventureEffectBase2 = value2.PreExecute(hitEventInfo2);
					if (adventureEffectBase2 != null)
					{
						value2.Execute(adventureEffectBase2);
					}
				}
			}
			EndProcess();
		}
	}

	protected void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent) || !(evt.sender is AdventureActor adventureActor) || adventureActor != _actor || adventureActorCastSkillEvent.skillEventInfo == null)
		{
			return;
		}
		SkillEventInfo skillEventInfo = adventureActorCastSkillEvent.skillEventInfo;
		if (skillEventInfo == null)
		{
			return;
		}
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Trigger == 6)
			{
				AdventureEffectBase adventureEffectBase = value.PreExecute(null, new SkillEventInfo(skillEventInfo.skillSlotType, skillEventInfo.skillId));
				if (adventureEffectBase != null)
				{
					value.Execute(adventureEffectBase);
				}
			}
		}
		EndProcess();
	}

	protected void OnCastSkillEnd(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent) || evt.sender as AdventureActor != _actor)
		{
			return;
		}
		SkillEventInfo skillEventInfo = adventureActorCastSkillEndEvent.skillEventInfo;
		if (skillEventInfo == null)
		{
			return;
		}
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value == null || value.Removed)
			{
				continue;
			}
			if (value.effectConfig.Trigger == 6)
			{
				value.PostExecute();
			}
			if (value.effectConfig.Trigger == 20)
			{
				AdventureEffectBase adventureEffectBase = value.PreExecute(null, new SkillEventInfo(skillEventInfo.skillSlotType, skillEventInfo.skillId));
				if (adventureEffectBase != null)
				{
					value.Execute(adventureEffectBase);
				}
			}
		}
		EndProcess();
	}

	protected void OnEffectExecute(IEvent evt)
	{
		if (!(evt is AdventureActorEffectExecute adventureActorEffectExecute) || evt.sender as AdventureActor != _actor)
		{
			return;
		}
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Id != adventureActorEffectExecute.effectId && value.effectConfig.Trigger == 18)
			{
				AdventureEffectBase adventureEffectBase = value.PreExecute(null, null, null, 0, new ExecuteEffectInfo(adventureActorEffectExecute.effectId, adventureActorEffectExecute.effectTag));
				if (adventureEffectBase != null)
				{
					value.Execute(adventureEffectBase);
				}
			}
		}
		EndProcess();
	}

	protected void OnEffectPostExecute(IEvent evt)
	{
		if (!(evt is AdventureActorEffectPostExecute adventureActorEffectPostExecute) || evt.sender as AdventureActor != _actor)
		{
			return;
		}
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Id != adventureActorEffectPostExecute.effectId && value.effectConfig.Trigger == 18 && value.CheckExecuteEffectInfoIsEqual(adventureActorEffectPostExecute.effectId, adventureActorEffectPostExecute.effectTag))
			{
				value.PostExecute();
			}
		}
		EndProcess();
	}

	protected void OnEnterBattle(IEvent evt)
	{
		if (!(evt.sender is MonsterAdventureActor) && !(evt.sender as AdventureActor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.ENTERBATTLE);
		}
	}

	protected void OnLeaveBattle(IEvent evt)
	{
		if (!(evt.sender is MonsterAdventureActor) && !(evt.sender as AdventureActor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.LEAVEBATTLE);
		}
	}

	protected void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && !(evt.sender as AdventureActor != _actor))
		{
			TriggerBufferEffect(HotfixEnum.trigger.GETBUFF, adventureActorGetBuff.eventInfo);
		}
	}

	protected void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && !(evt.sender as AdventureActor != _actor))
		{
			TriggerBufferEffect(HotfixEnum.trigger.REMOVEBUFF, adventureActorRemoveBuff.eventInfo);
		}
	}

	protected void OnBeginReload(IEvent evt)
	{
		if (!(evt.sender as AdventureActor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.BEGIN_RELOAD);
		}
	}

	private void TriggerBufferEffect(HotfixEnum.trigger gameTrigger, BuffEventInfo buffEventInfo)
	{
		if (buffEventInfo == null || (gameTrigger == HotfixEnum.trigger.REMOVEBUFF && !buffEventInfo.iRemoveNature))
		{
			return;
		}
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Trigger == (int)gameTrigger)
			{
				BuffEventInfo buffEventInfo2 = new BuffEventInfo
				{
					buffId = buffEventInfo.buffId,
					buffGroupId = buffEventInfo.buffGroupId
				};
				buffEventInfo2.buffTags.AddRange(buffEventInfo.buffTags);
				AdventureEffectBase adventureEffectBase = value.PreExecute(null, null, buffEventInfo2);
				if (adventureEffectBase != null)
				{
					value.Execute(adventureEffectBase);
				}
			}
		}
		EndProcess();
	}

	private void TriggerEffect(HotfixEnum.trigger gameTrigger, int certainShieldId = 0, HitEventInfo hitEventInfo = null, TriggerMarkEventInfo triggerMarkInfo = null)
	{
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Trigger == (int)gameTrigger)
			{
				if (triggerMarkInfo != null)
				{
					value.enemyEntity = triggerMarkInfo.target;
				}
				AdventureEffectBase adventureEffectBase = value.PreExecute(hitEventInfo, null, null, certainShieldId, null, triggerMarkInfo);
				if (adventureEffectBase != null)
				{
					value.Execute(adventureEffectBase);
				}
			}
		}
		EndProcess();
	}

	private void PostExecuteEffect(HotfixEnum.trigger gameTrigger)
	{
		BeginProcess();
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && !value.Removed && value.effectConfig.Trigger == (int)gameTrigger)
			{
				value.PostExecute();
			}
		}
		EndProcess();
	}

	protected void OnFinishReload(IEvent evt)
	{
		if (evt.sender is AdventureActor adventureActor && !(adventureActor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.FINISH_RELOAD);
		}
	}

	protected void OnEnterSwitch(IEvent evt)
	{
		if (!(evt.sender is MonsterAdventureActor) && !(evt.sender as AdventureActor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.SWICH_PLAYER);
		}
	}

	protected void OnBreakShield(IEvent evt)
	{
		if (evt is AdventureActorBreakShield adventureActorBreakShield)
		{
			if (adventureActorBreakShield.from == _actor)
			{
				TriggerEffect(HotfixEnum.trigger.TO_BREAK_ALLSHIELD);
			}
			else if (adventureActorBreakShield.to == _actor && adventureActorBreakShield.from != null)
			{
				TriggerEffect(HotfixEnum.trigger.BE_BREAK_ALLSHIELD);
			}
		}
	}

	protected void OnPerfectDodge(IEvent evt)
	{
		if (evt is AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger && !(adventurePerfectDodgeTrigger.actor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.PERFECT_DODGE);
		}
	}

	protected void OnMonsterClear(IEvent evt)
	{
		if (evt is AdventureLevelMonsterClearedEvent { isEmptyLevel: false })
		{
			TriggerEffect(HotfixEnum.trigger.BATTLE_WIN);
		}
	}

	private void OnToughnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent { isToughnessBroken: not false } monsterToughnessStateChangeEvent && !(monsterToughnessStateChangeEvent.source != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.BREAK_TOUGHNESS);
		}
	}

	private void OnTriggerElementMark(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent)
		{
			TriggerMarkEventInfo triggerMarkInfo = new TriggerMarkEventInfo(adventureElementMarkTriggerEvent.elementType, adventureElementMarkTriggerEvent.elementTag, adventureElementMarkTriggerEvent.markActor);
			TriggerEffect(HotfixEnum.trigger.ANY_ACTOR_TRIGGER_MARK, 0, null, triggerMarkInfo);
			if (!(adventureElementMarkTriggerEvent.triggerActor != _actor))
			{
				TriggerEffect(HotfixEnum.trigger.TRIGGER_MARK, 0, null, triggerMarkInfo);
			}
		}
	}

	private void OnActorEnergyChange(IEvent evt)
	{
		if (evt is AdventureActorEnergyChangeEvent adventureActorEnergyChangeEvent && !(adventureActorEnergyChangeEvent.actor != _actor))
		{
			TriggerEffect(HotfixEnum.trigger.ULTIMATE_ENERGY_CHANGE);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent)
		{
			if (adventureActorReceiveAttackEvent.from == _actor)
			{
				TriggerEffect(HotfixEnum.trigger.ATTACKING);
			}
			else if (adventureActorReceiveAttackEvent.to == _actor)
			{
				TriggerEffect(HotfixEnum.trigger.BEATTACK);
			}
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.IsMinion(out var summoner) && summoner == _actor)
		{
			TriggerEffect(HotfixEnum.trigger.SUMMONED_DIED);
		}
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (evt is AdventurActorSpawned adventurActorSpawned && (adventurActorSpawned.sender as AdventureActor).IsMinion(out var summoner) && summoner == _actor)
		{
			TriggerEffect(HotfixEnum.trigger.SUMMON);
		}
	}

	private void OnAddShield(IEvent evt)
	{
		if (evt is AdventureActorAddShield adventureActorAddShield)
		{
			if (adventureActorAddShield.from == _actor)
			{
				TriggerEffect(HotfixEnum.trigger.ADD_SHIELD, adventureActorAddShield.shieldId);
			}
			if (adventureActorAddShield.to == _actor)
			{
				TriggerEffect(HotfixEnum.trigger.GET_SHIELD, adventureActorAddShield.shieldId);
			}
		}
	}

	private void OnRemoveShield(IEvent evt)
	{
		if (evt is AdventureActorRemoveShield adventureActorRemoveShield && adventureActorRemoveShield.sender as AdventureActor == _actor)
		{
			if (adventureActorRemoveShield.removeType == ShiledRemoveType.TimeFinish)
			{
				TriggerEffect(HotfixEnum.trigger.BE_FINISH_CERTAINSHIELD, adventureActorRemoveShield.shieldId);
			}
			else if (adventureActorRemoveShield.removeType == ShiledRemoveType.DamageBreak)
			{
				TriggerEffect(HotfixEnum.trigger.BE_BREAK_CERTAINSHIELD, adventureActorRemoveShield.shieldId);
			}
		}
	}

	private void OnBattleStart(IEvent evt)
	{
		if (evt is AdventureMsgBattleStartEvent)
		{
			TriggerEffect(HotfixEnum.trigger.IN_BATTLE_STATE);
		}
	}

	private void OnBattleFinish(IEvent evt)
	{
		if (evt is AdventureMsgBattleFinishEvent)
		{
			PostExecuteEffect(HotfixEnum.trigger.IN_BATTLE_STATE);
		}
	}

	public void LogicUpdate(FP deltaTime)
	{
		for (int i = 0; i < _timeTriggerEffects.Count; i++)
		{
			AdventureEffect adventureEffect = _timeTriggerEffects.get_Item(i);
			if (adventureEffect != null && !adventureEffect.Removed && !(_actor.LogicTime < adventureEffect.nextTriggerTime) && adventureEffect.TryParseStringParamToInt(adventureEffect.effectConfig.TriggerParam1, out var intValue))
			{
				adventureEffect.nextTriggerTime = _actor.LogicTime + intValue;
				AdventureEffectBase adventureEffectBase = adventureEffect.PreExecute();
				if (adventureEffectBase != null)
				{
					adventureEffect.Execute(adventureEffectBase);
				}
			}
		}
		_timeTriggerEffects.RemoveAll((AdventureEffect x) => x.Removed);
		foreach (int delayRemovedEffectUniqueId in _delayRemovedEffectUniqueIds)
		{
			if (effectsDict.TryGetValue(delayRemovedEffectUniqueId, out var value))
			{
				value.OnDestory();
				effectsDict.Remove(delayRemovedEffectUniqueId);
			}
		}
		_delayRemovedEffectUniqueIds.Clear();
	}

	protected void OnShareCD(IEvent evt)
	{
		if (_actor is MonsterAdventureActor || !(evt is AdventureActorShareEffectCd adventureActorShareEffectCd) || adventureActorShareEffectCd.ownerId == _actor.dataID)
		{
			return;
		}
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && value.shareCD && value.effectConfig.Id == adventureActorShareEffectCd.effectId)
			{
				value.CD = adventureActorShareEffectCd.cd;
				break;
			}
		}
	}

	protected void OnSharTakeEffectLimit(IEvent evt)
	{
		if (_actor is MonsterAdventureActor || !(evt is AdventureActorShareTakeEffectLimit adventureActorShareTakeEffectLimit) || adventureActorShareTakeEffectLimit.ownerId == _actor.dataID)
		{
			return;
		}
		foreach (AdventureEffect value in effectsDict.Values)
		{
			if (value != null && value.shareTakeEffectLimit && value.effectConfig.Id == adventureActorShareTakeEffectLimit.effectId)
			{
				value.takeEffectLimit = adventureActorShareTakeEffectLimit.limit;
				break;
			}
		}
	}

	protected void OnChangeBuffTimeEffectExecute(IEvent evt)
	{
		if (evt is AdventureActorChangeBuffTimeEffectExecute adventureActorChangeBuffTimeEffectExecute && !(adventureActorChangeBuffTimeEffectExecute.sender as AdventureActor != _actor))
		{
			_changeBuffTimeEffectInfos.Add(new ChangeBuffTimeEffectInfo(adventureActorChangeBuffTimeEffectExecute.buffId, adventureActorChangeBuffTimeEffectExecute.buffGroupId, adventureActorChangeBuffTimeEffectExecute.buffTag, adventureActorChangeBuffTimeEffectExecute.changeTimeAbs, adventureActorChangeBuffTimeEffectExecute.changeTimePercent));
		}
	}

	protected void OnChangeBuffTimeEffectPostExecute(IEvent evt)
	{
		if (!(evt is AdventureActorChangeBuffTimeEffectPostExecute adventureActorChangeBuffTimeEffectPostExecute) || adventureActorChangeBuffTimeEffectPostExecute.sender as AdventureActor != _actor)
		{
			return;
		}
		for (int i = 0; i < _changeBuffTimeEffectInfos.Count; i++)
		{
			ChangeBuffTimeEffectInfo changeBuffTimeEffectInfo = _changeBuffTimeEffectInfos.get_Item(i);
			if (changeBuffTimeEffectInfo.buffId == adventureActorChangeBuffTimeEffectPostExecute.buffId && changeBuffTimeEffectInfo.buffGroupId == adventureActorChangeBuffTimeEffectPostExecute.buffGroupId && changeBuffTimeEffectInfo.buffTag == adventureActorChangeBuffTimeEffectPostExecute.buffTag && changeBuffTimeEffectInfo.absChange == adventureActorChangeBuffTimeEffectPostExecute.changeTimeAbs && changeBuffTimeEffectInfo.percentChange == adventureActorChangeBuffTimeEffectPostExecute.changeTimePercent)
			{
				_changeBuffTimeEffectInfos.RemoveAt(i);
				break;
			}
		}
	}

	public (FP, int) GetBuffChangeTime(int buffId, int buffGroupId, List<int> buffTags)
	{
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < _changeBuffTimeEffectInfos.Count; i++)
		{
			ChangeBuffTimeEffectInfo changeBuffTimeEffectInfo = _changeBuffTimeEffectInfos.get_Item(i);
			if (changeBuffTimeEffectInfo.buffId == buffId || changeBuffTimeEffectInfo.buffGroupId == buffGroupId || buffTags.Contains(changeBuffTimeEffectInfo.buffTag))
			{
				num += changeBuffTimeEffectInfo.absChange;
				num2 += changeBuffTimeEffectInfo.percentChange;
			}
		}
		return (num, num2);
	}

	protected void OnChangeBuffLaminatedNumEffectExecute(IEvent evt)
	{
		if (evt is AdventureActorChangeBuffLaminatedNumEffectExecute adventureActorChangeBuffLaminatedNumEffectExecute && !(adventureActorChangeBuffLaminatedNumEffectExecute.sender as AdventureActor != _actor))
		{
			_changeBuffLaminatedNumEffectInfos.Add(new ChangeBuffLaminatedNumEffectInfo(adventureActorChangeBuffLaminatedNumEffectExecute.buffId, adventureActorChangeBuffLaminatedNumEffectExecute.buffGroupId, adventureActorChangeBuffLaminatedNumEffectExecute.buffTag, adventureActorChangeBuffLaminatedNumEffectExecute.changeNum));
		}
	}

	protected void OnChangeBuffLaminatedNumEffectPostExecute(IEvent evt)
	{
		if (!(evt is AdventureActorChangeBuffLaminatedNumEffectPostExecute adventureActorChangeBuffLaminatedNumEffectPostExecute) || adventureActorChangeBuffLaminatedNumEffectPostExecute.sender as AdventureActor != _actor)
		{
			return;
		}
		for (int i = 0; i < _changeBuffLaminatedNumEffectInfos.Count; i++)
		{
			ChangeBuffLaminatedNumEffectInfo changeBuffLaminatedNumEffectInfo = _changeBuffLaminatedNumEffectInfos.get_Item(i);
			if (changeBuffLaminatedNumEffectInfo.buffId == adventureActorChangeBuffLaminatedNumEffectPostExecute.buffId && changeBuffLaminatedNumEffectInfo.buffGroupId == adventureActorChangeBuffLaminatedNumEffectPostExecute.buffGroupId && changeBuffLaminatedNumEffectInfo.buffTag == adventureActorChangeBuffLaminatedNumEffectPostExecute.buffTag && changeBuffLaminatedNumEffectInfo.changeNum == adventureActorChangeBuffLaminatedNumEffectPostExecute.changeNum)
			{
				_changeBuffLaminatedNumEffectInfos.RemoveAt(i);
				break;
			}
		}
	}

	public int GetBuffChangeLaminatedNum(int buffId, int buffGroupId, List<int> buffTags)
	{
		int num = 0;
		for (int i = 0; i < _changeBuffLaminatedNumEffectInfos.Count; i++)
		{
			ChangeBuffLaminatedNumEffectInfo changeBuffLaminatedNumEffectInfo = _changeBuffLaminatedNumEffectInfos.get_Item(i);
			if (changeBuffLaminatedNumEffectInfo.buffId == buffId || changeBuffLaminatedNumEffectInfo.buffGroupId == buffGroupId || buffTags.Contains(changeBuffLaminatedNumEffectInfo.buffTag))
			{
				num += changeBuffLaminatedNumEffectInfo.changeNum;
			}
		}
		return num;
	}
}
