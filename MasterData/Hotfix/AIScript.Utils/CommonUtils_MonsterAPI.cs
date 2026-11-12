using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public static class CommonUtils_MonsterAPI
{
	public static DeterministicShape GetShapeData(DeterministicShape.ShapeType shapeT = DeterministicShape.ShapeType.Circle, TSVector2 position = default(TSVector2), FP width = default(FP), FP length = default(FP), FP radius = default(FP), FP innerRadius = default(FP), FP angle = default(FP), FP rotation = default(FP))
	{
		return new DeterministicShape
		{
			shapeType = shapeT,
			position = position,
			width = width,
			length = length,
			radius = radius,
			innerRadius = innerRadius,
			angle = angle,
			rotation = rotation
		};
	}

	public static void AddBuffToTarget(LogicEntity target, int buffID, AdventureActor from)
	{
		BuffCom buffCom = target?.GetComponent<BuffCom>();
		if (buffCom != null)
		{
			buffCom.AddBuff(buffID, from);
		}
	}

	public static void AddBuffNumToTarget(LogicEntity target, int buffID, AdventureActor from, int num)
	{
		BuffCom buffCom = target?.GetComponent<BuffCom>();
		if (buffCom != null)
		{
			buffCom.AddBuffNum(buffID, num, from);
		}
	}

	public static List<BuffEntity> GetBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		BuffCom buffCom = (target as AdventureActor)?.buffComponent;
		if (buffCom != null)
		{
			return buffCom.GetBuff(buffID, buffGroupID, buffTag);
		}
		return null;
	}

	public static void AddShieldToTarget(LogicEntity target, int shieldId, AdventureActor from)
	{
		ActorShield actorShield = target?.GetComponent<ActorShield>();
		if (actorShield != null)
		{
			actorShield.AddShield(shieldId, from);
		}
	}

	public static void RemoveBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		BuffCom buffCom = target?.GetComponent<BuffCom>();
		if (buffCom != null)
		{
			buffCom.RemoveBuffByBuffId(buffID);
			buffCom.RemoveBuffByGroupId(buffGroupID);
			buffCom.RemoveBuffByTag(buffTag);
		}
	}

	public static void RemoveBuffByNumFromTarget(LogicEntity target, int buffID, int removeNum)
	{
		if (removeNum > 0)
		{
			BuffCom buffCom = target?.GetComponent<BuffCom>();
			if (!(buffCom == null))
			{
				buffCom.RemoveBuffByBuffId(buffID, removeNum);
			}
		}
	}

	public static int GetBuffNum(LogicEntity target, int buffID)
	{
		BuffCom buffCom = target?.GetComponent<BuffCom>();
		if (buffCom != null)
		{
			return buffCom.GetBuffNumByID(buffID);
		}
		return 0;
	}

	public static List<LogicEntity> GetTargetByBuffID(int BuffID, List<LogicEntity> entities = null)
	{
		if (entities == null)
		{
			entities = ModuleController<AdventureModuleController>.Instance.monsterActors;
		}
		List<LogicEntity> searchData = ILRuntimeAPI.GetSearchData();
		if (entities != null && entities.Count > 0)
		{
			for (int i = 0; i < entities.Count; i++)
			{
				if (entities.get_Item(i).GetComponent<BuffCom>().CheckBuffByBuffID(BuffID))
				{
					searchData.Add(entities.get_Item(i));
				}
			}
		}
		return searchData;
	}

	public static void KillActors(List<LogicEntity> entities)
	{
		if (entities != null && entities.Count > 0)
		{
			for (int i = 0; i < entities.Count; i++)
			{
				(entities.get_Item(i) as AdventureActor)?.DestroySelf();
			}
		}
	}

	public static void ClearActors(List<LogicEntity> entities)
	{
		if (entities != null && entities.Count > 0)
		{
			for (int i = 0; i < entities.Count; i++)
			{
				(entities.get_Item(i) as AdventureActor)?.ClearMonsterSelf();
			}
		}
	}

	public static void SetSuperArmorEnable(AdventureActor actor)
	{
		actor?.EnableSuperArmor();
	}

	public static void SetSuperArmorDisable(AdventureActor actor)
	{
		actor?.DisableSuperArmor();
	}

	public static void InterruptSuperArmor(AdventureActor actor)
	{
		actor?.InterruptSuperArmor();
	}

	public static void SetImmuneControlEnable(AdventureActor actor)
	{
		actor?.EnableImmuneControl();
	}

	public static void SetImmuneControlDisable(AdventureActor actor)
	{
		actor?.DisableImmuneControl();
	}

	public static void InterruptImmuneControl(AdventureActor actor)
	{
		actor?.InterruptImmuneControl();
	}

	public static void SetInvincibleEnable(AdventureActor actor)
	{
		actor?.EnableInvincible();
	}

	public static void SetInvincibleDisable(AdventureActor actor)
	{
		actor?.DisableInvincible();
	}

	public static void InterruptInvincible(AdventureActor actor)
	{
		actor?.InterruptInvincible();
	}

	public static void SetSearchedImmunityEnable(AdventureActor actor)
	{
		actor?.EnableSearchedImmunity();
	}

	public static void SetSearchedImmunityDisable(AdventureActor actor)
	{
		actor?.DisableSearchedImmunity();
	}

	public static void InterruptSearchedImmunity(AdventureActor actor)
	{
		actor?.InterruptSearchedImmunity();
	}

	public static void SetCloseBlockEnable(AdventureActor actor)
	{
		actor?.EnableCloseBlock();
	}

	public static void SetCloseBlockDisable(AdventureActor actor)
	{
		actor?.DisableCloseBlock();
	}

	public static void InterruptCloseBlock(AdventureActor actor)
	{
		actor?.InterruptCloseBlock();
	}

	public static void SetHideModelEnable(AdventureActor actor)
	{
		actor?.EnableHideModel();
	}

	public static void SetHideModelDisable(AdventureActor actor)
	{
		actor?.DisableHideModel();
	}

	public static void InterruptHideModel(AdventureActor actor)
	{
		actor?.InterruptHideModel();
	}

	public static void SetSneakEnable(AdventureActor actor)
	{
		actor?.EnableSneak();
	}

	public static void SetSneakDisable(AdventureActor actor)
	{
		actor?.DisableSneak();
	}

	public static void InterruptSneak(AdventureActor actor)
	{
		actor?.InterruptSneak();
	}

	public static void SetHideOutEnable(AdventureActor actor)
	{
		actor?.EnableHideOut();
	}

	public static void SetHideOutDisable(AdventureActor actor)
	{
		actor?.DisableHideOut();
	}

	public static void InterruptHideOut(AdventureActor actor)
	{
		actor?.InterruptHideOut();
	}

	public static void SetBattleOutEnable(AdventureActor actor)
	{
		actor?.EnableImmuneControl();
		actor?.EnableBattleOut();
	}

	public static void SetBattleOutDisable(AdventureActor actor)
	{
		actor?.DisableImmuneControl();
		actor?.DisableBattleOut();
	}

	public static void InterruptBattleOut(AdventureActor actor)
	{
		actor?.InterruptImmuneControl();
		actor?.InterruptBattleOut();
	}

	public static void SetUnparalleledEnable(AdventureActor actor)
	{
		actor?.EnableUnparalleled();
	}

	public static void SetUnparalleledDisable(AdventureActor actor)
	{
		actor?.DisableUnparalleled();
	}

	public static void InterruptUnparalleled(AdventureActor actor)
	{
		actor?.InterruptUnparalleled();
	}

	public static void SetLockHpAbsEnable(AdventureActor actor, int hp)
	{
		actor?.LockHpAbs(hp);
	}

	public static void SetLockHpPercentEnable(AdventureActor actor, FP percent)
	{
		actor?.LockHpPercent(percent);
	}

	public static void SetLockHpDisable(AdventureActor actor)
	{
		actor?.UnlockHp();
	}

	public static void SetCanPerfectDodgeEnable(AdventureActor actor)
	{
		actor?.SetForbidenPerfectDodge(forbidden: false);
	}

	public static void SetCanPerfectDodgeDisable(AdventureActor actor)
	{
		actor?.SetForbidenPerfectDodge(forbidden: true);
	}

	public static void SetLockToughnessState(MonsterAdventureActor actor, bool iEnable)
	{
		if (!(actor == null))
		{
			actor.monsterToughnessInfo.lockToughness = iEnable;
		}
	}

	public static List<LogicEntity> GetTargetsFromShape(AdventureActor actor, DeterministicShape shape, List<LogicEntity> entities = null, bool includeSelf = false, LogicEntity targetEntity = null)
	{
		List<LogicEntity> targetsFromShape = ILRuntimeAPI.GetTargetsFromShape(shape, entities);
		CommonHelper.SearchEntityAlive(targetsFromShape);
		for (int num = targetsFromShape.Count - 1; num >= 0; num--)
		{
			if (!includeSelf && targetsFromShape.get_Item(num).Id == actor.Id)
			{
				targetsFromShape.RemoveAt(num);
			}
			else if (targetEntity != null && targetsFromShape.get_Item(num).Id != targetEntity.Id)
			{
				targetsFromShape.RemoveAt(num);
			}
		}
		return targetsFromShape;
	}

	public static LogicEntity GetTargetNearOrFar(AdventureActor actor, bool iNear, List<LogicEntity> entities)
	{
		return ILRuntimeAPI.GetTargetNearOrFar(actor, iNear, entities);
	}

	public static List<LogicEntity> GetTargetsByFaction(AdventureActor actor, bool isFriend)
	{
		if (isFriend)
		{
			return ILRuntimeAPI.SearchAllFriendActors(actor);
		}
		return ILRuntimeAPI.SearchAllConfrontActors(actor);
	}

	public static LogicEntity GetTargetHp(bool hpMin, List<LogicEntity> entities, bool isAbs)
	{
		return ILRuntimeAPI.GetTargetHp(hpMin, entities, isAbs);
	}

	public static List<LogicEntity> GetTargetByDataIDs(List<int> dataIDs, List<LogicEntity> entities = null)
	{
		if (entities == null)
		{
			entities = ModuleController<AdventureModuleController>.Instance.monsterActors;
		}
		List<LogicEntity> searchData = ILRuntimeAPI.GetSearchData();
		if (dataIDs != null && dataIDs.Count > 0 && entities != null && entities.Count > 0)
		{
			for (int i = 0; i < entities.Count; i++)
			{
				AdventureActor adventureActor = entities.get_Item(i) as AdventureActor;
				if (adventureActor != null && dataIDs.Contains(adventureActor.dataID))
				{
					searchData.Add(entities.get_Item(i));
				}
			}
			CommonHelper.SearchEntityAlive(searchData);
		}
		return searchData;
	}

	public static List<LogicEntity> GetTargetByDataID(int dataID, List<LogicEntity> entities = null)
	{
		if (entities == null)
		{
			entities = ModuleController<AdventureModuleController>.Instance.monsterActors;
		}
		List<LogicEntity> searchData = ILRuntimeAPI.GetSearchData();
		if (entities != null && entities.Count > 0)
		{
			for (int i = 0; i < entities.Count; i++)
			{
				AdventureActor adventureActor = entities.get_Item(i) as AdventureActor;
				if (adventureActor != null && adventureActor.dataID == dataID)
				{
					searchData.Add(entities.get_Item(i));
				}
			}
			CommonHelper.SearchEntityAlive(searchData);
		}
		return searchData;
	}

	public static LogicEntity GetTargetByID(long id, List<LogicEntity> entities = null)
	{
		if (entities == null)
		{
			entities = new List<LogicEntity>();
			entities.AddRange(ModuleController<AdventureModuleController>.Instance.monsterActors);
		}
		if (entities.Count > 0)
		{
			CommonHelper.SearchEntityAlive(entities);
			for (int i = 0; i < entities.Count; i++)
			{
				if (entities.get_Item(i).Id == id)
				{
					return entities.get_Item(i);
				}
			}
		}
		return null;
	}

	public static List<LogicEntity> GetTargetByLogicTag(LogicTagType logicType, string logicStr, List<LogicEntity> entities = null, bool value1 = false, FP value2 = default(FP), string value3 = null, TSVector2 value4 = default(TSVector2))
	{
		if (entities == null)
		{
			entities = ILRuntimeAPI.GetSearchData();
			entities.AddRange(ModuleController<AdventureModuleController>.Instance.monsterActors);
		}
		if (entities.Count > 0)
		{
			CommonHelper.SearchEntityAlive(entities);
			if (entities.Count <= 0)
			{
				return entities;
			}
			for (int num = entities.Count - 1; num >= 0; num--)
			{
				switch (logicType)
				{
				case LogicTagType._Bool:
					if ((entities.get_Item(num) as AdventureActor).logicVariable.GetLogicTagToggle(logicStr) != value1)
					{
						entities.RemoveAt(num);
					}
					break;
				case LogicTagType._Fp:
					if ((entities.get_Item(num) as AdventureActor).logicVariable.GetLogicTagValue(logicStr) != value2)
					{
						entities.RemoveAt(num);
					}
					break;
				case LogicTagType._String:
					if ((entities.get_Item(num) as AdventureActor).logicVariable.GetLogicTagStringValue(logicStr) != value3)
					{
						entities.RemoveAt(num);
					}
					break;
				case LogicTagType._TSVector2:
					if ((entities.get_Item(num) as AdventureActor).logicVariable.GetLogicTagTSVector2Value(logicStr) != value4)
					{
						entities.RemoveAt(num);
					}
					break;
				}
			}
		}
		return entities;
	}

	public static LogicEntity GetAttackTarget(AdventureActor actor, bool isUpToDate = false)
	{
		if (isUpToDate)
		{
			actor.monsterTarget = actor.actorSearchTargetInfo.GetMonsterAttackTarget();
		}
		return actor.monsterTarget;
	}

	public static LogicEntity GetAttackTargetWithOwnerTauntFrom(long ownerId)
	{
		AdventureActor adventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(ownerId) as AdventureActor;
		if (adventureActor != null)
		{
			return adventureActor.monsterTarget;
		}
		return null;
	}

	public static bool IsAttackTargetInArea(AdventureActor actor, DeterministicShape shape)
	{
		if (actor.monsterTarget == null)
		{
			return false;
		}
		return GetTargetsFromShape(actor, shape, null, includeSelf: false, actor.monsterTarget).Count > 0;
	}

	public static long GetTargetID(LogicEntity actor = null)
	{
		if (actor == null)
		{
			return 0L;
		}
		return actor.Id;
	}

	public static TSVector2 GetEntityPosition(LogicEntity entity)
	{
		if (entity == null)
		{
			return TSVector2.zero;
		}
		if (entity is AdventureSkill adventureSkill)
		{
			if (!(adventureSkill.actor != null))
			{
				return TSVector2.zero;
			}
			return adventureSkill.actor.tsTransform.Position;
		}
		return entity.tsTransform.Position;
	}

	public static TSVector2 GetEntityPosition(LogicEntity entity, LogicEntity self)
	{
		if (entity == null)
		{
			if (!(self != null))
			{
				return TSVector2.zero;
			}
			return self.tsTransform.Position;
		}
		if (entity is AdventureSkill adventureSkill)
		{
			if (!(adventureSkill.actor != null))
			{
				return TSVector2.zero;
			}
			return adventureSkill.actor.tsTransform.Position;
		}
		return entity.tsTransform.Position;
	}

	public static TSVector2 GetEntityForward(LogicEntity entity)
	{
		if (entity == null)
		{
			return TSVector2.up;
		}
		if (entity is AdventureSkill)
		{
			return ((AdventureSkill)entity).actor.tsTransform.Forward;
		}
		return entity.tsTransform.Forward;
	}

	public static bool EntityInSkill(LogicEntity entity, int skillId = 0)
	{
		if (entity is AdventureActor adventureActor)
		{
			if (adventureActor.actorSkillManage == null)
			{
				return false;
			}
			if (skillId <= 0)
			{
				return adventureActor.actorSkillManage.HaveRunningSkill();
			}
			return adventureActor.actorSkillManage.HaveSkill(skillId);
		}
		return false;
	}

	public static FP GetEntityAngle(LogicEntity entity)
	{
		if (entity == null)
		{
			return FP.Zero;
		}
		if (entity is AdventureSkill)
		{
			return ((AdventureSkill)entity).actor.tsTransform.Rotation;
		}
		return entity.tsTransform.Rotation;
	}

	public static FP GetRotSpdInSkill(AdventureActor actor)
	{
		return actor.actorInfo.skillRotationSpeed;
	}

	public static TSVector2 GetPosition(AdventureActor actor)
	{
		return actor.tsTransform.Position;
	}

	public static TSVector2 GetForward(AdventureActor actor)
	{
		return actor.tsTransform.Forward;
	}

	public static FP GetRotation(AdventureActor actor)
	{
		return actor.tsTransform.Rotation;
	}

	public static LogicEntity GetCurrentPlayer()
	{
		return SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
	}

	public static int GetMonsterSummonNum(LogicEntity actor, int monsterID = -1, bool iAlive = true)
	{
		if (actor == null)
		{
			return 0;
		}
		return ModuleController<AdventureModuleController>.Instance.GetMonsterSummonNum(actor.Id, monsterID, iAlive);
	}

	public static bool CheckTargetIsValid(LogicEntity target)
	{
		if (target == null)
		{
			return false;
		}
		if (!(target as AdventureActor).actorHealthInfo.isAlive)
		{
			return false;
		}
		return !(target as AdventureActor).searchedImmunity;
	}

	public static bool AreaCheckObstacle(DeterministicShape shape, bool checkHeight = false, HeightClass heightClass = HeightClass.Medium)
	{
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(list, shape, 4096);
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity is AdventureObstacle adventureObstacle)
			{
				if (checkHeight)
				{
					return adventureObstacle.heightClass == heightClass;
				}
				return true;
			}
		}
		return false;
	}

	public static FP Distance(TSVector2 value1, TSVector2 value2)
	{
		return TSVector2.Distance(value1, value2);
	}

	public static TSVector2 GetTSVector2(FP x, FP y)
	{
		return new TSVector2(x, y);
	}

	public static FP GetTSVectToAngle(TSVector2 value, FP angle)
	{
		return (value.GetAngle() + angle) % 360;
	}

	public static TSVector2 TransLocalPosToWorldPos(TSVector2 csOrigin, TSVector2 csForward, TSVector2 relativePoint)
	{
		return ILRuntimeAPI.TransLocalPosToWorldPosByPos(csOrigin, csForward, relativePoint);
	}

	public static TSVector2 RotateTo(TSVector2 from, FP angle)
	{
		return TSVector2.Rotate(from, angle);
	}

	public static FP CalcAngleBetweenSelfAndAttackTarget(AdventureActor actor, bool isSingleAngle = false)
	{
		if (actor.monsterTarget == null)
		{
			return 0;
		}
		return ILRuntimeAPI.CalcAngleBetweenSelfAndAttackTarget(actor, isSingleAngle);
	}

	public static FP AngleBetween2TSVector(TSVector2 from, TSVector2 to, bool signed)
	{
		if (signed)
		{
			return TSVector2.SignedAngle(from, to);
		}
		return TSVector2.Angle(from, to);
	}

	public static bool GetLogicTagToggleValue(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return false;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return false;
		}
		return adventureActor.logicVariable?.GetLogicTagToggle(tagName) ?? false;
	}

	public static string GetLogicTagStringValue(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return "";
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return string.Empty;
		}
		return adventureActor.logicVariable?.GetLogicTagStringValue(tagName) ?? null;
	}

	public static FP GetLogicTagFpValue(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return 0;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return 0;
		}
		return adventureActor.logicVariable?.GetLogicTagValue(tagName) ?? ((FP)0);
	}

	public static TSVector2 GetLogicTagTSVector2Value(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return TSVector2.zero;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return TSVector2.zero;
		}
		return adventureActor.logicVariable?.GetLogicTagTSVector2Value(tagName) ?? TSVector2.zero;
	}

	public static void SetLogicTagToggleValue(LogicEntity entity, string tagName, bool value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable?.ToggleLogicTag(tagName, value);
		}
	}

	public static void SetLogicTagStringValue(LogicEntity entity, string tagName, string value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable?.SetLogicTagStringValue(tagName, value);
		}
	}

	public static void SetLogicTagTSVector2Value(LogicEntity entity, string tagName, TSVector2 value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable?.SetLogicTagTSVector2Value(tagName, value);
		}
	}

	public static void SetLogicTagFpValue(LogicEntity entity, string tagName, FP value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable?.SetLogicTagValue(tagName, value);
		}
	}

	public static void SetLogicTagListTSVector2Value(LogicEntity entity, string tagName, List<TSVector2> value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable?.SetLogicTagListTSVector2Value(tagName, value);
		}
	}

	public static void SetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName, Dictionary<int, TSVector2> value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable.SetLogicTagDicIntTSVector2Value(tagName, value);
		}
	}

	public static void SetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName, Dictionary<TSVector2, long> value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable.SetLogicTagDicTSVector2LongValue(tagName, value);
		}
	}

	public static void SetLogicTagListLongValue(LogicEntity entity, string tagName, List<long> value)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !string.IsNullOrEmpty(tagName))
		{
			adventureActor.logicVariable.SetLogicTagListLongValue(tagName, value);
		}
	}

	public static List<TSVector2> GetLogicTagListTSVector2Value(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return null;
		}
		return adventureActor.logicVariable?.GetLogicTagListTSVector2Value(tagName) ?? null;
	}

	public static Dictionary<int, TSVector2> GetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return null;
		}
		return adventureActor.logicVariable?.GetLogicTagDicIntTSVector2Value(tagName) ?? null;
	}

	public static Dictionary<TSVector2, long> GetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return null;
		}
		return adventureActor.logicVariable?.GetLogicTagDicTSVector2LongValue(tagName) ?? null;
	}

	public static List<long> GetLogicTagListLongValue(LogicEntity entity, string tagName)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(tagName))
		{
			return null;
		}
		return adventureActor.logicVariable?.GetLogicTagListLongValue(tagName) ?? null;
	}

	public static int randomWeight(int[] rdmWeights)
	{
		return ILRuntimeAPI.randomWeight(rdmWeights);
	}

	public static FP GetRandomValue(FP minValue, FP maxValue, bool isInt = false)
	{
		if (isInt)
		{
			return (int)(long)TSRandom.Range(minValue, maxValue);
		}
		return TSRandom.Range(minValue, maxValue);
	}

	public static TSVector2 GetShapeRandomPoint(DeterministicShape shape, LogicEntity entity, bool isReachable = false)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return ILRuntimeAPI.GetRandomPointInShape(adventureActor, shape, isReachable: false);
		}
		return ILRuntimeAPI.GetRandomPointInShape(adventureActor, shape, isReachable);
	}

	public static void InterruptSkill(AdventureSkill skill)
	{
		skill?.Clear();
	}

	public static void PlayWwiseSound(AdventureActor actor, string _event, LogicEntity _owner = null)
	{
		if (_owner == null)
		{
			_owner = actor;
		}
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(_event, _owner?.gameObject);
	}

	public static void TriggerOpLisener(string _triggerOpIDN)
	{
		if (!string.IsNullOrEmpty(_triggerOpIDN))
		{
			Singleton<InteractiveManager>.Instance.triggerOpListener(_triggerOpIDN);
		}
	}

	public static bool AreaCheckMonsterTarget(AdventureActor actor, DeterministicShape shape)
	{
		if (actor == null || actor.monsterTarget == null)
		{
			return false;
		}
		return shape.shapeType switch
		{
			DeterministicShape.ShapeType.Circle => DeterministicCollisionUtils.TestSimpleOverLap_Circle2Circle(shape.position, shape.radius, shape.innerRadius, actor.monsterTarget.tsTransform.Position, actor.monsterTarget.GetRadius()), 
			DeterministicShape.ShapeType.Rectangle => DeterministicCollisionUtils.TestSimpleOverLap_Rect2Circle(shape.position, shape.rotation, shape.width, shape.length, actor.monsterTarget.tsTransform.Position, actor.monsterTarget.GetRadius()), 
			DeterministicShape.ShapeType.Fan => DeterministicCollisionUtils.TestSimpleOverLap_Fan2Circle(shape.position, shape.rotation, shape.angle, shape.radius, shape.innerRadius, actor.monsterTarget.tsTransform.Position, actor.monsterTarget.GetRadius()), 
			_ => false, 
		};
	}

	public static FP GetDistanceWithTarget(AdventureActor actor, bool calcDistanceWithoutEntityRadius)
	{
		if (actor == null || actor.monsterTarget == null)
		{
			return 0;
		}
		return ILRuntimeAPI.CalcDistanceBetweenTwoActor(actor, (AdventureActor)actor.monsterTarget, calcDistanceWithoutEntityRadius);
	}

	public static TSVector2 GetAreaEffectPosition(long areaEffectId)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		if (!(areaEffect != null))
		{
			return TSVector2.zero;
		}
		return areaEffect.tsTransform.Position;
	}

	public static TSVector2 GetAreaEffectForward(long areaEffectId)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		if (!(areaEffect != null))
		{
			return TSVector2.zero;
		}
		return areaEffect.tsTransform.Forward;
	}

	public static void SetBlockPriorityToStatic(AdventureActor actor)
	{
		actor?.SetBlockPriorityToStatic();
	}

	public static void ResetBlockPriority(AdventureActor actor)
	{
		actor?.ResetBlockPriority();
	}

	public static void SwitchStateWithDurationTime(AdventureActor actor, bool breakCurrentAction, bool breakForceControl, int lastStateIndex, int nextStateIndex, FP durationTime)
	{
		AdventureMonsterSwitchDurationStateEvent adventureMonsterSwitchDurationStateEvent = AdventureMonsterSwitchDurationStateEvent.Generate();
		adventureMonsterSwitchDurationStateEvent.sender = actor;
		adventureMonsterSwitchDurationStateEvent.breakCurrentAction = breakCurrentAction;
		adventureMonsterSwitchDurationStateEvent.breakForceControl = breakForceControl;
		adventureMonsterSwitchDurationStateEvent.lastStateIndex = lastStateIndex;
		adventureMonsterSwitchDurationStateEvent.nextStateIndex = nextStateIndex;
		adventureMonsterSwitchDurationStateEvent.durationTime = durationTime;
		actor?.DispatchEvent(adventureMonsterSwitchDurationStateEvent);
	}

	public static TSVector2 GetPlaceHolderPosition(string name)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPlaceHolderPosition(name);
	}

	public static void SummonTeammate(MonsterAdventureActor actor, int index, TSVector2 spawnPosition, TSVector2 spawnDirection, int maxAmount = 0)
	{
		int teammateIdByIndex = GetTeammateIdByIndex(actor, index);
		if (teammateIdByIndex > 0 && (maxAmount == 0 || GetTargetByDataID(teammateIdByIndex).Count < maxAmount))
		{
			ILRuntimeAPI.SummonMonster(actor, 0, teammateIdByIndex, spawnPosition, spawnDirection);
		}
	}

	public static int GetTeammateIdByIndex(MonsterAdventureActor actor, int index)
	{
		int result = 0;
		if (actor != null)
		{
			result = CommonHelper.GetMonsterTeammateId(actor.monsterInfo.teamId, index);
		}
		return result;
	}
}
