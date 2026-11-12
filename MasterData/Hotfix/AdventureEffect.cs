using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class AdventureEffect
{
	public int id;

	public EffectSourceType sourceType;

	private HotfixEnum.effectType _effectType;

	public LogicEntity enemyEntity;

	public TrueSyncTransform _enemyEntityTs;

	private Stack<AdventureEffectBase> _effectStack = new Stack<AdventureEffectBase>();

	public bool shareCD;

	public bool shareTakeEffectLimit;

	protected int _takeEffectLimit;

	protected CoroutineNode _cdCoroutine;

	private List<AdventureActor> _impactActors = new List<AdventureActor>();

	protected bool _isNeedPostExecute;

	protected FP _cd;

	public FP OrginMaxCd;

	private bool removed;

	public AdventureActor _owner;

	public AdventureActor _fromActor;

	public AdventureWeapon _fromWeapon;

	public BuffEntity _fromBuffEntity;

	public FP nextTriggerTime;

	public long Damage;

	public HotfixEnum.effectType EffectType => _effectType;

	public Effect effectConfig { get; private set; }

	public EffectValue effectValueConfig { get; private set; }

	protected bool _isContinuous => effectConfig.Trigger == 1;

	public FP CD
	{
		get
		{
			return _cd;
		}
		set
		{
			_cd = value;
		}
	}

	public int takeEffectLimit
	{
		get
		{
			return _takeEffectLimit;
		}
		set
		{
			_takeEffectLimit = value;
		}
	}

	public FP MaxCD { get; set; }

	public int ownerId => _owner.dataID;

	public bool Removed
	{
		get
		{
			return removed;
		}
		set
		{
			if (removed != value)
			{
				removed = value;
				if (removed)
				{
					Clear();
				}
			}
		}
	}

	public void OnInit(HotfixEnum.effectType effType, EffectSourceType sourceType, int id, Effect effectConfig, EffectValue effectValueConfig, AdventureActor owner, AdventureActor fromActor, bool shareCD, int takeEffectLimit, bool shareTakeEffectLimit, FP initCD, BuffEntity fromBuff = null)
	{
		_effectType = effType;
		this.sourceType = sourceType;
		this.id = id;
		this.shareCD = shareCD;
		this.shareTakeEffectLimit = shareTakeEffectLimit;
		_takeEffectLimit = takeEffectLimit;
		this.effectConfig = effectConfig;
		this.effectValueConfig = effectValueConfig;
		_owner = owner;
		_fromActor = fromActor;
		OrginMaxCd = FP.FromMyriad(effectValueConfig.CD);
		MaxCD = OrginMaxCd;
		_fromBuffEntity = fromBuff;
		if (initCD > 0)
		{
			_cd = initCD;
			if (_cdCoroutine != null)
			{
				_owner.StopLogicCoroutine(_cdCoroutine);
			}
			_cdCoroutine = _owner.StartLogicCoroutine(cdHandler());
		}
		if (_isContinuous)
		{
			AdventureEffectBase adventureEffectBase = PreExecute();
			if (adventureEffectBase != null)
			{
				Execute(adventureEffectBase);
			}
		}
	}

	public AdventureEffectBase GetCurrentExecution()
	{
		return _effectStack.Peek();
	}

	public AdventureEffectBase PreExecute(HitEventInfo hitEventInfo = null, SkillEventInfo skillEventInfo = null, BuffEventInfo buffEventInfo = null, int certainShieldId = 0, ExecuteEffectInfo executeEffectInfo = null, TriggerMarkEventInfo triggerMarkEventInfo = null)
	{
		if (_takeEffectLimit == 0)
		{
			return null;
		}
		if (_cd > 0)
		{
			return null;
		}
		if (!TriggerConditionExcute(skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo))
		{
			return null;
		}
		if (!TakeConditionExcute(skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo))
		{
			return null;
		}
		List<AdventureActor> list = new List<AdventureActor>();
		list.AddRange(TargetConditionFilter(skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo));
		if (list.Count > 0)
		{
			AdventureEffectBase adventureEffectBase = AdventureEffectFactory.Instance.CreateAdventureEffect(_effectType);
			if (adventureEffectBase == null)
			{
				return null;
			}
			adventureEffectBase.executeEffectInfo = executeEffectInfo;
			adventureEffectBase.SetEffectTargets(this, list);
			return adventureEffectBase;
		}
		return null;
	}

	public bool TriggerConditionExcute(SkillEventInfo skillEventInfo, HitEventInfo hitEventInfo, BuffEventInfo buffEventInfo, int certainShieldId, ExecuteEffectInfo executeEffectInfo, TriggerMarkEventInfo triggerMarkEventInfo)
	{
		bool flag = CheckCondition(effectConfig.TriggerTarget, effectConfig.TriggerCondition1, effectConfig.TriggerParam1, effectConfig.TriggerParam2, effectConfig.TriggerParam3, effectConfig.TriggerParam4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
		bool flag2 = CheckCondition(effectConfig.TriggerTarget2, effectConfig.TriggerCondition2, effectConfig.Trigger2Param1, effectConfig.Trigger2Param2, effectConfig.Trigger2Param3, effectConfig.Trigger2Param4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
		return (HotfixEnum.logicType)effectConfig.TriggerLogicType switch
		{
			HotfixEnum.logicType.AND => flag & flag2, 
			HotfixEnum.logicType.OR => flag | flag2, 
			_ => false, 
		};
	}

	public bool TakeConditionExcute(SkillEventInfo skillEventInfo, HitEventInfo hitEventInfo, BuffEventInfo buffEventInfo, int certainShieldId, ExecuteEffectInfo executeEffectInfo, TriggerMarkEventInfo triggerMarkEventInfo)
	{
		if (MonoSingleton<GameController>.Instance.Random_Roguelike(1, 101) > effectValueConfig.EffectRate)
		{
			return false;
		}
		bool flag = CheckCondition(effectConfig.TakeEffectTarget1, effectConfig.TakeEffectCondition1, effectConfig.TakeEffectParam1, effectConfig.TakeEffectParam2, effectConfig.TakeEffectParam3, effectConfig.TakeEffectParam4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
		bool flag2 = CheckCondition(effectConfig.TakeEffectTarget2, effectConfig.TakeEffectCondition2, effectConfig.TakeEffect2Param1, effectConfig.TakeEffect2Param2, effectConfig.TakeEffect2Param3, effectConfig.TakeEffect2Param4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
		return (HotfixEnum.logicType)effectConfig.TakeEffectLogicType switch
		{
			HotfixEnum.logicType.AND => flag & flag2, 
			HotfixEnum.logicType.OR => flag | flag2, 
			_ => false, 
		};
	}

	public List<AdventureActor> TargetConditionFilter(SkillEventInfo skillEventInfo, HitEventInfo hitEventInfo, BuffEventInfo buffEventInfo, int certainShieldId, ExecuteEffectInfo executeEffectInfo, TriggerMarkEventInfo triggerMarkEventInfo)
	{
		List<AdventureActor> list = new List<AdventureActor>();
		if (effectConfig.Target1 == 0)
		{
			return list;
		}
		GetGoals(effectConfig.Target1);
		for (int i = 0; i < _impactActors.Count; i++)
		{
			bool flag = ExecuteCondition(_impactActors.get_Item(i), effectConfig.TargetCondition1, effectConfig.TargetParam1, effectConfig.TargetParam2, effectConfig.TargetParam3, effectConfig.TargetParam4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
			bool flag2 = ExecuteCondition(_impactActors.get_Item(i), effectConfig.TargetCondition2, effectConfig.Target2Param1, effectConfig.Target2Param2, effectConfig.Target2Param3, effectConfig.Target2Param4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo);
			if ((HotfixEnum.logicType)effectConfig.TakeEffectLogicType switch
			{
				HotfixEnum.logicType.AND => flag & flag2, 
				HotfixEnum.logicType.OR => flag | flag2, 
				_ => throw new ArgumentOutOfRangeException(), 
			})
			{
				list.Add(_impactActors.get_Item(i));
			}
		}
		return list;
	}

	private bool CheckCondition(int _target, int _condition, string parmas1, string parmas2, string parmas3, string parmas4, SkillEventInfo skillEventInfo, HitEventInfo hitEventInfo, BuffEventInfo buffEventInfo, int certainShieldId, ExecuteEffectInfo executeEffectInfo, TriggerMarkEventInfo triggerMarkEventInfo)
	{
		if (_target == 0)
		{
			return true;
		}
		GetGoals(_target);
		for (int i = 0; i < _impactActors.Count; i++)
		{
			if (!ExecuteCondition(_impactActors.get_Item(i), _condition, parmas1, parmas2, parmas3, parmas4, skillEventInfo, hitEventInfo, buffEventInfo, certainShieldId, executeEffectInfo, triggerMarkEventInfo))
			{
				return false;
			}
		}
		return true;
	}

	private void GetGoals(int goal)
	{
		_impactActors.Clear();
		switch ((HotfixEnum.effectiveGoals)goal)
		{
		case HotfixEnum.effectiveGoals.ENEMY:
			if (enemyEntity != null && enemyEntity.GetComponent<AdventureActor>() != null)
			{
				_impactActors.Add(enemyEntity.GetComponent<AdventureActor>());
			}
			break;
		case HotfixEnum.effectiveGoals.ONESELF:
			_impactActors.Add(_owner);
			break;
		case HotfixEnum.effectiveGoals.FULL_TEAM:
			_impactActors.AddRange(ILRuntimeAPI.GetAllPlayerActors(_owner));
			break;
		case HotfixEnum.effectiveGoals.TEAMMATE:
			_impactActors.AddRange(ILRuntimeAPI.GetAllPlayerActors(_owner, includeSelf: false));
			break;
		case HotfixEnum.effectiveGoals.FULL_ENEMY:
			_impactActors.AddRange(ILRuntimeAPI.GetConfrontFactionActors(_owner));
			break;
		case HotfixEnum.effectiveGoals.MAINCONTROL_PLAYER:
			_impactActors.Add(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor);
			break;
		case HotfixEnum.effectiveGoals.ASSISTANT_PLAYER:
			_impactActors.AddRange(ILRuntimeAPI.GetAssistantPlayers());
			break;
		case HotfixEnum.effectiveGoals.TEAM_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetFriendFactionMinions(_owner));
			break;
		case HotfixEnum.effectiveGoals.FULL_TEAM_AND_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetAllPlayerActors(_owner));
			_impactActors.AddRange(ILRuntimeAPI.GetFriendFactionMinions(_owner));
			break;
		case HotfixEnum.effectiveGoals.ONESELF_AND_SUMMONED:
			_impactActors.Add(_owner);
			_impactActors.AddRange(ILRuntimeAPI.GetSelfMinions(_owner));
			break;
		case HotfixEnum.effectiveGoals.FRIEND_FACTION:
			_impactActors.AddRange(ILRuntimeAPI.GetFriendFactionActors(_owner));
			break;
		case HotfixEnum.effectiveGoals.FRIEND_AND_ENEMY_FACTION:
			_impactActors.AddRange(ILRuntimeAPI.GetFriendAndConfrontFactionActors(_owner));
			break;
		case HotfixEnum.effectiveGoals.FROM_ACTOR_SUMMONED:
			if (_fromActor != null)
			{
				_impactActors.AddRange(ILRuntimeAPI.GetSelfMinions(_fromActor));
			}
			break;
		case HotfixEnum.effectiveGoals.TEAMMATE_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetFactionMinionsExceptSelf(_owner));
			break;
		case HotfixEnum.effectiveGoals.ENEMY_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetConfrontFactionMinions(_owner));
			break;
		case HotfixEnum.effectiveGoals.FRIEND_AND_ENEMY_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetFriendAndConfrontFactionMinions(_owner));
			break;
		case HotfixEnum.effectiveGoals.TEAMMATE_AND_SUMMONED:
			_impactActors.AddRange(ILRuntimeAPI.GetAllPlayerActors(_owner, includeSelf: false));
			_impactActors.AddRange(ILRuntimeAPI.GetFactionMinionsExceptSelf(_owner));
			break;
		default:
			throw new ArgumentOutOfRangeException("goal", goal, null);
		}
	}

	private bool ExecuteCondition(AdventureActor _impactA, int _condition, string parmas1, string parmas2, string parmas3, string parmas4, SkillEventInfo skillEventInfo, HitEventInfo hitEventInfo, BuffEventInfo buffEventInfo, int certainShieldId, ExecuteEffectInfo executeEffectInfo, TriggerMarkEventInfo triggerMarkEventInfo)
	{
		if (_impactA == null)
		{
			return false;
		}
		int intValue;
		int intValue5;
		switch ((HotfixEnum.takeEffect)_condition)
		{
		case HotfixEnum.takeEffect.NONE:
		case HotfixEnum.takeEffect.DEFAULT:
		case HotfixEnum.takeEffect.TIME_INTERVAL:
			return true;
		case HotfixEnum.takeEffect.HEALTHUP:
			if (TryParseStringParamToInt(parmas1, out intValue, allowEmpty: true))
			{
				if (intValue > 0)
				{
					return _impactA.actorHealthInfo.hpPercentage * 100 >= intValue;
				}
				if (TryParseStringParamToInt(parmas2, out intValue5, allowEmpty: true))
				{
					return _impactA.actorHealthInfo.hp >= intValue5;
				}
			}
			return false;
		case HotfixEnum.takeEffect.HEALTHDOWN:
			if (TryParseStringParamToInt(parmas1, out intValue, allowEmpty: true))
			{
				if (intValue > 0)
				{
					return _impactA.actorHealthInfo.hpPercentage * 100 < intValue;
				}
				if (TryParseStringParamToInt(parmas2, out intValue5, allowEmpty: true))
				{
					return _impactA.actorHealthInfo.hp < intValue5;
				}
			}
			return false;
		case HotfixEnum.takeEffect.CARRYBUFFID:
			if (_impactA.buffComponent == null)
			{
				return false;
			}
			if (TryParseStringParamToInt(parmas1, out intValue))
			{
				return _impactA.buffComponent.CheckBuffByBuffID(intValue);
			}
			return false;
		case HotfixEnum.takeEffect.CARRYBUFFGROUP:
			if (_impactA.buffComponent == null)
			{
				return false;
			}
			if (TryParseStringParamToInt(parmas1, out intValue))
			{
				return _impactA.buffComponent.CheckBuffByBuffGroupID(intValue);
			}
			return false;
		case HotfixEnum.takeEffect.CARRYBUFFIDENTIFYING:
			if (_impactA.buffComponent != null)
			{
				return _impactA.buffComponent.CheckBuffByBuffTag(CommonHelper.StringToHash(parmas1));
			}
			return false;
		case HotfixEnum.takeEffect.SKILLSLOTTYPE:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (skillEventInfo != null && intValue == (int)skillEventInfo.skillSlotType)
			{
				return true;
			}
			if (hitEventInfo != null && intValue == hitEventInfo.hitDamageConfig.SkillSlotType)
			{
				return true;
			}
			return false;
		case HotfixEnum.takeEffect.HITELEMENTTYPE:
			if (hitEventInfo == null)
			{
				Debug.LogError("指定伤害元素类型 需要和攻击相关触发条件配合使用");
				return false;
			}
			if (TryParseStringParamToInt(parmas1, out intValue))
			{
				return hitEventInfo.hitElementTypes.Contains(intValue);
			}
			return false;
		case HotfixEnum.takeEffect.DISTANCETYPE:
			if (hitEventInfo == null)
			{
				Debug.LogError("指定攻击类型 需要和攻击相关触发条件配合使用");
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return intValue == hitEventInfo.hitDamageConfig.DistanceType;
		case HotfixEnum.takeEffect.ACTORELEMENTTYPE:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (_impactA.actorElementInfo.elementType != (HotfixEnum.elementType)intValue)
			{
				return _impactA.actorElementInfo.hitElementTypeExtension.Contains(intValue);
			}
			return true;
		case HotfixEnum.takeEffect.CERTAINBUFFID:
			if (buffEventInfo == null)
			{
				Debug.LogError("指定BUFFID类型 需要和获取/移除buff触发条件配合使用");
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return buffEventInfo.buffId == intValue;
		case HotfixEnum.takeEffect.CERTAINBUFFGROUPID:
			if (buffEventInfo == null)
			{
				Debug.LogError("指定BUFF组ID类型 需要和获取/移除buff触发条件配合使用");
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return buffEventInfo.buffGroupId == intValue;
		case HotfixEnum.takeEffect.CERTAINBUFFTAG:
		{
			if (buffEventInfo == null)
			{
				Debug.LogError("指定BUFF标识类型 需要和获取/移除buff触发条件配合使用");
				return false;
			}
			int item = CommonHelper.StringToHash(parmas1);
			return buffEventInfo.buffTags.Contains(item);
		}
		case HotfixEnum.takeEffect.CERTAINSHIELDID:
			if (certainShieldId == 0)
			{
				Debug.LogError("指定护盾id类型 需要和指定护盾类触发条件配合使用");
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return certainShieldId == intValue;
		case HotfixEnum.takeEffect.NEARBY_ACTOR_LARGE_OR_EQUAL:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (!TryParseStringParamToInt(parmas2, out intValue5))
			{
				return false;
			}
			return GetNearbyActorCount(_impactA, intValue) >= intValue5;
		case HotfixEnum.takeEffect.NEARBY_ACTOR_LESS_OR_EQUAL:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (!TryParseStringParamToInt(parmas2, out intValue5))
			{
				return false;
			}
			return GetNearbyActorCount(_impactA, intValue) <= intValue5;
		case HotfixEnum.takeEffect.CERTAIN_SKILL_ID:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (skillEventInfo == null)
			{
				Debug.LogError("指定技能id类型 需要和释放技能触发条件配合使用");
				return false;
			}
			return intValue == skillEventInfo.skillId;
		case HotfixEnum.takeEffect.HAVE_SHIELD:
			if (_impactA.actorShield == null)
			{
				return false;
			}
			return _impactA.actorShield.shiledValue > 0;
		case HotfixEnum.takeEffect.NO_SHIELD:
			if (_impactA.actorShield == null)
			{
				return false;
			}
			return _impactA.actorShield.shiledValue <= 0;
		case HotfixEnum.takeEffect.LEAVE_STAGE:
			return SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.Id != _impactA.Id;
		case HotfixEnum.takeEffect.HIT_TARGET_MOREOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (hitEventInfo == null)
			{
				Debug.LogError("同时命中敌人多于 类型 需要和命中时触发条件配合使用");
				return false;
			}
			if (_owner.effectManage.AlreadyTakeEffectByAttack(hitEventInfo.uniqueAttackId))
			{
				return false;
			}
			if (hitEventInfo.onceAttackTargetCount >= intValue)
			{
				_owner.effectManage.AddUniquAttackIdByTakeEffect(hitEventInfo.uniqueAttackId);
				return true;
			}
			return false;
		case HotfixEnum.takeEffect.HIT_TARGET_LESSOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (hitEventInfo == null)
			{
				Debug.LogError("同时命中敌人少于 类型 需要和命中时触发条件配合使用");
				return false;
			}
			if (_owner.effectManage.AlreadyTakeEffectByAttack(hitEventInfo.uniqueAttackId))
			{
				return false;
			}
			if (hitEventInfo.onceAttackTargetCount > intValue)
			{
				return false;
			}
			_owner.effectManage.AddUniquAttackIdByTakeEffect(hitEventInfo.uniqueAttackId);
			return true;
		case HotfixEnum.takeEffect.BUFF_NUM:
		{
			if (_impactA.buffComponent == null)
			{
				return false;
			}
			TryParseStringParamToInt(parmas1, out var intValue2);
			TryParseStringParamToInt(parmas2, out var intValue3, allowEmpty: true);
			TryParseStringParamToInt(parmas3, out var intValue4, allowEmpty: true);
			return _impactA.buffComponent.GetBuffNum(intValue3, intValue4, CommonHelper.StringToHash(parmas4)) >= intValue2;
		}
		case HotfixEnum.takeEffect.PROBOBILITY_UP:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return MonoSingleton<GameController>.Instance.Random_Roguelike(FP.Zero, FP.One) >= FP.FromPercent(intValue);
		case HotfixEnum.takeEffect.CERTAIN_LEVEL_TYPE:
		{
			string[] array2 = parmas1.Split(',');
			for (int j = 0; j < array2.Length; j++)
			{
				if (!TryParseStringParamToInt(array2[j], out intValue))
				{
					return false;
				}
				if (intValue == (int)ModuleController<AdventureModuleController>.Instance.levelType)
				{
					return true;
				}
			}
			return false;
		}
		case HotfixEnum.takeEffect.CERTAIN_EFFECT_ID:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return intValue == executeEffectInfo.effectId;
		case HotfixEnum.takeEffect.CERTAIN_EFFECT_TAG:
			return parmas1 == executeEffectInfo.effectTag;
		case HotfixEnum.takeEffect.CERTAIN_MONSTER_EPICTYPE:
		{
			MonsterAdventureActor monsterAdventureActor3 = _impactA as MonsterAdventureActor;
			if (monsterAdventureActor3 == null)
			{
				return false;
			}
			string[] array = parmas1.Split(',');
			for (int i = 0; i < array.Length; i++)
			{
				if (!TryParseStringParamToInt(array[i], out intValue))
				{
					return false;
				}
				if (monsterAdventureActor3.monsterInfo.epicType == (HotfixEnum.monsterEpicType)intValue)
				{
					return true;
				}
			}
			return false;
		}
		case HotfixEnum.takeEffect.CHARACTER_JOBCLASS:
		{
			PlayerAdventureActor playerAdventureActor3 = _impactA as PlayerAdventureActor;
			if (playerAdventureActor3 == null)
			{
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return playerAdventureActor3.actorInfo.jobClass == (HotfixEnum.characterJobClass)intValue;
		}
		case HotfixEnum.takeEffect.ROGUELIKE_LEVELSTYLE:
			if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.Mainline || ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.Branchline)
			{
				return false;
			}
			TryParseStringParamToInt(parmas1, out intValue);
			return false;
		case HotfixEnum.takeEffect.CERTAIN_MONSTER_TAG:
		{
			if (!(_impactA is MonsterAdventureActor monsterAdventureActor))
			{
				return false;
			}
			string[] first = parmas1.Split(',');
			List<string> second = new List<string>
			{
				monsterAdventureActor.monsterInfo.Tag1,
				monsterAdventureActor.monsterInfo.Tag2,
				monsterAdventureActor.monsterInfo.Tag3,
				monsterAdventureActor.monsterInfo.Tag4,
				monsterAdventureActor.monsterInfo.Tag5
			};
			return first.Intersect(second).Any();
		}
		case HotfixEnum.takeEffect.TARGET_CONTAIN_TAG:
			if (hitEventInfo == null)
			{
				Debug.LogError("目标包含指定标签类型需要和命中时触发条件配合使用");
				return false;
			}
			return _impactA.CheckTag(parmas1);
		case HotfixEnum.takeEffect.DAMAGE_CONTAIN_TAG:
		{
			if (hitEventInfo == null)
			{
				Debug.LogError("伤害包含指定标签类型需要和命中时触发条件配合使用");
				return false;
			}
			RepeatedField<int> damageTag = hitEventInfo.hitDamageConfig.DamageTag;
			for (int k = 0; k < damageTag.Count; k++)
			{
				if (damageTag.get_Item(k) == CommonHelper.StringToHash(parmas1))
				{
					return true;
				}
			}
			return false;
		}
		case HotfixEnum.takeEffect.DISTANCE_LESSOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return TSVector2.Distance(_impactA.tsTransform.Position, _owner.tsTransform.Position) <= intValue;
		case HotfixEnum.takeEffect.DISTANCE_MOREOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return TSVector2.Distance(_impactA.tsTransform.Position, _owner.tsTransform.Position) >= intValue;
		case HotfixEnum.takeEffect.CERTAIN_FACTION_TYPE:
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return _impactA.actorInfo.factionID == intValue;
		case HotfixEnum.takeEffect.IN_FORWARDAREA:
		{
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			if (_enemyEntityTs == null || _owner == null)
			{
				return false;
			}
			TSVector2 tSVector = _enemyEntityTs.Position - _owner.tsTransform.Position;
			return TSVector2.Dot(tSVector.normalized, _owner.tsTransform.Forward) / tSVector.magnitude >= TSMath.Cos(FP.Deg2Rad * intValue / 2);
		}
		case HotfixEnum.takeEffect.CERTAIN_HITDAMAGEID:
			if (hitEventInfo != null && parmas1.Equals(hitEventInfo.hitDamageConfig.Id.ToString()))
			{
				return true;
			}
			return false;
		case HotfixEnum.takeEffect.HAVE_FRIENDLY_SUMMONS:
		{
			bool result = false;
			foreach (AdventureModuleController.MonsterSummonData monsterSummonInfo in ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos)
			{
				if (monsterSummonInfo.isPlayerSummons && monsterSummonInfo.iAlive)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		case HotfixEnum.takeEffect.SELF_BE_MIANCONTROL:
			if (_owner is PlayerAdventureActor playerAdventureActor5)
			{
				return !playerAdventureActor5.isAssist;
			}
			return false;
		case HotfixEnum.takeEffect.SELF_BE_ASSISTANT:
			if (_owner is PlayerAdventureActor playerAdventureActor4)
			{
				return playerAdventureActor4.isAssist;
			}
			return false;
		case HotfixEnum.takeEffect.CERTAIN_TYPE_ASSISTANT_IN_BATTLE:
		{
			if (string.IsNullOrEmpty(parmas1))
			{
				return false;
			}
			string[] array3 = parmas1.Split(',');
			if (array3 == null || array3.Length == 0)
			{
				return false;
			}
			PlayerAdventureActor firstSlotActor = SceneSingleton<AdventurePlayerController>.Instance.GetFirstSlotActor();
			if (firstSlotActor != null && firstSlotActor.actived && array3.Contains(((int)firstSlotActor.actorElementInfo.elementType).ToString()))
			{
				return true;
			}
			PlayerAdventureActor secondSlotActor = SceneSingleton<AdventurePlayerController>.Instance.GetSecondSlotActor();
			if (secondSlotActor != null && secondSlotActor.actived && array3.Contains(((int)secondSlotActor.actorElementInfo.elementType).ToString()))
			{
				return true;
			}
			return false;
		}
		case HotfixEnum.takeEffect.CERTAIN_MARK_ELMENT_TYPE:
			if (triggerMarkEventInfo != null)
			{
				if (!TryParseStringParamToInt(parmas1, out intValue))
				{
					return false;
				}
				return triggerMarkEventInfo.triggerElementType == (HotfixEnum.elementType)intValue;
			}
			return false;
		case HotfixEnum.takeEffect.ULTIMATE_ENERGY_MOREOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue, allowEmpty: true))
			{
				return false;
			}
			if (!(_impactA is PlayerAdventureActor playerAdventureActor7))
			{
				return false;
			}
			return playerAdventureActor7.playerSkillCd.GetEnergyPercent() >= intValue;
		case HotfixEnum.takeEffect.SELF_HP_PERCENT_MOREOREQUAL_THAN:
			return _owner.actorHealthInfo.hpPercentage >= _impactA.actorHealthInfo.hpPercentage;
		case HotfixEnum.takeEffect.ULTIMATE_ENERGY_LESSOREQUAL_THAN:
			if (!TryParseStringParamToInt(parmas1, out intValue, allowEmpty: true))
			{
				return false;
			}
			if (!(_impactA is PlayerAdventureActor playerAdventureActor6))
			{
				return false;
			}
			return playerAdventureActor6.playerSkillCd.GetEnergyPercent() <= intValue;
		case HotfixEnum.takeEffect.IS_TOUGHNESS_BROKEN:
			if (!(_impactA is MonsterAdventureActor monsterAdventureActor4))
			{
				return false;
			}
			if (monsterAdventureActor4.monsterToughnessInfo == null)
			{
				return false;
			}
			return monsterAdventureActor4.monsterToughnessInfo.isToughnessBroken;
		case HotfixEnum.takeEffect.DAMAGE_NOT_NORMAL:
			if (hitEventInfo == null)
			{
				Debug.LogError("指定攻击类型 需要和攻击相关触发条件配合使用");
				return false;
			}
			return hitEventInfo.hitDamageConfig.SkillSlotType != 5;
		case HotfixEnum.takeEffect.WEAKELEMENTTYPE:
		{
			MonsterAdventureActor monsterAdventureActor2 = _impactA as MonsterAdventureActor;
			if (monsterAdventureActor2 == null)
			{
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return monsterAdventureActor2.actorElementInfo.weakElementType.Contains((HotfixEnum.elementType)intValue);
		}
		case HotfixEnum.takeEffect.CERTAIN_MARK_TYPE:
			if (triggerMarkEventInfo != null)
			{
				if (!TryParseStringParamToInt(parmas1, out intValue))
				{
					return false;
				}
				int markTag = triggerMarkEventInfo.markTag;
				HotfixEnum.ElementMarkType elementMarkType = (HotfixEnum.ElementMarkType)intValue;
				return markTag == CommonHelper.StringToHash(elementMarkType.ToString());
			}
			return false;
		case HotfixEnum.takeEffect.BE_MIANCONTROL:
			if (_impactA is PlayerAdventureActor playerAdventureActor2)
			{
				return !playerAdventureActor2.isAssist;
			}
			return false;
		case HotfixEnum.takeEffect.BE_ASSISTANT:
			if (_impactA is PlayerAdventureActor playerAdventureActor)
			{
				return playerAdventureActor.isAssist;
			}
			return false;
		case HotfixEnum.takeEffect.CERTAIN_DAMAGETYPE:
			if (hitEventInfo == null)
			{
				Debug.LogError("指定伤害类型 需要和攻击相关触发条件配合使用");
				return false;
			}
			if (!TryParseStringParamToInt(parmas1, out intValue))
			{
				return false;
			}
			return intValue == hitEventInfo.hitDamageConfig.DamageType;
		case HotfixEnum.takeEffect.ASSISTANT_IN_BATTLE:
		{
			PlayerAdventureActor firstSlotActor = SceneSingleton<AdventurePlayerController>.Instance.GetFirstSlotActor();
			if (firstSlotActor != null && firstSlotActor.actived)
			{
				return true;
			}
			PlayerAdventureActor secondSlotActor = SceneSingleton<AdventurePlayerController>.Instance.GetSecondSlotActor();
			if (secondSlotActor != null)
			{
				return secondSlotActor.actived;
			}
			return false;
		}
		default:
			throw new ArgumentOutOfRangeException("_condition", _condition, null);
		}
	}

	public void Execute(AdventureEffectBase eff)
	{
		if (MaxCD > 0)
		{
			_cd = MaxCD;
			if (_cdCoroutine != null)
			{
				_owner.StopLogicCoroutine(_cdCoroutine);
			}
			_cdCoroutine = _owner.StartLogicCoroutine(cdHandler());
		}
		AdventureActorEffectExecute adventureActorEffectExecute = AdventureActorEffectExecute.Generate();
		adventureActorEffectExecute.sender = _owner;
		adventureActorEffectExecute.effectId = effectConfig.Id;
		adventureActorEffectExecute.effectTag = effectValueConfig.Tag;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEffectExecute);
		if (_takeEffectLimit > 0)
		{
			_takeEffectLimit--;
			MonoSingleton<LuaManager>.Instance?.FireEvent("takeEffect", _owner.dataID, effectConfig.Id);
			if (shareTakeEffectLimit)
			{
				AdventureActorShareTakeEffectLimit adventureActorShareTakeEffectLimit = AdventureActorShareTakeEffectLimit.Generate();
				adventureActorShareTakeEffectLimit.sender = _owner;
				adventureActorShareTakeEffectLimit.effectId = effectConfig.Id;
				adventureActorShareTakeEffectLimit.ownerId = ownerId;
				adventureActorShareTakeEffectLimit.limit = _takeEffectLimit;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorShareTakeEffectLimit);
			}
		}
		_effectStack.Push(eff);
		eff.InitParams();
		eff.AddListenerer();
		eff.Execute();
	}

	public void PostExecute()
	{
		AdventureEffectBase adventureEffectBase = default;
		if (!_effectStack.TryPop(ref adventureEffectBase))
		{
			return;
		}
		enemyEntity = null;
		_enemyEntityTs = null;
		AdventureActorEffectPostExecute adventureActorEffectPostExecute = AdventureActorEffectPostExecute.Generate();
		if (adventureActorEffectPostExecute != null)
		{
			adventureActorEffectPostExecute.sender = _owner;
			adventureActorEffectPostExecute.effectId = effectConfig.Id;
			adventureActorEffectPostExecute.effectTag = effectValueConfig.Tag;
			if (ModuleController<AdventureModuleController>.Instance != null)
			{
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEffectPostExecute);
			}
		}
		adventureEffectBase.PostExecute();
		adventureEffectBase.RemoveListener();
		adventureEffectBase.OnClear();
	}

	public void Clear()
	{
		while (_effectStack.Count > 0)
		{
			AdventureEffectBase adventureEffectBase = _effectStack.Pop();
			adventureEffectBase.PostExecute();
			adventureEffectBase.RemoveListener();
			adventureEffectBase.OnClear();
		}
		if (_cdCoroutine != null)
		{
			_owner.StopLogicCoroutine(_cdCoroutine);
			_cdCoroutine = null;
		}
		_impactActors?.Clear();
	}

	public void OnDestory()
	{
		effectConfig = null;
		_fromActor = null;
		enemyEntity = null;
		_enemyEntityTs = null;
		_impactActors = null;
		_owner = null;
		_fromBuffEntity = null;
	}

	private IEnumerator cdHandler()
	{
		while (_cd > 0)
		{
			_cd -= _owner.LogicDeltaTime;
			if (shareCD)
			{
				AdventureActorShareEffectCd adventureActorShareEffectCd = AdventureActorShareEffectCd.Generate();
				adventureActorShareEffectCd.sender = _owner;
				adventureActorShareEffectCd.effectId = effectConfig.Id;
				adventureActorShareEffectCd.ownerId = ownerId;
				adventureActorShareEffectCd.cd = _cd;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorShareEffectCd);
			}
			yield return null;
		}
	}

	public bool TryParseStringParamToInt(string value, out int intValue, bool allowEmpty = false)
	{
		intValue = 0;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToInt(value, out intValue))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	public bool TryParseStringParamToFloat(string value, out float floatValue, bool allowEmpty = false)
	{
		floatValue = 0f;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToFloat(value, out floatValue))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	public bool TryParseStringParamToFDP(string value, out FDP floatValue, bool allowEmpty = false)
	{
		floatValue = FDP.Zero;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToFDP(value, out floatValue))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	public bool TryParseStringParamToFP(string value, out FP fpValue, bool allowEmpty = false)
	{
		fpValue = FP.Zero;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToFP(value, out fpValue))
		{
			Debug.LogError($"effect param convert error，effect id:{effectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	protected int GetNearbyActorCount(AdventureActor actor, FP radius)
	{
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, actor.tsTransform.Position, list, 256);
		int num = 0;
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.subType != HotfixEnum.monsterSubType.Trap && (monsterAdventureActor.monsterSummonInfo.SummonActor == null || monsterAdventureActor.monsterSummonInfo.SummonActor is MonsterAdventureActor))
			{
				num++;
			}
		}
		return num;
	}

	public bool CheckExecuteEffectInfoIsEqual(int effectId, string effectTag)
	{
		AdventureEffectBase adventureEffectBase = default;
		if (_effectStack.TryPeek(ref adventureEffectBase))
		{
			return false;
		}
		if (adventureEffectBase != null && adventureEffectBase.executeEffectInfo != null)
		{
			return adventureEffectBase.executeEffectInfo.IsEqual(effectId, effectTag);
		}
		return false;
	}
}
