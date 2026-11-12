#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using AIScript.DynamicLevel;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Utils;

public static class CommonUtils
{
	private static List<LogicEntity> _searchResult = new List<LogicEntity>();

	private static List<DeterministicCollider> _deterministicColliders = new List<DeterministicCollider>();

	public static void SearchNearTargetsByCircleInTD(AdventureActor _actor, TSVector2 center, FP range, List<LogicEntity> entities, bool isConfront = false, bool onlyAlive = true, bool includeSelf = false, Predicate<LogicEntity> customFilter = null)
	{
		entities.Clear();
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.searchables.Count; i++)
		{
			Searchable searchable = ModuleController<AdventureModuleController>.Instance.searchables.get_Item(i);
			if (searchable != null && !(searchable.entity == null) && !(searchable.entity is TrapAdventureActor) && !(searchable.entity is DestructibleStateSingle) && !(searchable.entity is TowerDefenseCharacterActor { IsActive: false }) && (includeSelf || !(searchable.entity == _actor)) && (!onlyAlive || CommonHelper.IsEntityAlive(searchable.entity)) && (!isConfront || _actor.IsEntityConfrontAndSearchable(searchable.entity)) && (customFilter == null || customFilter(searchable.entity)))
			{
				FP radius = searchable.entity.GetRadius();
				if (!(TSVector2.Distance(center, searchable.entity.tsTransform.Position) - radius > range))
				{
					entities.Add(searchable.entity);
				}
			}
		}
		_actor.SearchEntitySortByDistance(entities);
		if (isConfront || entities.Count <= 0)
		{
			return;
		}
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			if (!entities.get_Item(num).IsFriendlyWith(_actor))
			{
				entities.RemoveAt(num);
			}
		}
	}

	public static List<LogicEntity> GetTargetsByFactionByTD(AdventureActor actor, bool isFriend)
	{
		_searchResult.Clear();
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.dynamicActors;
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (dynamicActors != null && dynamicActors.Count > 0)
		{
			_searchResult.AddRange(dynamicActors);
		}
		if (monsterActors != null && monsterActors.Count > 0)
		{
			_searchResult.AddRange(monsterActors);
		}
		if (isFriend)
		{
			ILRuntimeAPI.SearchActorFriend(actor, _searchResult);
		}
		else
		{
			ILRuntimeAPI.SearchActorConfront(actor, _searchResult);
		}
		return _searchResult;
	}

	public static void SummonMonster(AdventureActor actor, int groupId, int monsterId, TSVector2 pos, TSVector2 dir, SummonCfg cfg = null, string summonGroupSuffix = null, Action<MonsterAdventureActor> finishCallback = null)
	{
		if (actor is TowerDefenseCharacterActor || (!ModuleController<AdventureModuleController>.Instance.isMonsterCleared && ModuleController<AdventureModuleController>.Instance.adventureLevelState != AdventureLevelState.BattleEnd))
		{
			Spawn(isStarTower: false);
		}
		void Spawn(bool isStarTower)
		{
			ActorSpawnInfo spawnInfo = new ActorSpawnInfo(monsterId)
			{
				position = pos,
				positionY = actor.tsTransform.PositionY,
				rotation = dir.GetAngle(),
				summoner = actor,
				summonGroupSuffix = summonGroupSuffix,
				isRoguelikeMonster = isStarTower,
				callbackImmediately = true,
				monsterLevel = 1
			};
			if (cfg != null && cfg.maxCount > 0)
			{
				spawnInfo.maxCout = cfg.maxCount;
			}
			if (actor is MonsterAdventureActor)
			{
				MonsterSpawnerInfo logicComponent = actor.GetLogicComponent<MonsterSpawnerInfo>();
				spawnInfo.monsterLevel = logicComponent.level;
			}
			ModuleController<AdventureModuleController>.Instance.SpawnMonster(spawnInfo, (AdventureLevelObjPoolMgr.PoolObj obj, bool isRoguelikeMonster) =>
			{
				if (obj != null)
				{
					MonsterAdventureActor component = obj.gameObject.GetComponent<MonsterAdventureActor>();
					if (!(null == component))
					{
						if (!isRoguelikeMonster)
						{
							AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
							adventureMonsterSpawnedEvent.sender = component;
							adventureMonsterSpawnedEvent.id = component.Id;
							adventureMonsterSpawnedEvent.dataID = component.dataID;
							ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
						}
						AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = AdventureMonsterSummonerSpawnedEvent.Generate();
						adventureMonsterSummonerSpawnedEvent.sender = component;
						adventureMonsterSummonerSpawnedEvent.id = component.Id;
						adventureMonsterSummonerSpawnedEvent.dataId = component.dataID;
						adventureMonsterSummonerSpawnedEvent.summonerId = component.monsterSummonInfo.SummonActor.Id;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSummonerSpawnedEvent);
						finishCallback?.Invoke(component);
					}
				}
			}, cfg);
		}
	}

	public static IEnumerator WaitForSeconds(this LogicEntity entity, FP seconds)
	{
		if (seconds <= 0)
		{
			seconds = FP.Epsilon;
		}
		while (seconds > 0)
		{
			seconds -= ((entity != null) ? entity.LogicDeltaTime : LockStepManager.deltaTime);
			yield return null;
		}
	}

	public static CoroutineNode WaitTime(this LogicEntity entity, FP seconds)
	{
		return entity.StartLogicCoroutine(entity.WaitForSeconds(seconds), runImmediately: true);
	}

	public static IEnumerator WaitUntil(this LogicEntity entity, Func<bool> predicate)
	{
		while (!predicate())
		{
			yield return null;
		}
	}

	public static DeterministicShape GetDeterministicFanShape(FP radius, FP innerRadius, FP angle, TSVector2 position, FP rotation)
	{
		return new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			radius = radius,
			innerRadius = innerRadius,
			angle = angle,
			position = position,
			rotation = rotation
		};
	}

	public static DeterministicShape GetDeterministicCircleShape(FP radius, FP innerRadius, TSVector2 position)
	{
		return new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			radius = radius,
			innerRadius = innerRadius,
			position = position
		};
	}

	public static DeterministicShape GetDeterministicRectShape(FP width, FP length, TSVector2 position)
	{
		return new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			width = width,
			length = length,
			position = position
		};
	}

	public static int ParseStringParamToInt(string value)
	{
		return int.Parse(value, CultureInfo.InvariantCulture);
	}

	public static bool TryParseStringParamToInt(string value, out int intValue)
	{
		return int.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out intValue);
	}

	public static float ParseStringParamToFloat(string value)
	{
		return float.Parse(value, CultureInfo.InvariantCulture);
	}

	public static bool TryParseStringParamToFloat(string value, out float floatValue)
	{
		return float.TryParse(value, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out floatValue);
	}

	public static FP ParseStringParamToFP(string value)
	{
		return FP.FromFloat(float.Parse(value, CultureInfo.InvariantCulture));
	}

	public static bool TryParseStringParamToFP(string value, out FP fpValue)
	{
		if (float.TryParse(value, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out var result))
		{
			fpValue = FP.FromFloat(result);
			return true;
		}
		fpValue = FP.Zero;
		return false;
	}

	public static FP GetAttackRange(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.dodgeButtonHold)
			{
				return -1;
			}
			if (playerAdventureActor.isAssist)
			{
				return playerAdventureActor.actorSearchTargetInfo.hearAttackRange;
			}
		}
		return actor.actorSearchTargetInfo.attackRange;
	}

	public static bool HaveTargetAndInAttackRange(AdventureActor actor)
	{
		if (actor.attackTarget == null)
		{
			return false;
		}
		return actor.DistanceWithRadius(actor.attackTarget) <= GetAttackRange(actor);
	}

	public static FP GetAimRange(AdventureActor actor)
	{
		return actor.actorSearchTargetInfo.aimRange;
	}

	public static TSVector2 GetMainControlSkillDirection(AdventureActor actor)
	{
		TSVector2 tSVector = TSVector2.zero;
		if (!ModuleController<AdventureModuleController>.Instance.SemiAutoBattle)
		{
			tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		}
		if (tSVector == TSVector2.zero)
		{
			tSVector = ((!(actor.attackTarget != null)) ? actor.tsTransform.Forward : (actor.attackTarget.tsTransform.Position - actor.tsTransform.Position).normalized);
		}
		return tSVector;
	}

	public static bool CheckHitByTag(IList<int> hitDamageTags, int hitTag)
	{
		return hitDamageTags?.Contains(hitTag) ?? false;
	}

	public static LogicEntity SearchNearTargetByCircle(AdventureActor _actor, FP radius, bool isConfront = true, bool includeSelf = false)
	{
		LogicEntity entity = null;
		ILRuntimeAPI.SearchByRange(_actor, radius, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				entity = result.get_Item(0);
			}
		}, isConfront, onlyAlive: true, includeSelf);
		return entity;
	}

	[Obsolete("废弃使用，禁止函数内部使用new list")]
	public static List<LogicEntity> SearchNearTargetsByCircle(AdventureActor _actor, FP radius, bool isConfront, bool includeSelf)
	{
		List<LogicEntity> entity = new List<LogicEntity>();
		ILRuntimeAPI.SearchByRange(_actor, radius, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				entity = result;
			}
		}, isConfront, onlyAlive: true, includeSelf);
		if (!isConfront && entity.Count > 0)
		{
			for (int num = entity.Count - 1; num >= 0; num--)
			{
				if (!entity.get_Item(num).IsFriendlyWith(_actor))
				{
					entity.RemoveAt(num);
				}
			}
		}
		return entity;
	}

	public static void SearchNearTargetsByCircle(AdventureActor _actor, TSVector2 center, FP radius, bool isConfront, bool includeSelf, List<LogicEntity> entities)
	{
		entities.Clear();
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, center, radius, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				entities.AddRange(result);
			}
		}, isConfront, onlyAlive: true, includeSelf);
		if (isConfront || entities.Count <= 0)
		{
			return;
		}
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			if (!entities.get_Item(num).IsFriendlyWith(_actor))
			{
				entities.RemoveAt(num);
			}
		}
	}

	public static void SearchNearTargetsByCircle(AdventureActor _actor, FP radius, bool isConfront, bool includeSelf, List<LogicEntity> entities)
	{
		entities.Clear();
		ILRuntimeAPI.SearchByRange(_actor, radius, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
			}
			entities.AddRange(result);
		}, isConfront, onlyAlive: true, includeSelf);
		if (isConfront || entities.Count <= 0)
		{
			return;
		}
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			if (!entities.get_Item(num).IsFriendlyWith(_actor))
			{
				entities.RemoveAt(num);
			}
		}
	}

	public static void PlayOneOffFx(AdventureActor actor, string fxAliasOrPath)
	{
		if (!string.IsNullOrEmpty(fxAliasOrPath))
		{
			PlayFX playFX = new PlayFX();
			playFX.Play(actor, null, fxAliasOrPath, actor.tsTransform.PositionY, actor.tsTransform.Position, actor.tsTransform.Forward);
			playFX.Clear();
		}
	}

	public static bool CheckTalentByIndex(PlayerTalentGroupType talentGroupType, int index)
	{
		switch (index)
		{
		case 1:
			if (talentGroupType != PlayerTalentGroupType.Group1 && talentGroupType != PlayerTalentGroupType.Group12 && talentGroupType != PlayerTalentGroupType.Group13)
			{
				return talentGroupType == PlayerTalentGroupType.Group14;
			}
			return true;
		case 2:
			if (talentGroupType != PlayerTalentGroupType.Group2 && talentGroupType != PlayerTalentGroupType.Group12 && talentGroupType != PlayerTalentGroupType.Group23)
			{
				return talentGroupType == PlayerTalentGroupType.Group24;
			}
			return true;
		case 3:
			if (talentGroupType != PlayerTalentGroupType.Group3 && talentGroupType != PlayerTalentGroupType.Group13 && talentGroupType != PlayerTalentGroupType.Group23)
			{
				return talentGroupType == PlayerTalentGroupType.Group34;
			}
			return true;
		case 4:
			if (talentGroupType != PlayerTalentGroupType.Group4 && talentGroupType != PlayerTalentGroupType.Group14 && talentGroupType != PlayerTalentGroupType.Group24)
			{
				return talentGroupType == PlayerTalentGroupType.Group34;
			}
			return true;
		default:
			return false;
		}
	}

	public static TSVector2 RandomReachablePointInsideRing(AdventureActor actor, TSVector2 center, FP innerRadius, FP outerRadius, int maxCheckCount = 30)
	{
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(center, innerRadius, outerRadius);
			if (actor.QueryPositionReachable(tSVector))
			{
				return tSVector;
			}
		}
		return center;
	}

	public static TSVector2 RandomReachablePointInsideRingS(AdventureActor actor, TSVector2 center, FP innerRadius, FP outerRadius, FP rotation, FP range, int maxCheckCount = 30)
	{
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(center, innerRadius, outerRadius, rotation, range);
			if (actor.QueryPositionReachable(tSVector))
			{
				return tSVector;
			}
		}
		return center;
	}

	public static TSVector2 RandomReachablePointInsideFan(AdventureActor actor, TSVector2 center, FP innerRadius, FP outerRadius, FP angleBase, FP angleRange, int maxCheckCount = 30)
	{
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(actor.tsTransform.Position, innerRadius, outerRadius, angleBase, angleRange);
			if (actor.QueryPositionReachable(tSVector))
			{
				return tSVector;
			}
		}
		return center;
	}

	public static TSVector2 RandomWalkablePointInsideRing(AdventureActor actor, TSVector2 center, FP innerRadius, FP outerRadius, int maxCheckCount = 30)
	{
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(center, innerRadius, outerRadius);
			if (actor.QueryPositionWalkable(tSVector))
			{
				return tSVector;
			}
		}
		return center;
	}

	public static LogicEntity GetAssistantAttackTarget(AdventureActor actor, bool useInputDirection = false, bool activeActorTargetFirst = false)
	{
		if (!activeActorTargetFirst)
		{
			LogicEntity logicEntity = actor.attackTarget;
			if (logicEntity == null || !(logicEntity as AdventureActor).actorHealthInfo.isAlive || logicEntity.IsSearchedImmunity())
			{
				logicEntity = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor?.attackTarget;
			}
			if (logicEntity == null)
			{
				logicEntity = actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection);
			}
			return logicEntity;
		}
		LogicEntity logicEntity2 = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor?.attackTarget;
		if (logicEntity2 == null && actor.attackTarget != null && (actor.attackTarget as AdventureActor).actorHealthInfo.isAlive && !actor.attackTarget.IsSearchedImmunity())
		{
			logicEntity2 = actor.attackTarget;
		}
		if (logicEntity2 == null)
		{
			logicEntity2 = actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection);
		}
		return logicEntity2;
	}

	public static FP GetScriptValue(AdventureActor fromActor, int parameterId)
	{
		if (parameterId <= 0)
		{
			NovaLogger.Error($"ScriptParameter Id Error, Id:{parameterId}");
			return 0;
		}
		ScriptParameter scriptParameter = Singleton<HotfixDataController>.Instance.GetScriptParameter(parameterId);
		if (scriptParameter != null)
		{
			int valueConfigIdByLevelType = CommonHelper.GetValueConfigIdByLevelType(fromActor, scriptParameter.Id, (HotfixEnum.levelTypeData)scriptParameter.LevelTypeData, scriptParameter.LevelData);
			ScriptParameterValue scriptParameterValue = Singleton<HotfixDataController>.Instance.GetScriptParameterValue(valueConfigIdByLevelType);
			if (scriptParameterValue != null)
			{
				return FP.FromMyriad(scriptParameterValue.CommonData);
			}
			NovaLogger.Error($"ScriptValue Config Not Exist, Id:{valueConfigIdByLevelType}, ParameterId:{parameterId}");
		}
		else
		{
			NovaLogger.Error($"ScriptParameter Config Not Exist, Id:{parameterId}");
		}
		return 0;
	}

	public static bool CheckElementMark(int markHash, AdventureActor target)
	{
		if (target == null || target.buffComponent == null)
		{
			return false;
		}
		return target.buffComponent.CheckBuffByBuffTag(markHash);
	}

	public static bool CheckTriggerElementMarkCD(AdventureActor actor, AdventureActor target, FP overrideTriggerCD = default(FP))
	{
		if (actor == null || target == null)
		{
			return false;
		}
		return ModuleController<AdventureModuleController>.Instance.CheckTriggerElementMarkCD(actor.dataID, target.Id, overrideTriggerCD);
	}

	public static void TriggerElementMarkEvent(int markHash, HotfixEnum.AdventureActorElementTriggerType markTriggerType, AdventureActor triggerActor, AdventureActor markActor, string tipsKey = "")
	{
		ModuleController<AdventureModuleController>.Instance?.RecordTriggerElementMark(triggerActor.dataID, markActor.Id);
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = AdventureElementMarkTriggerEvent.Generate();
		adventureElementMarkTriggerEvent.elementTag = markHash;
		adventureElementMarkTriggerEvent.triggerActor = triggerActor;
		adventureElementMarkTriggerEvent.markActor = markActor;
		adventureElementMarkTriggerEvent.elementType = ConvertToElementType(markHash);
		adventureElementMarkTriggerEvent.markTriggerType = markTriggerType;
		adventureElementMarkTriggerEvent.tipsKey = tipsKey;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureElementMarkTriggerEvent);
	}

	public static HotfixEnum.elementType ConvertToElementType(int markHash)
	{
		HotfixEnum.elementType result = HotfixEnum.elementType.NONE;
		if (markHash == CommonDefine.Fire || markHash == CommonDefine.FireMark1 || markHash == CommonDefine.FireMark2 || markHash == CommonDefine.FireMark3 || markHash == CommonDefine.FireMark4 || markHash == CommonDefine.FireMark5)
		{
			result = HotfixEnum.elementType.FE;
		}
		else if (markHash == CommonDefine.Water || markHash == CommonDefine.WaterMark1 || markHash == CommonDefine.WaterMark2 || markHash == CommonDefine.WaterMark3 || markHash == CommonDefine.WaterMark4 || markHash == CommonDefine.WaterMark5)
		{
			result = HotfixEnum.elementType.WE;
		}
		else if (markHash == CommonDefine.Wind || markHash == CommonDefine.WindMark1 || markHash == CommonDefine.WindMark2 || markHash == CommonDefine.WindMark3 || markHash == CommonDefine.WindMark4 || markHash == CommonDefine.WindMark5)
		{
			result = HotfixEnum.elementType.AE;
		}
		else if (markHash == CommonDefine.Light || markHash == CommonDefine.LightMark1 || markHash == CommonDefine.LightMark2 || markHash == CommonDefine.LightMark3 || markHash == CommonDefine.LightMark4 || markHash == CommonDefine.LightMark5)
		{
			result = HotfixEnum.elementType.LE;
		}
		else if (markHash == CommonDefine.Dark || markHash == CommonDefine.DarkMark1 || markHash == CommonDefine.DarkMark2 || markHash == CommonDefine.DarkMark3 || markHash == CommonDefine.DarkMark4 || markHash == CommonDefine.DarkMark5)
		{
			result = HotfixEnum.elementType.DE;
		}
		else if (markHash == CommonDefine.Earth || markHash == CommonDefine.EarthMark1 || markHash == CommonDefine.EarthMark2 || markHash == CommonDefine.EarthMark3 || markHash == CommonDefine.EarthMark4 || markHash == CommonDefine.EarthMark5)
		{
			result = HotfixEnum.elementType.SE;
		}
		return result;
	}

	public static bool HavePersonalPerk(int actorDataId, int perkId, out int perkLevel)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(actorDataId, perkId, out perkLevel);
	}

	public static void GetMonsterTarget(AdventureActor monster)
	{
		if (!CheckTargetIsValid(monster.monsterTarget, 0L))
		{
			monster.monsterTarget = monster.actorSearchTargetInfo.GetMonsterAttackTarget();
		}
	}

	public static bool CheckTargetIsValid(LogicEntity target, long targetId = 0L, bool ingoreSearchedImmunity = false)
	{
		if (target == null)
		{
			return false;
		}
		if (targetId != 0L && target.Id != targetId)
		{
			return false;
		}
		if (!(target as AdventureActor).actorHealthInfo.isAlive)
		{
			return false;
		}
		if (ingoreSearchedImmunity)
		{
			return true;
		}
		return !(target as AdventureActor).searchedImmunity;
	}

	public static void EnableCrossObstacleMode(AdventureActor actor)
	{
		actor.EnableDodgeCrossObstacle();
	}

	public static bool CheckAndSetDodgeCrossObstacleMode(AdventureActor actor, FP realDodgeDistance, FP crossDodgeAdditionDistance, FP crossDodgeKeepAwayNavmeshEdgeDistance, bool forceUseForwardDirection = false)
	{
		if (!actor.dodgeCrossObstacle)
		{
			return false;
		}
		TSVector2 position = actor.tsTransform.Position;
		TSVector2 tSVector = actor.tsTransform.Forward;
		if (!forceUseForwardDirection && actor is PlayerAdventureActor)
		{
			tSVector = (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() ? SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() : actor.tsTransform.Forward);
		}
		TSVector2 tSVector2 = position + tSVector * realDodgeDistance;
		if (!actor.LinecastNavmeshGraph(position, tSVector2, out var _, offset: false, actor.tsTransform.PositionY, actor.tsTransform.PositionY))
		{
			return false;
		}
		if (actor.QueryPositionWalkable(tSVector2) && actor.QueryPositionReachable(tSVector2))
		{
			actor.crossObstacleMode = true;
			actor.crossObstacleModeSpeedMultiply = 1;
		}
		else
		{
			TSVector2 tSVector3 = tSVector2 + tSVector * crossDodgeAdditionDistance;
			if (actor.QueryPositionWalkable(tSVector3) && actor.QueryPositionReachable(tSVector3) && actor.LinecastNavmeshGraph(tSVector3, tSVector2, out var linecastHitPoint2, offset: false, actor.tsTransform.PositionY, actor.tsTransform.PositionY))
			{
				FP fP = TSVector2.Distance(linecastHitPoint2, tSVector2);
				FP crossObstacleModeSpeedMultiply = (realDodgeDistance + fP + crossDodgeKeepAwayNavmeshEdgeDistance) / realDodgeDistance;
				actor.crossObstacleMode = true;
				actor.crossObstacleModeSpeedMultiply = crossObstacleModeSpeedMultiply;
			}
		}
		return true;
	}

	public static bool CheckAndSetCrossObstacleMode(AdventureActor actor, FP realMoveDistance, FP crossMoveAdditionDistance, FP crossMoveKeepAwayNavmeshEdgeDistance, bool forceUseForwardDirection = false)
	{
		return CheckAndSetDodgeCrossObstacleMode(actor, realMoveDistance, crossMoveAdditionDistance, crossMoveKeepAwayNavmeshEdgeDistance, forceUseForwardDirection);
	}

	public static void DisableCrossObstacleMode(AdventureActor actor)
	{
		actor.DisableDodgeCrossObstacle();
	}

	public static void ClearDodgeCrossObstacleMode(AdventureActor actor)
	{
		if (actor.crossObstacleMode)
		{
			actor.crossObstacleMode = false;
		}
	}

	public static void ClearCrossObstacleMode(AdventureActor actor)
	{
		ClearDodgeCrossObstacleMode(actor);
	}

	public static void GetAllSummons(List<MonsterAdventureActor> monsters)
	{
		monsters.Clear();
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).isPlayerSummons)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor item)
				{
					monsters.Add(item);
				}
			}
		}
	}

	public static void GetAllSummonsById(List<MonsterAdventureActor> monsters, int monsterId)
	{
		monsters.Clear();
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).dataID == monsterId)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor item)
				{
					monsters.Add(item);
				}
			}
		}
	}

	public static FP GetDurationByAcc(FP acceleration, FP initialVelocity, FP maxVelocity, FP distance)
	{
		FP fP = (maxVelocity - initialVelocity) / acceleration;
		FP fP2 = initialVelocity * fP + 0.5 * acceleration * TSMath.Pow(fP, 2);
		FP fP3 = 0.0;
		if (fP2 > distance)
		{
			FP number = TSMath.Pow(initialVelocity, 2) + 2 * acceleration * distance;
			return (-initialVelocity + TSMath.Sqrt(number)) / acceleration;
		}
		FP fP4 = (distance - fP2) / maxVelocity;
		return fP + fP4;
	}

	public static void ReduceSkillSection(AdventureActor actor, AdventureSkill skill, bool beginResume = true)
	{
		if (actor is PlayerAdventureActor playerAdventureActor && !(skill == null))
		{
			int skillId = skill.skillId;
			SkillInfo skillCD = playerAdventureActor.playerSkillCd.GetSkillCD(skillId);
			if (skillCD != null && skillCD.currentSectionAmount > 0)
			{
				playerAdventureActor.playerSkillCd.ReduceSkillSection(skillId, beginResume);
				playerAdventureActor.playerSkillCd.AddSkillEnergyPool(skillId);
				AdventureActorProactiveReduceSkillSectionEvent adventureActorProactiveReduceSkillSectionEvent = AdventureActorProactiveReduceSkillSectionEvent.Generate();
				adventureActorProactiveReduceSkillSectionEvent.sender = actor;
				SkillEventInfo skillEventInfo = new SkillEventInfo(CommonHelper.GetSkillSlotType(skill.skillCastBehaviourType), skillId);
				adventureActorProactiveReduceSkillSectionEvent.skillEventInfo = skillEventInfo;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorProactiveReduceSkillSectionEvent);
			}
		}
	}

	public static bool CheckAllPlayerActorAreSameElement(HotfixEnum.elementType elementType)
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType != elementType)
			{
				return false;
			}
		}
		return true;
	}

	public static int GetPlayerActorCountByElement(HotfixEnum.elementType elementType)
	{
		int num = 0;
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType == elementType)
			{
				num++;
			}
		}
		return num;
	}
}
