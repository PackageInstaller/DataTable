using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public static class ActorHelper
{
	public static ActorInfo GetFlowActorInfo(GameObject go)
	{
		if (go == null)
		{
			return null;
		}
		ActorInfo logicComponent = go.GetLogicComponent<ActorInfo>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		AdventureSkill component = go.GetComponent<AdventureSkill>();
		if (component != null && component.actor != null)
		{
			logicComponent = component.actor.GetLogicComponent<ActorInfo>();
		}
		return logicComponent;
	}

	public static AmmoInfo GetFlowAmmoInfo(GameObject go)
	{
		if (go == null)
		{
			return null;
		}
		AmmoInfo logicComponent = go.GetLogicComponent<AmmoInfo>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		AdventureSkill component = go.GetComponent<AdventureSkill>();
		if (component != null && component.actor != null)
		{
			logicComponent = component.actor.GetLogicComponent<AmmoInfo>();
		}
		return logicComponent;
	}

	public static ActorHealthInfo GetFlowHealthInfo(GameObject go)
	{
		if (go == null)
		{
			return null;
		}
		ActorHealthInfo logicComponent = go.GetLogicComponent<ActorHealthInfo>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		AdventureSkill component = go.GetComponent<AdventureSkill>();
		if (component != null && component.actor != null)
		{
			logicComponent = component.actor.GetLogicComponent<ActorHealthInfo>();
		}
		return logicComponent;
	}

	public static LogicVariable GetFlowLogicVariable(GameObject go)
	{
		if (go == null)
		{
			return null;
		}
		LogicVariable logicComponent = go.GetLogicComponent<LogicVariable>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		AdventureSkill component = go.GetComponent<AdventureSkill>();
		if (component != null && component.actor != null)
		{
			logicComponent = component.actor.GetLogicComponent<LogicVariable>();
		}
		return logicComponent;
	}

	public static LogicEntity GetFlowEntity(this GameObject go)
	{
		if (go == null)
		{
			return null;
		}
		if (!go.TryGetParentComponent<LogicEntity>(out var comp))
		{
			return null;
		}
		return comp;
	}

	public static T GetLogicComponent<T>(this GameObject go) where T : ILogicComponent
	{
		LogicEntity component = go.GetComponent<LogicEntity>();
		if (!(component == null))
		{
			return component.GetLogicComponent<T>();
		}
		return default;
	}

	public static ActorSkillManage GetPlayerSkillManageComponent(GameObject go)
	{
		return go.GetLogicComponent<ActorSkillManage>();
	}

	public static bool IsConfrontWith(this LogicEntity entityA, LogicEntity entityB)
	{
		entityA.TryGetParentLogicComponent<ActorInfo>(out var comp);
		entityB.TryGetParentLogicComponent<ActorInfo>(out var comp2);
		if (comp == null || comp2 == null)
		{
			return false;
		}
		FactionRelation factionRelation = Singleton<HotfixDataController>.Instance.GetFactionRelation(comp.factionID);
		if (factionRelation == null)
		{
			Debug.LogError($"entityA faction relation not found,name:{entityA.name}, factionId:{comp.factionID}");
			return false;
		}
		if (comp2.factionID > factionRelation.FactionRelationShip.Count || comp2.factionID == 0)
		{
			Debug.LogError($"entityB {entityB.name} factionId large or small than configs:{comp2.factionID}/{factionRelation.FactionRelationShip.Count}");
			return false;
		}
		return factionRelation.FactionRelationShip.get_Item(comp2.factionID - 1) == 3;
	}

	public static bool IsNeutralWith(this LogicEntity entityA, LogicEntity entityB)
	{
		entityA.TryGetParentLogicComponent<ActorInfo>(out var comp);
		entityB.TryGetParentLogicComponent<ActorInfo>(out var comp2);
		if (comp == null || comp2 == null)
		{
			return false;
		}
		FactionRelation factionRelation = Singleton<HotfixDataController>.Instance.GetFactionRelation(comp.factionID);
		if (factionRelation == null)
		{
			Debug.LogError($"entityA faction relation not found,name:{entityA.name}, factionId:{comp.factionID}");
			return false;
		}
		if (comp2.factionID > factionRelation.FactionRelationShip.Count || comp2.factionID == 0)
		{
			Debug.LogError($"entityB {entityB.name} factionId large or small than configs:{comp2.factionID}/{factionRelation.FactionRelationShip.Count}");
			return false;
		}
		return factionRelation.FactionRelationShip.get_Item(comp2.factionID - 1) == 2;
	}

	public static bool IsFriendlyWith(this LogicEntity entityA, LogicEntity entityB)
	{
		entityA.TryGetParentLogicComponent<ActorInfo>(out var comp);
		entityB.TryGetParentLogicComponent<ActorInfo>(out var comp2);
		if (comp == null || comp2 == null)
		{
			return false;
		}
		FactionRelation factionRelation = Singleton<HotfixDataController>.Instance.GetFactionRelation(comp.factionID);
		if (factionRelation == null)
		{
			Debug.LogError($"entityA faction relation not found,name:{entityA.name}, factionId:{comp.factionID}");
			return false;
		}
		if (comp2.factionID > factionRelation.FactionRelationShip.Count || comp2.factionID == 0)
		{
			Debug.LogError($"entityB factionId large or small than configs:{comp2.factionID}/{factionRelation.FactionRelationShip.Count}");
			return false;
		}
		return factionRelation.FactionRelationShip.get_Item(comp2.factionID - 1) == 1;
	}

	public static bool CheckTarget(this LogicEntity entityA, LogicEntity entityB, TargetType targetType)
	{
		if (entityA == null || entityB == null)
		{
			return false;
		}
		AdventureActor summoner;
		AdventureActor summoner2;
		AdventureActor summoner3;
		AdventureActor summoner4;
		AdventureActor summoner5;
		AdventureActor summoner6;
		SummonType summonType;
		return targetType switch
		{
			TargetType.Owner => entityB == entityA, 
			TargetType.Teammate => entityB != entityA && entityA.IsFriendlyWith(entityB), 
			TargetType.Friend => entityA.IsFriendlyWith(entityB), 
			TargetType.Enemy => entityA.IsConfrontWith(entityB), 
			TargetType.Both => !entityA.IsNeutralWith(entityB), 
			TargetType.OwnerSummoned => entityB.IsMinion(out summoner) && summoner == entityA, 
			TargetType.TeammateSummoned => entityB.IsMinion(out summoner2) && summoner2 != entityA && entityA.IsFriendlyWith(summoner2), 
			TargetType.FriendSummoned => entityB.IsMinion(out summoner3) && entityA.IsFriendlyWith(summoner3), 
			TargetType.EnemySummoned => entityB.IsMinion(out summoner4) && entityA.IsConfrontWith(summoner4), 
			TargetType.BothSummoned => entityB.IsMinion(out summoner5) && !entityA.IsNeutralWith(summoner5), 
			TargetType.MainPlayerActor => entityB is PlayerAdventureActor playerAdventureActor && !playerAdventureActor.isAssist, 
			TargetType.AssitPlayerActor => entityB is PlayerAdventureActor playerAdventureActor2 && playerAdventureActor2.isAssist, 
			TargetType.TeammateWithoutSummoned => entityB != entityA && entityA.IsFriendlyWith(entityB) && !entityB.IsSummoned(out summoner6, out summonType), 
			TargetType.TeammateWithoutNotMinionSummoned => entityB != entityA && entityA.IsFriendlyWith(entityB) && (!entityB.IsSummoned(out summoner6, out summonType) || entityB.IsMinion(out summoner6)), 
			TargetType.FriendWithoutSummoned => entityA.IsFriendlyWith(entityB) && !entityB.IsSummoned(out summoner6, out summonType), 
			_ => false, 
		};
	}

	public static bool IsDead(this LogicEntity entity)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (!(adventureActor == null) && !adventureActor.isDead)
		{
			return adventureActor.isDeclareDead;
		}
		return true;
	}

	public static bool IsHideModel(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isHideModel;
		}
		return false;
	}

	public static bool IsSneak(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isSneak;
		}
		return false;
	}

	public static bool IsHideOut(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isHideOut;
		}
		return false;
	}

	public static bool IsSearchedImmunity(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.searchedImmunity;
		}
		return false;
	}

	public static bool IsBattleOut(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isBattleOut;
		}
		return false;
	}

	public static bool IsUnparalleled(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isUnparalleled;
		}
		return false;
	}

	public static bool IsPenetrate(this LogicEntity entity)
	{
		if (entity is AdventureActor adventureActor)
		{
			return adventureActor.isPenetrate;
		}
		return false;
	}

	public static bool IsViewableBy(this LogicEntity entityA, LogicEntity entityB)
	{
		if (entityA == entityB)
		{
			return true;
		}
		TSVector2 origin = entityA.tsTransform.Position;
		TSVector2 tSVector = entityB.tsTransform.Position - origin;
		TSVector2 direction = tSVector.normalized;
		DeterministicRaycastHit hitInfo;
		return !SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out hitInfo, tSVector.magnitude, 4096);
	}

	public static bool IsSummoned(this LogicEntity entity, out AdventureActor summoner, out SummonType summonType)
	{
		summoner = null;
		summonType = SummonType.None;
		if (!(entity is MonsterAdventureActor monsterAdventureActor))
		{
			return false;
		}
		summoner = monsterAdventureActor.monsterSummonInfo.SummonActor;
		summonType = monsterAdventureActor.monsterSummonInfo.SummonType;
		return summoner != null;
	}

	public static bool IsPlayerSummoned(this LogicEntity entity, out PlayerAdventureActor summoner, out SummonType summonType)
	{
		summoner = null;
		summonType = SummonType.None;
		if (entity.IsSummoned(out var summoner2, out summonType) && summoner2 is PlayerAdventureActor playerAdventureActor)
		{
			summoner = playerAdventureActor;
			return true;
		}
		return false;
	}

	public static bool IsUseHitFromSummon(this LogicEntity entity, out AdventureActor summoner)
	{
		if (entity.IsSummoned(out summoner, out var _))
		{
			AdventureActor adventureActor = summoner;
			if (adventureActor is PlayerAdventureActor || adventureActor is DynamicActor)
			{
				return ((MonsterAdventureActor)entity).monsterSummonInfo.UseSummonHit;
			}
		}
		summoner = null;
		return false;
	}

	public static bool IsMinion(this LogicEntity entity, out AdventureActor summoner)
	{
		if (entity.IsSummoned(out summoner, out var summonType) && summonType == SummonType.Minion)
		{
			return true;
		}
		return false;
	}

	public static bool IsPlayerMinion(this LogicEntity entity, out PlayerAdventureActor summoner)
	{
		if (entity.IsPlayerSummoned(out summoner, out var summonType) && summonType == SummonType.Minion)
		{
			return true;
		}
		return false;
	}

	public static bool IsBossMonster(this LogicEntity entity)
	{
		if (!(entity is MonsterAdventureActor monsterAdventureActor))
		{
			return false;
		}
		HotfixEnum.monsterEpicType epicType = monsterAdventureActor.monsterInfo.epicType;
		if ((uint)(epicType - 2) <= 1u || (uint)(epicType - 7) <= 1u)
		{
			return true;
		}
		return false;
	}

	public static bool IsEliteOrBossMonster(this LogicEntity entity)
	{
		if (!(entity is MonsterAdventureActor monsterAdventureActor))
		{
			return false;
		}
		if (monsterAdventureActor.monsterInfo.epicType != HotfixEnum.monsterEpicType.ELITE)
		{
			return monsterAdventureActor.IsBossMonster();
		}
		return true;
	}

	public static bool IsObstacleOcclusion(this DeterministicCollider colliderA, DeterministicCollider colliderB)
	{
		FP width = colliderA.Radius * 0.1f;
		TSVector2 normalized = (colliderB.tsTransform.Position - colliderA.tsTransform.Position).normalized;
		FP fP = TSVector2.Distance(colliderA.tsTransform.Position, colliderB.tsTransform.Position - normalized * colliderB.Radius);
		FP angle = normalized.GetAngle();
		TSVector2 pos = colliderA.tsTransform.Position + normalized * fP * 0.5f;
		return SceneSingleton<DeterministicCollisionManager>.Instance.CheckRectangleOverlap(width, fP, pos, angle, null, 4096);
	}
}
