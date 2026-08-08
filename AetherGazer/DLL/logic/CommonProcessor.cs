using System;
using System.Collections.Generic;
using Config;
using Google.Protobuf.WellKnownTypes;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

public class CommonProcessor
{
	public static SimContext mSimContext;

	private static SEntityWorldState mWorldState;

	private static int mConstTick = -1;

	public const int CONFIG_INTERVAL = 33;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
		mWorldState = mSimContext.sEntityWorldState;
		mConstTick = mSimContext.simStatus.runtimeSetting.kSimTickPeriodMS;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
		mWorldState = null;
	}

	public static Int3 GetRandomPoint(uint range)
	{
		return new Int3((int)DRandom.Random(range), 0, (int)DRandom.Random(range));
	}

	public static int RandomNum(int max)
	{
		return 2 * max - (int)DRandom.Random((uint)max);
	}

	public static int GetLogicConstTick()
	{
		return mConstTick;
	}

	public static int GetConfigInterval()
	{
		return 33;
	}

	public static SimWorldState GetWorldState()
	{
		return mWorldState.status;
	}

	public static SimEntity GetSimEntityByTriggerID(int triggerID)
	{
		int mID = mWorldState.status.triggerIDToEntityID[triggerID];
		return mSimContext.GetEntityWithEntityID(mID);
	}

	public static T GetTriggerEntityBlackboardVariable<T>(SimEntity triggerEntity, string varName)
	{
		SimVariable value = null;
		if (triggerEntity.entityTrigger.mBlackboard.TryGetValue(varName, out value))
		{
			SimVariable<T> simVariable = (SimVariable<T>)value;
			return simVariable.value;
		}
		SimVariable<T> simVariable2 = new SimVariable<T>();
		simVariable2.name = varName;
		simVariable2.value = default(T);
		triggerEntity.entityTrigger.mBlackboard.Add(varName, simVariable2);
		return simVariable2.value;
	}

	public static SimVariable<T> GetTriggerEntityBlackboardSimVariable<T>(SimEntity triggerEntity, string varName)
	{
		SimVariable value = null;
		triggerEntity.entityTrigger.mBlackboard.TryGetValue(varName, out value);
		if (value == null)
		{
			SimVariable<T> simVariable = new SimVariable<T>();
			simVariable.name = varName;
			simVariable.value = default(T);
			triggerEntity.entityTrigger.mBlackboard.Add(varName, simVariable);
			value = simVariable;
		}
		return value as SimVariable<T>;
	}

	public static bool SetTriggerEntityBlackboardVariable<T>(SimEntity triggerEntity, string varName, T value)
	{
		SimVariable value2 = null;
		if (triggerEntity.entityTrigger.mBlackboard.TryGetValue(varName, out value2))
		{
			SimVariable<T> simVariable = (SimVariable<T>)value2;
			simVariable.value = value;
			return true;
		}
		SimVariable<T> simVariable2 = new SimVariable<T>();
		simVariable2.name = varName;
		simVariable2.value = value;
		triggerEntity.entityTrigger.mBlackboard.Add(varName, simVariable2);
		return false;
	}

	public static void InitTriggerEntityBlackboard(SimEntity triggerEntity)
	{
		SimVariable simVariable = null;
		IEnumerator<KeyValuePair<string, Any>> enumerator = triggerEntity.entityTrigger.mTriggerData.Blackboard.Map.GetEnumerator();
		while (enumerator.MoveNext())
		{
			string key = enumerator.Current.Key;
			Any value = enumerator.Current.Value;
			simVariable = GetSimVariableByAny(value, key);
			if (simVariable != null)
			{
				triggerEntity.entityTrigger.mBlackboard.Add(key, simVariable);
			}
		}
	}

	public static SimVariable GetSimVariableByAny(Any any, string varName)
	{
		SimVariable simVariable = null;
		if (any.TypeUrl == "type.googleapis.com/ProtoInt")
		{
			SimVariable<int> simVariable2 = new SimVariable<int>();
			simVariable2.value = any.Unpack<ProtoInt>().Value;
			simVariable = simVariable2;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoString")
		{
			SimVariable<string> simVariable3 = new SimVariable<string>();
			simVariable3.value = any.Unpack<ProtoString>().S;
			simVariable = simVariable3;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoIntList")
		{
			List<int> list = new List<int>();
			foreach (int item2 in any.Unpack<ProtoIntList>().List)
			{
				list.Add(item2);
			}
			SimVariable<List<int>> simVariable4 = new SimVariable<List<int>>();
			simVariable4.value = list;
			simVariable = simVariable4;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoStringList")
		{
			List<string> list2 = new List<string>();
			foreach (string item3 in any.Unpack<ProtoStringList>().List)
			{
				list2.Add(item3);
			}
			SimVariable<List<string>> simVariable5 = new SimVariable<List<string>>();
			simVariable5.value = list2;
			simVariable = simVariable5;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoBool")
		{
			SimVariable<bool> simVariable6 = new SimVariable<bool>();
			simVariable6.value = any.Unpack<ProtoBool>().Value;
			simVariable = simVariable6;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoBoolList")
		{
			List<bool> list3 = new List<bool>();
			foreach (bool item4 in any.Unpack<ProtoBoolList>().List)
			{
				list3.Add(item4);
			}
			SimVariable<List<bool>> simVariable7 = new SimVariable<List<bool>>();
			simVariable7.value = list3;
			simVariable = simVariable7;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoInt3")
		{
			ProtoInt3 protoInt = any.Unpack<ProtoInt3>();
			Int3 value = new Int3(protoInt.X, protoInt.Y, protoInt.Z);
			SimVariable<Int3> simVariable8 = new SimVariable<Int3>();
			simVariable8.value = value;
			simVariable = simVariable8;
		}
		else if (any.TypeUrl == "type.googleapis.com/ProtoInt3List")
		{
			ProtoInt3List protoInt3List = any.Unpack<ProtoInt3List>();
			List<Int3> list4 = new List<Int3>();
			foreach (ProtoInt3 item5 in any.Unpack<ProtoInt3List>().List)
			{
				Int3 item = new Int3(item5.X, item5.Y, item5.Z);
				list4.Add(item);
			}
			SimVariable<List<Int3>> simVariable9 = new SimVariable<List<Int3>>();
			simVariable9.value = list4;
			simVariable = simVariable9;
		}
		if (simVariable == null)
		{
			Debug.Log((object)("这个变量有问题,跳过 ---" + varName));
			return null;
		}
		simVariable.name = varName;
		return simVariable;
	}

	public static bool EntityHasEntityTimer(int entityID, int timerNumber)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		bool flag = false;
		if (!entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		return entityWithEntityID.entityBlackboard.var.timer.ContainsKey(timerNumber);
	}

	public static bool EntityAddEntityTimer(int entityID, int timerNumber, int interval)
	{
		bool flag = false;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (!entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		if (entityWithEntityID.entityBlackboard.var.timer.ContainsKey(timerNumber))
		{
			return false;
		}
		SimBlackboard.EntityCounterStruct value = default(SimBlackboard.EntityCounterStruct);
		value.name = timerNumber;
		value.intervalConfig = interval;
		value.runningCount = 0;
		entityWithEntityID.entityBlackboard.var.timer.Add(timerNumber, value);
		return true;
	}

	public static bool EntityTimerUpdate(int entityID, int timerNumber, int delta)
	{
		bool flag = false;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (!entityWithEntityID.hasEntityBlackboard)
		{
			flag = false;
		}
		else
		{
			flag = entityWithEntityID.entityBlackboard.var.timer.TryGetValue(timerNumber, out var value);
			if (flag)
			{
				value.runningCount += delta;
				if (value.runningCount >= value.intervalConfig)
				{
					value.runningCount = 0;
					flag = true;
				}
				else
				{
					flag = false;
				}
				entityWithEntityID.entityBlackboard.var.timer[timerNumber] = value;
			}
		}
		return flag;
	}

	public static bool ResetEntityTimer(int entityID, int timerNumber)
	{
		bool flag = false;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			flag = false;
		}
		else
		{
			flag = entityWithEntityID.entityBlackboard.var.timer.TryGetValue(timerNumber, out var value);
			if (flag)
			{
				value.runningCount = 0;
				entityWithEntityID.entityBlackboard.var.timer[timerNumber] = value;
			}
		}
		return flag;
	}

	public static void HideEntity(SimEntity simEntity, bool isShow)
	{
		if (simEntity.hasEntityShape)
		{
			SimShapeProcessor.EnableShapes(simEntity, isShow);
		}
		int mTimeStep = (isShow ? 100 : 0);
		if (simEntity.hasEntityActionMoveDirection)
		{
			simEntity.entityActionMoveDirection.mTimeStep = mTimeStep;
		}
		if (simEntity.hasEntityActionAbility)
		{
			simEntity.entityActionAbility.mTimeStep = mTimeStep;
		}
		if (simEntity.hasEntityHitRecover)
		{
			simEntity.entityHitRecover.mTimeStep = mTimeStep;
		}
	}

	public static VFactor Normalize(VFactor f)
	{
		while (f.den % 10 == 0L && f.nom % 10 == 0L && f.den != 0L && f.nom != 0L)
		{
			f.den /= 10L;
			f.nom /= 10L;
		}
		return new VFactor((f * 1000L).floorInt, 1000L);
	}

	public static bool IsInSourceSpaceState()
	{
		if (mSimContext.hasEntitySourceSpace)
		{
			return mSimContext.entitySourceSpace.Enable;
		}
		return false;
	}

	public static bool IsInSourceSpaceState(SimContext simContext)
	{
		if (simContext.hasEntitySourceSpace)
		{
			return simContext.entitySourceSpace.Enable;
		}
		return false;
	}

	public static bool InSourceSpaceCD()
	{
		if (mSimContext.hasEntitySourceSpace)
		{
			return mSimContext.entitySourceSpace.LimitDodgeCD > 0;
		}
		return false;
	}

	public static bool TryGetPosition(SimContext simContext, int creationIndex, out Int3 position, out Int3 forward)
	{
		ThrownState thrownState;
		if (creationIndex > 0)
		{
			SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(creationIndex);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
			{
				position = entityWithEntityID.entityPositon.mPosition;
				forward = entityWithEntityID.entityPositon.mForward;
				return true;
			}
		}
		else if (creationIndex < 0 && ThrownProcessor.TryGetThrown(simContext, creationIndex, out thrownState))
		{
			position = thrownState.mPosition;
			forward = thrownState.mForward;
			return true;
		}
		position = Int3.zero;
		forward = Int3.forward;
		return false;
	}

	public static Int3 GetPositionInGraphWithoutTangentMove(Int3 start, Int3 end)
	{
		int num = -1;
		int area = -1;
		PathUtilities.IsOnGraph(start, out area);
		if (area == -1)
		{
			return start;
		}
		RecastGraph recastGraph = AstarPath.active.graphs[0] as RecastGraph;
		if (recastGraph.Linecast(start, end, recastGraph.GetNearest(start, NNConstraint.None).node, out var hit))
		{
			end = hit.point;
		}
		return end;
	}

	public static bool TryGetAliveRole(SimContext simContext, int entityID, out SimEntity simEntity)
	{
		simEntity = simContext.GetEntityWithEntityID(entityID);
		SimEntity simEntity2 = simEntity;
		if (simEntity2 == null)
		{
			return false;
		}
		if (simEntity2.mTag == SimEntity.Tag.MultiColliders)
		{
			simEntity2 = simEntity2.mParent;
		}
		if (simEntity2 == null || simEntity2.hasEntityActionDeath || !simEntity2.hasEntityBlackboard || (simEntity2.hasEntityBlackboard && simEntity2.entityBlackboard.var.mHP <= 0) || !simEntity2.hasEntityConfig)
		{
			return false;
		}
		return true;
	}

	public static bool IsAliveRole(SimEntity simEntity)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (simEntity.mTag == SimEntity.Tag.MultiColliders)
		{
			simEntity = simEntity.mParent;
		}
		if (simEntity == null || simEntity.hasEntityActionDeath || !simEntity.hasEntityBlackboard || (simEntity.hasEntityBlackboard && simEntity.entityBlackboard.var.mHP <= 0))
		{
			return false;
		}
		return true;
	}

	public static bool TryGetEntityIDOrCasterID(SimContext simContext, int creationIndex, out int thrownID, out int entityID)
	{
		thrownID = 0;
		entityID = 0;
		if (creationIndex < 0)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(simContext, creationIndex, out thrownState))
			{
				return false;
			}
			thrownID = thrownState.mCreationIndex;
			entityID = thrownState.mCasterID;
			return true;
		}
		entityID = creationIndex;
		return entityID != 0;
	}

	public static bool TryGetTargets(SimContext simContext, List<int> resultList, List<int> ignoreList, int creationIndex, TargetCampType targetCampType, RangeType rangeType, Int3 centerOffset, int radius, int angle, int width, int height, int length, TargetSelectType targetSelectType, int targetCount)
	{
		if (!TryGetEntityIDOrCasterID(simContext, creationIndex, out var thrownID, out var entityID))
		{
			return false;
		}
		Int3 center = Int3.zero;
		Int3 forward = Int3.forward;
		uint num = 0u;
		if (thrownID != 0)
		{
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(simContext, thrownID, out thrownState))
			{
				center = thrownState.mPosition;
				forward = thrownState.mForward;
				num = thrownState.mCamp;
			}
		}
		if (num == 0)
		{
			SimEntity simEntity = null;
			if (!TryGetAliveRole(simContext, entityID, out simEntity) || !simEntity.hasEntityCamp)
			{
				return false;
			}
			num = simEntity.entityCamp.mRoleTypeCamp;
			center = simEntity.entityPositon.mPosition;
			forward = simEntity.entityPositon.mForward;
		}
		if (!TryGetTargetLayerMask(num, targetCampType, out var targetLayerMask))
		{
			return false;
		}
		return TryGetTargets(simContext, resultList, ignoreList, targetLayerMask, rangeType, center, forward, centerOffset, radius, angle, width, height, length, targetSelectType, targetCount);
	}

	public static bool TryGetTargets(SimContext simContext, List<int> resultList, List<int> ignoreList, uint targetLayerMask, RangeType rangeType, Int3 center, Int3 forward, Int3 centerOffset, int radius, int angle, int width, int height, int length, TargetSelectType targetSelectType, int targetCount)
	{
		bool result = false;
		List<int> list = FrameListPool<int>.Claim();
		if (TryGetCollisions(simContext, rangeType, center, forward, centerOffset, radius, angle, new Int3(width, height, length), list, targetLayerMask))
		{
			List<int> list2 = FrameListPool<int>.Claim();
			RemoveSpecificInList(list, ignoreList, list2);
			if (list2.Count > 0 && TryFilterCollisions(simContext, center, list2, targetSelectType, targetCount, resultList))
			{
				result = true;
			}
			FrameListPool<int>.Release(list2);
		}
		FrameListPool<int>.Release(list);
		return result;
	}

	public static bool TryGetTargetLayerMask(uint casterCamp, TargetCampType targetCampType, out uint targetLayerMask)
	{
		targetLayerMask = 0u;
		switch (targetCampType)
		{
		case TargetCampType.None:
			return false;
		case TargetCampType.We:
			targetLayerMask = casterCamp;
			return true;
		case TargetCampType.Enemy:
			targetLayerMask = RoleCampProcessor.GetInterestCamp(casterCamp);
			return true;
		case TargetCampType.Oneself:
			return false;
		case TargetCampType.All:
			targetLayerMask = uint.MaxValue;
			return true;
		default:
			return false;
		}
	}

	public static ISimShape GetValidNearestRaycastShape(List<ISimShape> shapeList, List<SimRaycastHitInfo> hitInfoList, long distanceLimit)
	{
		if (shapeList == null || shapeList.Count <= 0 || hitInfoList == null || hitInfoList.Count != shapeList.Count)
		{
			return null;
		}
		ISimShape result = null;
		long num = distanceLimit;
		for (int i = 0; i < shapeList.Count; i++)
		{
			if ((hitInfoList[i].distance <= num || shapeList[i].Layer != RoleType.Bunker) && shapeList[i].IsEnable && hitInfoList[i].distance < num)
			{
				num = hitInfoList[i].distance;
				result = shapeList[i];
			}
		}
		return result;
	}

	public static bool TryGetCollisions(Int3 position, Int3 forward, Int3 aimDirection, HitCheckInfo hitCheckInfo, uint layerMask, List<ISimShape> collisions)
	{
		if (RangeType.Sector == hitCheckInfo.RangeType)
		{
			Int3 origin = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapSector(origin, hitCheckInfo.Radius, hitCheckInfo.Angle, aimDirection, collisions, layerMask);
		}
		else if (RangeType.Roundness == hitCheckInfo.RangeType)
		{
			Int3 origin2 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.Overlap(origin2, hitCheckInfo.Radius, collisions, layerMask);
		}
		else if (RangeType.Rectangle == hitCheckInfo.RangeType)
		{
			Int3 origin3 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapBox(origin3, aimDirection, Int3.zero, new Int3(hitCheckInfo.Width, 1000, hitCheckInfo.Length), collisions, layerMask);
		}
		else if (RangeType.Straightline == hitCheckInfo.RangeType)
		{
			List<ISimShape> list = ListPool<ISimShape>.Claim();
			List<SimRaycastHitInfo> list2 = ListPool<SimRaycastHitInfo>.Claim();
			if (SimPhysics.Raycast(position, aimDirection, new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), layerMask, list, list2))
			{
				ISimShape validNearestRaycastShape = GetValidNearestRaycastShape(list, list2, hitCheckInfo.Radius);
				if (validNearestRaycastShape != null)
				{
					collisions.Add(validNearestRaycastShape);
				}
			}
			ListPool<ISimShape>.Release(list);
			ListPool<SimRaycastHitInfo>.Release(list2);
		}
		else if (RangeType.Annulus == hitCheckInfo.RangeType)
		{
			Int3 origin4 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapAnnulus(origin4, hitCheckInfo.Radius, hitCheckInfo.Length, collisions, layerMask);
		}
		else if (RangeType.AnnularSector == hitCheckInfo.RangeType)
		{
			Int3 origin5 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapAnnularSector(origin5, hitCheckInfo.Radius, hitCheckInfo.Length, hitCheckInfo.Angle, aimDirection, collisions, layerMask);
		}
		return collisions.Count > 0;
	}

	public static bool TryGetCollisions(Int3 position, Int3 forward, Int3 aimDirection, DangerRangeForAIInfo hitCheckInfo, uint layerMask, List<int> collisions)
	{
		if (RangeType.Sector == hitCheckInfo.RangeType)
		{
			Int3 origin = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapSector(origin, hitCheckInfo.Radius, hitCheckInfo.Angle, aimDirection, collisions, layerMask);
		}
		else if (RangeType.Roundness == hitCheckInfo.RangeType)
		{
			Int3 origin2 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.Overlap(origin2, hitCheckInfo.Radius, collisions, layerMask);
		}
		else if (RangeType.Rectangle == hitCheckInfo.RangeType)
		{
			Int3 origin3 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapBox(origin3, aimDirection, Int3.zero, new Int3(hitCheckInfo.Width, 1000, hitCheckInfo.Length), collisions, layerMask);
		}
		else if (RangeType.Straightline == hitCheckInfo.RangeType)
		{
			List<ISimShape> list = ListPool<ISimShape>.Claim();
			List<SimRaycastHitInfo> list2 = ListPool<SimRaycastHitInfo>.Claim();
			if (SimPhysics.Raycast(position, aimDirection, new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), layerMask, list, list2))
			{
				ISimShape validNearestRaycastShape = GetValidNearestRaycastShape(list, list2, hitCheckInfo.Radius);
				if (validNearestRaycastShape != null)
				{
					collisions.Add(validNearestRaycastShape.OwnerID);
				}
			}
			ListPool<ISimShape>.Release(list);
			ListPool<SimRaycastHitInfo>.Release(list2);
		}
		else if (RangeType.Annulus == hitCheckInfo.RangeType)
		{
			Int3 origin4 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapAnnulus(origin4, hitCheckInfo.Radius, hitCheckInfo.Length, collisions, layerMask);
		}
		else if (RangeType.AnnularSector == hitCheckInfo.RangeType)
		{
			Int3 origin5 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), forward, position);
			SimPhysics.OverlapAnnularSector(origin5, hitCheckInfo.Radius, hitCheckInfo.Length, hitCheckInfo.Angle, aimDirection, collisions, layerMask);
		}
		return collisions.Count > 0;
	}

	public static bool TryGetCollisions(SimContext simContext, RangeType rangeType, Int3 originPosition, Int3 forward, Int3 centerOffset, int radius, int angle, Int3 size, List<int> collisions, uint targetLayerMask)
	{
		List<ISimShape> list = FrameListPool<ISimShape>.Claim();
		switch (rangeType)
		{
		case RangeType.Straightline:
		{
			List<ISimShape> list2 = ListPool<ISimShape>.Claim();
			List<SimRaycastHitInfo> list3 = ListPool<SimRaycastHitInfo>.Claim();
			if (SimPhysics.Raycast(originPosition, forward, centerOffset, targetLayerMask, list2, list3))
			{
				ISimShape validNearestRaycastShape = GetValidNearestRaycastShape(list2, list3, radius);
				if (validNearestRaycastShape != null)
				{
					collisions.Add(validNearestRaycastShape.OwnerID);
				}
			}
			ListPool<ISimShape>.Release(list2);
			ListPool<SimRaycastHitInfo>.Release(list3);
			break;
		}
		case RangeType.Sector:
		{
			Int3 origin4 = IntMath.Transform(centerOffset, forward, originPosition);
			SimPhysics.OverlapSector(origin4, radius, angle, forward, list, targetLayerMask);
			break;
		}
		case RangeType.Roundness:
		{
			Int3 origin3 = IntMath.Transform(centerOffset, forward, originPosition);
			SimPhysics.Overlap(origin3, radius, list, targetLayerMask);
			break;
		}
		case RangeType.Rectangle:
			SimPhysics.OverlapBox(originPosition, forward, centerOffset, size, list, targetLayerMask);
			break;
		case RangeType.Annulus:
		{
			Int3 origin2 = IntMath.Transform(centerOffset, forward, originPosition);
			SimPhysics.OverlapAnnulus(origin2, radius, size.z, list, targetLayerMask);
			break;
		}
		case RangeType.AnnularSector:
		{
			Int3 origin = IntMath.Transform(centerOffset, forward, originPosition);
			SimPhysics.OverlapAnnularSector(origin, radius, size.z, angle, forward, list, targetLayerMask);
			break;
		}
		}
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(list[i].OwnerID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityShape && list[i].IsEnable)
			{
				collisions.Add(entityWithEntityID.creationIndex);
			}
		}
		FrameListPool<ISimShape>.Release(list);
		return collisions.Count > 0;
	}

	public static bool TryFilterCollisions(SimContext simContext, Int3 centerPos, List<int> srcList, TargetSelectType targetSelectType, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (srcList.Count <= 0)
		{
			return false;
		}
		switch (targetSelectType)
		{
		case TargetSelectType.Nearest:
			TryGetNearest(simContext, srcList, centerPos, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.Farthest:
			TryGetFarthest(simContext, srcList, centerPos, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.HpLeast:
			TryGetHpLeast(simContext, srcList, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.HpMaximum:
			TryGetHpMaximum(simContext, srcList, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.BattleAbilityMax:
			TryGetBattleAbilityMax(simContext, srcList, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.Random:
			TryGetRandomEntity(simContext, srcList, targetCount, resultList, ignoredList);
			break;
		case TargetSelectType.WithoutSelf:
			Debug.LogError((object)"=====>>>>> 已废除,请在调用函数前,剔除自身");
			break;
		}
		return resultList.Count > 0;
	}

	public static bool TryGetNearest(SimContext simContext, List<int> srcList, Int3 centerPos, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (srcList == null || srcList.Count <= 0)
		{
			return false;
		}
		if (targetCount <= 1)
		{
			long num = long.MaxValue;
			SimEntity simEntity = null;
			for (int i = 0; i < srcList.Count; i++)
			{
				if (!NeedContinueOnFilterList(simContext, srcList[i], out var aliveEntity, ignoredList))
				{
					long sqrMagnitudeLong = (aliveEntity.entityShape.mShape.WorldPos - centerPos).sqrMagnitudeLong;
					if (sqrMagnitudeLong < num)
					{
						num = sqrMagnitudeLong;
						simEntity = aliveEntity;
					}
				}
			}
			if (simEntity != null)
			{
				resultList.Add(simEntity.creationIndex);
			}
		}
		else
		{
			List<int> list = FrameListPool<int>.Claim();
			SortCollisionsByDistance(simContext, centerPos, srcList, list);
			int num2 = ((targetCount < list.Count) ? targetCount : list.Count);
			for (int j = 0; j < num2; j++)
			{
				if (NeedContinueOnFilterList(simContext, list[j], out var _, ignoredList))
				{
					num2++;
					num2 = IntMath.Min(num2, list.Count);
				}
				else
				{
					resultList.Add(list[j]);
				}
			}
			FrameListPool<int>.Release(list);
		}
		return resultList.Count > 0;
	}

	public static bool TryGetFarthest(SimContext simContext, List<int> srcList, Int3 centerPos, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (srcList == null || srcList.Count <= 0)
		{
			return false;
		}
		if (targetCount <= 1)
		{
			long num = long.MinValue;
			SimEntity simEntity = null;
			for (int i = 0; i < srcList.Count; i++)
			{
				if (!NeedContinueOnFilterList(simContext, srcList[i], out var aliveEntity, ignoredList))
				{
					long sqrMagnitudeLong = (aliveEntity.entityShape.mShape.WorldPos - centerPos).sqrMagnitudeLong;
					if (sqrMagnitudeLong > num)
					{
						num = sqrMagnitudeLong;
						simEntity = aliveEntity;
					}
				}
			}
			if (simEntity != null)
			{
				resultList.Add(simEntity.creationIndex);
			}
		}
		else
		{
			List<int> list = FrameListPool<int>.Claim();
			SortCollisionsByDistance(simContext, centerPos, srcList, list);
			int num2 = IntMath.Max(list.Count - targetCount, 0);
			for (int num3 = list.Count - 1; num3 >= num2; num3--)
			{
				SimEntity aliveEntity2 = null;
				if (NeedContinueOnFilterList(simContext, list[num3], out aliveEntity2, ignoredList))
				{
					num2--;
					num2 = IntMath.Max(num2, 0);
				}
				resultList.Add(list[num3]);
			}
			FrameListPool<int>.Release(list);
		}
		return resultList.Count > 0;
	}

	public static void SortCollisionsByDistance(SimContext simContext, Int3 centerPos, List<int> srcList, List<int> resultList, bool onlySort = false)
	{
		if (srcList.Count <= 0)
		{
			return;
		}
		if (srcList.Count == 1)
		{
			resultList.Add(srcList[0]);
			return;
		}
		List<long> list = FrameListPool<long>.Claim();
		for (int i = 0; i < srcList.Count; i++)
		{
			SimEntity simEntity = null;
			if (onlySort)
			{
				simEntity = simContext.GetEntityWithEntityID(srcList[i]);
				if (simEntity == null || !simEntity.hasEntityShape)
				{
					continue;
				}
			}
			else if (!TryGetAliveRole(simContext, srcList[i], out simEntity))
			{
				continue;
			}
			bool flag = false;
			long sqrMagnitudeLong = (simEntity.entityShape.mShape.WorldPos - centerPos).sqrMagnitudeLong;
			for (int j = 0; j < list.Count; j++)
			{
				if (sqrMagnitudeLong < list[j])
				{
					resultList.Insert(j, srcList[i]);
					list.Insert(j, sqrMagnitudeLong);
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				resultList.Add(srcList[i]);
				list.Add(sqrMagnitudeLong);
			}
		}
		FrameListPool<long>.Release(list);
	}

	public static bool TryGetRandomEntity(SimContext simContext, List<int> srcList, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (srcList == null || srcList.Count <= 0)
		{
			return false;
		}
		if (targetCount >= srcList.Count)
		{
			resultList.AddRange(srcList);
		}
		else
		{
			int num = (int)DRandom.Random((uint)srcList.Count);
			SimEntity aliveEntity = null;
			for (int i = 0; i < srcList.Count; i++)
			{
				if (NeedContinueOnFilterList(simContext, srcList[num], out aliveEntity, ignoredList))
				{
					num = (num + 1) % srcList.Count;
					continue;
				}
				resultList.Add(aliveEntity.creationIndex);
				if (resultList.Count >= targetCount)
				{
					break;
				}
			}
		}
		return resultList.Count > 0;
	}

	public static bool TryGetHpLeast(SimContext simContext, List<int> srcList, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (srcList == null || srcList.Count <= 0)
		{
			return false;
		}
		if (targetCount <= 1)
		{
			long num = 2147483647L;
			SimEntity simEntity = null;
			for (int i = 0; i < srcList.Count; i++)
			{
				if (!NeedContinueOnFilterList(simContext, srcList[i], out var aliveEntity, ignoredList))
				{
					aliveEntity = GetSimEntityByMultiColliders(aliveEntity);
					long mHP = aliveEntity.entityBlackboard.var.mHP;
					if (mHP < num)
					{
						num = mHP;
						simEntity = aliveEntity;
					}
				}
			}
			if (simEntity != null)
			{
				resultList.Add(simEntity.creationIndex);
			}
		}
		else
		{
			List<int> list = FrameListPool<int>.Claim();
			SortCollisionsByHp(simContext, srcList, list);
			int num2 = ((targetCount < list.Count) ? targetCount : list.Count);
			for (int j = 0; j < num2; j++)
			{
				SimEntity aliveEntity2 = null;
				if (NeedContinueOnFilterList(simContext, list[j], out aliveEntity2, ignoredList))
				{
					num2++;
					num2 = IntMath.Min(num2, list.Count);
				}
				else
				{
					resultList.Add(list[j]);
				}
			}
			FrameListPool<int>.Release(list);
		}
		return resultList.Count > 0;
	}

	public static bool TryGetHpMaximum(SimContext simContext, List<int> collisions, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		if (collisions == null || collisions.Count <= 0)
		{
			return false;
		}
		if (targetCount <= 1)
		{
			long num = long.MinValue;
			SimEntity simEntity = null;
			for (int i = 0; i < collisions.Count; i++)
			{
				if (!NeedContinueOnFilterList(simContext, collisions[i], out var aliveEntity, ignoredList))
				{
					aliveEntity = GetSimEntityByMultiColliders(aliveEntity);
					long mHP = aliveEntity.entityBlackboard.var.mHP;
					if (mHP > num)
					{
						num = mHP;
						simEntity = aliveEntity;
					}
				}
			}
			if (simEntity != null)
			{
				resultList.Add(simEntity.creationIndex);
			}
		}
		else
		{
			List<int> list = FrameListPool<int>.Claim();
			SortCollisionsByHp(simContext, collisions, list);
			int num2 = IntMath.Max(list.Count - targetCount, 0);
			for (int num3 = list.Count - 1; num3 >= num2; num3--)
			{
				SimEntity aliveEntity2 = null;
				if (NeedContinueOnFilterList(simContext, list[num3], out aliveEntity2, ignoredList))
				{
					num2--;
					num2 = IntMath.Max(num2, 0);
				}
				else
				{
					resultList.Add(list[num3]);
				}
			}
			FrameListPool<int>.Release(list);
		}
		return resultList.Count > 0;
	}

	public static void SortCollisionsByHp(SimContext simContext, List<int> collisions, List<int> resultList)
	{
		if (collisions.Count <= 0)
		{
			return;
		}
		if (collisions.Count == 1)
		{
			resultList.Add(collisions[0]);
			return;
		}
		List<long> list = FrameListPool<long>.Claim();
		for (int i = 0; i < collisions.Count; i++)
		{
			if (!TryGetAliveRole(simContext, collisions[i], out var simEntity))
			{
				continue;
			}
			bool flag = false;
			simEntity = GetSimEntityByMultiColliders(simEntity);
			long mHP = simEntity.entityBlackboard.var.mHP;
			for (int j = 0; j < list.Count; j++)
			{
				if (mHP < list[j])
				{
					resultList.Insert(j, collisions[i]);
					list.Insert(j, mHP);
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				resultList.Add(collisions[i]);
				list.Add(mHP);
			}
		}
		for (int k = 0; k < list.Count; k++)
		{
			Debug.Log((object)("===>>>>> entityID:" + resultList[k] + ", 距离:" + list[k]));
		}
		FrameListPool<long>.Release(list);
	}

	private static bool TryGetBattleAbilityMax(SimContext simContext, List<int> collisions, int targetCount, List<int> resultList, List<int> ignoredList = null)
	{
		Debug.Log((object)"====>>>>没有实现");
		throw new NotImplementedException();
	}

	private static bool NeedContinueOnFilterList(SimContext simContext, int entityID, out SimEntity aliveEntity, List<int> ignoredList = null)
	{
		if (TryGetAliveRole(simContext, entityID, out aliveEntity))
		{
			return ignoredList?.Contains(entityID) ?? false;
		}
		return true;
	}

	public static void RemoveHisotryInList(List<int> srcList, List<int> hitstoryList, List<int> resultList)
	{
		RemoveSpecificInList(srcList, hitstoryList, resultList);
	}

	public static void RemoveSpecificInList(List<int> srcList, List<int> ignoreList, List<int> resultList)
	{
		if (ignoreList == null || ignoreList.Count <= 0)
		{
			resultList.AddRange(srcList);
			return;
		}
		for (int i = 0; i < srcList.Count; i++)
		{
			int item = srcList[i];
			if (!ignoreList.Contains(item))
			{
				resultList.Add(item);
			}
		}
	}

	public static bool TryGetEntityWithBlackboardByEntityID(SimContext simContext, int entityID, out SimEntity simEntity)
	{
		simEntity = simContext.GetEntityWithEntityID(entityID);
		if (simEntity == null)
		{
			return false;
		}
		if (!simEntity.hasEntityBlackboard)
		{
			return false;
		}
		return true;
	}

	public static bool IsInUltimateAvoidOfTarget(SimContext simContext, int attackerID, int targetID, int timelineID, int hitIndex, Int3 hitPosition, out int parentTargetID, int thrownID = 0, bool postEvent = true)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID.mParent != null && entityWithEntityID.hasEntityShape)
		{
			parentTargetID = entityWithEntityID.mParent.creationIndex;
			if (RoleCampProcessor.IsAvoidShadow(entityWithEntityID.entityShape.GetLayer()))
			{
				if ((entityWithEntityID.mParent.hasEntityActionAvoidShadow && !entityWithEntityID.mParent.entityActionAvoidShadow.Posted) & postEvent)
				{
					entityWithEntityID.mParent.entityActionAvoidShadow.Posted = true;
					if (thrownID != 0)
					{
						mSimContext.PostEvent(HitAvoidShadowByThrownEvent.Claim(thrownID, entityWithEntityID.mParent.creationIndex, timelineID, hitIndex, hitPosition));
					}
					else
					{
						mSimContext.PostEvent(HitAvoidShadowEvent.Claim(attackerID, entityWithEntityID.mParent.creationIndex, timelineID, hitIndex, hitPosition));
					}
				}
				return true;
			}
			if (entityWithEntityID.mParent.hasEntityActionAvoidShadow)
			{
				return true;
			}
			return false;
		}
		if (entityWithEntityID.hasEntityActionAvoidShadow)
		{
			parentTargetID = entityWithEntityID.creationIndex;
			return true;
		}
		parentTargetID = entityWithEntityID.creationIndex;
		return false;
	}

	public static bool TryGetAbilityID(SimEntity simEntity, int actionID, out int abilityID)
	{
		abilityID = 0;
		if (!simEntity.hasEntityConfig)
		{
			return false;
		}
		abilityID = (int)simEntity.ENTITY_CONFIG_ID * 1000 + actionID;
		return true;
	}

	public static bool IsInStand(SimEntity simEntity)
	{
		if (!simEntity.hasEntityActionMoveDirection && !simEntity.hasEntityActionAbility)
		{
			return !simEntity.hasEntityHitRecover;
		}
		return false;
	}

	public static bool IsInUniqueSkillABility(SimEntity pSimEntity, int pAbilityID, bool pOnlyFirst = false, bool pOnlyLast = false)
	{
		if (pSimEntity == null)
		{
			return false;
		}
		if (pSimEntity.hasEntityConfig && ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(pSimEntity.entityConfig.mId, out var config) && config.AbilityId.Count > 0)
		{
			if (pOnlyFirst)
			{
				return config.AbilityId.get_Item(0) == pAbilityID;
			}
			if (pOnlyLast)
			{
				return config.AbilityId.get_Item(config.AbilityId.Count - 1) == pAbilityID;
			}
			return config.AbilityId.Contains(pAbilityID);
		}
		return false;
	}

	public static bool IsSinglePlayerGameMode(SimContext simContext)
	{
		GameMode gameMode = simContext.simStatus.gameMode;
		return IsSinglePlayerGameMode(gameMode);
	}

	public static bool IsMultiplePlayerGameMode(SimContext simContext)
	{
		GameMode gameMode = simContext.simStatus.gameMode;
		return IsMultiplePlayerGameMode(gameMode);
	}

	public static bool IsReplayGameMode(SimContext simContext)
	{
		GameMode gameMode = simContext.simStatus.gameMode;
		return IsReplayGameMode(gameMode);
	}

	public static bool IsSinglePlayerGameMode(GameMode gameMode)
	{
		if (gameMode != GameMode.SinglePlayer && gameMode != GameMode.EditorSinglePlayer)
		{
			return gameMode == GameMode.Replay;
		}
		return true;
	}

	public static bool IsMultiplePlayerGameMode(GameMode gameMode)
	{
		if (gameMode != GameMode.Multiplayer && gameMode != GameMode.EditorMultiPlayer)
		{
			return gameMode == GameMode.ReplayMultiPlayer;
		}
		return true;
	}

	public static bool IsReplayGameMode(GameMode gameMode)
	{
		if (gameMode != GameMode.Replay)
		{
			return gameMode == GameMode.ReplayMultiPlayer;
		}
		return true;
	}

	public static bool CanMove(SimEntity pSimEntity)
	{
		if (pSimEntity[EntityVarName.ENTITY_ATTR_LOCK_MOVEMENT] != 0)
		{
			return false;
		}
		if ((pSimEntity.hasEntityActionAbility || pSimEntity.hasEntityHitRecover) && !ConfigProcessor.IsMoveRecover(pSimEntity))
		{
			return false;
		}
		return true;
	}

	public static ShapeItemInfo GetShapeOffset(ShapePartType type, ShapeInfo info)
	{
		for (int i = 0; i < info.ShapeItemInfoList.Count; i++)
		{
			if (type == info.ShapeItemInfoList.get_Item(i).ShapePartType)
			{
				return info.ShapeItemInfoList.get_Item(i);
			}
		}
		return info.ShapeItemInfoList.get_Item(0);
	}

	public static void UpdateRoleID(SimEntity attacker, int roleID, int appearAbilityID = 0)
	{
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID);
		if (config == null)
		{
			throw new Exception("角色ID " + roleID + " 找不到 RoleConfig 配置");
		}
		if (!attacker.hasEntityCamp)
		{
			throw new Exception("角色实体ID " + attacker.creationIndex + " 找不到 EntityCamp 组件");
		}
		if (!attacker.hasEntityPositon)
		{
			throw new Exception("角色实体ID " + attacker.creationIndex + " 找不到 EntityPositon 组件");
		}
		if (!attacker.hasEntityBlackboard)
		{
			throw new Exception("角色实体ID " + attacker.creationIndex + " 找不到 EntityBlackboard 组件");
		}
		if (attacker.hasEntityConfig)
		{
			attacker.RemoveEntityConfig();
		}
		attacker.AddEntityConfig(config, roleID);
		uint mRoleTypeCamp = attacker.entityCamp.mRoleTypeCamp;
		if (attacker.hasEntityShape)
		{
			attacker.RemoveEntityShape();
		}
		attacker.RemoveChildByTag(SimEntity.Tag.MultiColliders);
		Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(config.Idle);
		if (config2 == null || config2.ShapeInfoList.Count == 0)
		{
			throw new Exception(config.Idle + " 找不到 ShapeInfoList 配置");
		}
		ShapeInfo info = config2.ShapeInfoList.get_Item(0);
		for (int i = 0; i < config.ShapePartTypes.Count; i++)
		{
			ShapePartType shapePartType = config.ShapePartTypes.get_Item(i);
			ShapeItemInfo shapeOffset = GetShapeOffset(shapePartType, info);
			Int3 @int = new Int3(shapeOffset.Offset.X, shapeOffset.Offset.Y, shapeOffset.Offset.Z);
			SimEntity simEntity = null;
			ShapePartInfo newMShapePartInfo = default(ShapePartInfo);
			newMShapePartInfo.mCollection = ((config.ShapePartCollection.Count > i) ? config.ShapePartCollection.get_Item(i) : 0);
			newMShapePartInfo.destroyVal = 0L;
			newMShapePartInfo.destroyValChangeRule = ((config.DestroyValChangeRule.Count > newMShapePartInfo.mCollection) ? config.DestroyValChangeRule.get_Item(newMShapePartInfo.mCollection) : 0);
			newMShapePartInfo.destroyValLimit = ((config.DestroyValLimit.Count > newMShapePartInfo.mCollection) ? config.DestroyValLimit.get_Item(newMShapePartInfo.mCollection) : 0);
			if (shapePartType == ShapePartType.Body)
			{
				attacker.AddEntityShape(Int3.zero, ShapePartType.Body, SimShapeProcessor.CreateSimSphere(attacker.creationIndex, attacker.entityPositon.mPosition, config.Radius.get_Item(i), 200, Int3.forward, (RoleType)mRoleTypeCamp), mRoleTypeCamp, config.Weight, newMShapePartInfo);
				continue;
			}
			simEntity = mSimContext.CreateEntity();
			simEntity.mTag = SimEntity.Tag.MultiColliders;
			attacker.AddChild(simEntity);
			simEntity.mParent = attacker;
			simEntity.AddEntityShape(@int, shapePartType, SimShapeProcessor.CreateSimSphere(simEntity.creationIndex, attacker.entityPositon.mPosition + @int, config.Radius.get_Item(i), 200, Int3.forward, (RoleType)mRoleTypeCamp), mRoleTypeCamp, config.Weight, newMShapePartInfo);
		}
		attacker.RemoveChildByTag(SimEntity.Tag.AvoidShadow);
		if (attacker.entityBlackboard.var.mRolePostion != MemberPosition.None)
		{
			int num = int.MinValue;
			for (int j = 0; j < config.AvoidAbility.Count; j++)
			{
				Timeline config3 = ConfigHelper.GetInstance().GetConfig<Timeline>(config.AvoidAbility.get_Item(j));
				if (config3 != null && config3.MoveActionTimelineNode.MoveDistance > num)
				{
					num = config3.MoveActionTimelineNode.MoveDistance;
				}
			}
			int num2 = num / config.Radius.get_Item(0) / 2;
			if (config.Radius.get_Item(0) * num2 < num)
			{
				num2++;
			}
			uint roleCamp = 0u;
			RoleCampProcessor.Set(ref roleCamp, 512u);
			for (int k = 0; k < num2; k++)
			{
				SimEntity simEntity2 = mSimContext.CreateEntity();
				simEntity2.AddEntityShape(Int3.zero, ShapePartType.Body, SimShapeProcessor.CreateSimSphere(simEntity2.creationIndex, attacker.entityPositon.mPosition, config.Radius.get_Item(0), 200, Int3.forward, RoleType.AvoidShadow), roleCamp, config.Weight, default(ShapePartInfo));
				simEntity2.entityShape.SetEnable(isEnable: false);
				simEntity2.AddEntityPositon(attacker.entityPositon.mPosition, attacker.entityPositon.mForward, IntMath.AngleOfVector(attacker.entityPositon.mForward), attacker.entityPositon.mUp, newIsTeleport: false);
				simEntity2.mParent = attacker;
				simEntity2.mTag = SimEntity.Tag.AvoidShadow;
				attacker.AddChild(simEntity2);
			}
		}
		attacker.entityBlackboard.var.mConfigID = roleID;
		attacker.entityBlackboard.var.mMaxSpeed = new VFactor(config.Speed, 1000L);
		attacker.entityBlackboard.var.mUseRunMoveCurve = config.UseRunMoveCurve;
		attacker.entityBlackboard.var.mHitRecoverSlot = config.HitRecoverID.get_Item(0);
		attacker.entityBlackboard.var.mHitUpSlot = config.HitUpID;
		attacker.entityBlackboard.var.mHitDownSlot = config.HitDownID;
		attacker.entityBlackboard.var.mHitFloorSlot = config.HitFloorID;
		attacker.entityBlackboard.var.mGetUpSlot = config.GetUpID;
		attacker.entityBlackboard.var.mDeathTimeType = config.DeathTime;
		attacker.entityBlackboard.var.mDeathSlot = config.Death;
		attacker.entityBlackboard.var.mAirDeathSlot = config.AirDeath;
		attacker.entityBlackboard.var.mNoAnimationDeathSlot = config.NoAnimationDeath;
		attacker.entityBlackboard.var.mFallDownDeathSlot = config.FallDownDeath;
		attacker.entityBlackboard.var.mAvoidForwardSlots = ((config.AvoidAbility.Count > 0) ? config.AvoidAbility.get_Item(0) : 0);
		attacker.entityBlackboard.var.mAvoidBackSlots = ((config.AvoidAbility.Count > 1) ? config.AvoidAbility.get_Item(1) : 0);
		attacker.entityBlackboard.var.mRunStartSlot = config.RunStart;
		attacker.entityBlackboard.var.mNearStopSlot = config.NearStop;
		attacker.entityBlackboard.var.mRushIDSlot = config.RushID;
		attacker.entityBlackboard.var.mRushStopIDSlot = config.RushStopID;
		attacker.entityBlackboard.var.mRunSlot = config.Run;
		attacker.entityBlackboard.var.mMovementStopSlot = config.MovementStop;
		attacker.entityBlackboard.var.mBattleIldeRecoverSlot = config.BattleIldeRecover;
		attacker.entityBlackboard.var.mRunLeftIDSlot = config.RunLeft;
		attacker.entityBlackboard.var.mRunRightIDSlot = config.RunRight;
		attacker.entityBlackboard.var.mDeltaRotationSpeed = config.RotationSpeed;
		attacker.entityBlackboard.var.mMeleesSlots.Clear();
		for (int l = 0; l < config.Melees.Count; l++)
		{
			attacker.entityBlackboard.var.mMeleesSlots.Add(config.Melees.get_Item(l));
		}
		for (int m = 0; m < config.Ability.Count; m++)
		{
			if (m < attacker.entityBlackboard.var.mAbilitySlots.Length)
			{
				int arg = attacker.entityBlackboard.var.mAbilitySlots[m];
				attacker.entityBlackboard.var.mAbilitySlots[m] = config.Ability.get_Item(m);
				mSimContext.GetSimInterface().mAbilitySlotsChangeEvent?.Invoke(attacker.creationIndex, m, arg, attacker.entityBlackboard.var.mAbilitySlots[m]);
			}
		}
		attacker.entityBlackboard.var.mHitRecoverSlots.Clear();
		for (int n = 0; n < config.HitRecoverID.Count; n++)
		{
			attacker.entityBlackboard.var.mHitRecoverSlots.Add(config.HitRecoverID.get_Item(n));
		}
		attacker.entityBlackboard.var.mHitAirSlot.Clear();
		for (int num3 = 0; num3 < config.HitAirID.Count; num3++)
		{
			attacker.entityBlackboard.var.mHitAirSlot.Add(config.HitAirID.get_Item(num3));
		}
		charactor_param config4 = ConfigHelper.GetInstance().GetConfig<charactor_param>(roleID);
		if (config4 != null)
		{
			attacker.entityBlackboard.var.mCharacterParamUltimateAvoidCD = config4.UltimateAvoidCD;
			attacker.entityBlackboard.var.mRaceID = config4.RaceID;
			attacker.entityBlackboard.var.mCharacterParamItemPickUpRadius = config4.ItemPickUpRadius;
			AttributeProcessor.SetAttributeWithIntName(attacker.entityBlackboard.var.mAttributeID, 2018, config4.EnergyMaxValue, 0L, 0L);
			AttributeProcessor.SetAttributeWithIntName(attacker.entityBlackboard.var.mAttributeID, 2015, config4.UltimateAvoidSpaceTime, 0L, 0L);
			attacker.entityBlackboard.var.mEnergyType = (EnergyType)config4.EnergyType;
			AttributeProcessor.SetAttributeWithIntName(attacker.entityBlackboard.var.mAttributeID, 2223, config4.BreakValueRate, 0L, 0L);
		}
		attacker.entityBlackboard.var.mBeHitKeepForward = config.KeepForward;
		if (appearAbilityID > 0)
		{
			AbilitiesProcessor.SetNextFrameAbility(attacker, appearAbilityID, forceBroken: true);
		}
		attacker.entityBlackboard.var.initFinished = false;
	}

	public static bool HasSameShapeCollect(List<int> list, SimEntity target)
	{
		if (target == null || !target.hasEntityShape)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(list[i]);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityShape && GetSimEntityByMultiColliders(target) == GetSimEntityByMultiColliders(entityWithEntityID) && entityWithEntityID.entityShape.mShapePartInfo.mCollection == target.entityShape.mShapePartInfo.mCollection)
			{
				return true;
			}
		}
		return false;
	}

	public static SimEntity GetSimEntityByMultiColliders(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		return GetSimEntityByMultiColliders(entityWithEntityID);
	}

	public static SimEntity GetSimEntityByMultiColliders(SimEntity entity)
	{
		if (entity == null)
		{
			return null;
		}
		if (entity.mTag == SimEntity.Tag.MultiColliders)
		{
			return entity.mParent;
		}
		return entity;
	}

	public static int GetTargetShapePart(int targetID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			return entityWithEntityID.entityShape.GetPart();
		}
		return 0;
	}

	public static bool IsInParrying(SimEntity pSimEntity)
	{
		bool flag = pSimEntity.hasEntityActionParrying && pSimEntity.entityActionParrying.IsEnable();
		if (!flag && pSimEntity.hasEntityActionAbility)
		{
			flag = ConfigProcessor.TryGetParryingInfo(pSimEntity.entityActionAbility.mAbilityID, pSimEntity.entityActionAbility.mLogicTime, out var _, out var _);
		}
		return flag;
	}

	public static bool ParryingCheck(SimContext pSimContext, int attackerID, int targetID, int timelineID, int hitIndex, Int3 hitPosition, Int3 hitForward, bool canBeParry, int thrownID = 0, bool postEvent = true)
	{
		if (!canBeParry)
		{
			return false;
		}
		if (!postEvent)
		{
			return false;
		}
		SimEntity simEntityByMultiColliders = GetSimEntityByMultiColliders(targetID);
		if (simEntityByMultiColliders.hasEntityActionParrying && simEntityByMultiColliders.entityActionParrying.IsEnable())
		{
			mSimContext.PostEvent(EntityParrySucceededEvent.Claim(attackerID, simEntityByMultiColliders.creationIndex, timelineID, hitIndex, hitPosition, hitForward, 0, thrownID));
			return true;
		}
		if (!simEntityByMultiColliders.hasEntityActionAbility)
		{
			return false;
		}
		if (!ConfigProcessor.TryGetParryingInfo(simEntityByMultiColliders.entityActionAbility.mAbilityID, simEntityByMultiColliders.entityActionAbility.mLogicTime, out var pParryActionInfo, out var timelineConfig))
		{
			return false;
		}
		bool flag = false;
		if (pParryActionInfo.Angle >= 360000)
		{
			flag = true;
		}
		else
		{
			Int obj = simEntityByMultiColliders.entityPositon.mForwardAngle + new Int(pParryActionInfo.AngleOffset);
			Int obj2 = obj + new Int(pParryActionInfo.Angle);
			Int obj3 = IntMath.AngleOfVector(-hitForward);
			if (obj < 0 || obj2 > 360000)
			{
				if (obj < 0)
				{
					obj += (Int)360000;
				}
				if (obj2 > 360000)
				{
					obj2 -= (Int)360000;
				}
				if ((obj3 >= obj && obj3 <= 360000) || (obj3 >= 0 && obj3 <= obj2))
				{
					flag = true;
				}
			}
			else if (obj3 >= obj && obj3 <= obj2)
			{
				flag = true;
			}
		}
		if (flag)
		{
			int delayTime = 0;
			if (pParryActionInfo != null && pParryActionInfo.HitIndex != -1)
			{
				int mLogicTime = simEntityByMultiColliders.entityActionAbility.mLogicTime;
				if (pParryActionInfo.HitIndex >= 0 && pParryActionInfo.HitIndex < timelineConfig.HitTimeList.Count)
				{
					HitCheckInfo hitCheckInfo = timelineConfig.HitTimeList.get_Item(pParryActionInfo.HitIndex);
					delayTime = hitCheckInfo.Start - mLogicTime;
				}
			}
			mSimContext.PostEvent(EntityParrySucceededEvent.Claim(attackerID, simEntityByMultiColliders.creationIndex, timelineID, hitIndex, hitPosition, hitForward, delayTime, thrownID));
			return true;
		}
		mSimContext.PostEvent(EntityParryFailedEvent.Claim(attackerID, simEntityByMultiColliders.creationIndex, timelineID, hitIndex, hitPosition, hitForward, thrownID));
		return false;
	}

	public static bool InTimelineCantBreakTime(SimEntity simEntity)
	{
		int num = 0;
		Timeline config = null;
		if (simEntity.hasEntityActionAbility)
		{
			int mAbilityID = simEntity.entityActionAbility.mAbilityID;
			ConfigHelper.GetInstance().TryGetConfig<Timeline>(mAbilityID, out config);
			num = simEntity.entityActionAbility.mLogicTime;
		}
		else if (simEntity.hasEntityHitRecover)
		{
			int mHitRecoverActionID = simEntity.entityHitRecover.mHitRecoverActionID;
			ConfigHelper.GetInstance().TryGetConfig<Timeline>(mHitRecoverActionID, out config);
			num = simEntity.entityHitRecover.mHitRecoverTime;
		}
		else if (simEntity.hasEntityActionMoveDirection)
		{
			int mMoveID = simEntity.entityActionMoveDirection.mMoveID;
			ConfigHelper.GetInstance().TryGetConfig<Timeline>(mMoveID, out config);
			num = simEntity.entityActionMoveDirection.mLogicTime;
		}
		if (config == null || config.CantBreakStateInfoList == null)
		{
			return false;
		}
		for (int i = 0; i < config.CantBreakStateInfoList.Count; i++)
		{
			CantBreakStateInfo cantBreakStateInfo = config.CantBreakStateInfoList.get_Item(i);
			if (cantBreakStateInfo.Start <= num && cantBreakStateInfo.Start + cantBreakStateInfo.Duration > num)
			{
				return true;
			}
		}
		return false;
	}

	public static bool HasStrengthenModule(int attributeID, int modID)
	{
		for (int i = 2150; i < 2170; i++)
		{
			AttributeProcessor.GetAttributeWithIntName(attributeID, i, out var baseValue, out var _, out var _);
			if (baseValue == 0L)
			{
				break;
			}
			if (baseValue == modID)
			{
				return true;
			}
		}
		return false;
	}

	public static Int3 Int3Slerp(Int3 from, Int3 to, VFactor maxDegreeDelta)
	{
		maxDegreeDelta = Normalize(maxDegreeDelta);
		VFactor vFactor = Int3.AngleInt(from, to);
		if (vFactor < 0L)
		{
			vFactor = -vFactor;
		}
		IntMath.sincos(out var s, out var c, vFactor);
		maxDegreeDelta *= IntMath.Deg2Rad;
		if (vFactor <= maxDegreeDelta)
		{
			return to;
		}
		if (s == 0L)
		{
			to = ((from.x == 0) ? new Int3(1000, 0, 0) : ((from.y != 0) ? new Int3(0, 0, 1000) : new Int3(from.z, 0, -from.x)));
			s = (VFactor)1f;
			c = (VFactor)0f;
		}
		IntMath.sincos(out var s2, out var c2, maxDegreeDelta);
		VFactor vFactor2 = Normalize(s * c2) - Normalize(c * s2);
		vFactor2 = new VFactor(IntMath.Divide(vFactor2.nom * 10000, vFactor2.den), 10000L);
		VFactor vFactor3 = s2;
		VFactor vFactor4 = s;
		Int3 result = (from * vFactor2 + to * vFactor3) / vFactor4;
		result.NormalizeTo(1000);
		return result;
	}
}
