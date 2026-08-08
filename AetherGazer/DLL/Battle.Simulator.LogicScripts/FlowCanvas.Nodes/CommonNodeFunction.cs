using System.Collections.Generic;
using Config;
using NodeCanvas.Framework;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class CommonNodeFunction
{
	public static int GetTargetAbilityFirstHitRange(int abilityID)
	{
		int result = 0;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
		if (config != null && config.HitTimeList.Count > 0)
		{
			HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(0);
			switch (hitCheckInfo.RangeType)
			{
			case RangeType.Sector:
			case RangeType.Roundness:
				result = hitCheckInfo.Radius;
				break;
			case RangeType.Rectangle:
				result = hitCheckInfo.Length;
				break;
			}
		}
		return result;
	}

	public static bool EntityCounterUpdate(SimEntity entity, int name, int interval, int delta)
	{
		int mID = entity.entityID.mID;
		if (CommonProcessor.EntityHasEntityTimer(entity.entityID.mID, name))
		{
			SimBlackboard.EntityCounterStruct value = entity.entityBlackboard.var.timer[name];
			value.intervalConfig = interval;
			entity.entityBlackboard.var.timer[name] = value;
			if (CommonProcessor.EntityTimerUpdate(mID, name, delta))
			{
				return true;
			}
			return false;
		}
		if (!CommonProcessor.EntityAddEntityTimer(mID, name, interval))
		{
			Debug.Log("添加计时器失败");
		}
		return false;
	}

	public static void ResetAIState(int entityID, int name)
	{
	}

	public static int GetCurrentShortAbilityID(SimEntity entity)
	{
		if (!entity.hasEntityActionAbility)
		{
			return 0;
		}
		int mId = entity.entityConfig.mId;
		return entity.entityActionAbility.mAbilityID % (mId * 1000);
	}

	public static int GetNextShortAbilityID(SimEntity entity)
	{
		if (!entity.hasEntityActionAbilityLogicInput)
		{
			return 0;
		}
		int mId = entity.entityConfig.mId;
		return entity.entityActionAbilityLogicInput.mBrokenAbilityID % (mId * 1000);
	}

	public static int GetLastPlayerID(SimContext mSimContext)
	{
		Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
		int result = SpawnProcessor.GetLocalPlayerID();
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int mEntityID = enumerator.Current.Value.mEntityID;
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp && RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp) && (!entityWithEntityID.hasEntityAIThink || entityWithEntityID.entityBlackboard.var.mAIID == 0))
			{
				result = mEntityID;
			}
		}
		return result;
	}

	public static int GetAbilityLevel(Graph graph, int attributeID, int abilityID, int thrownID)
	{
		DamageFormula.GetRootAbilityID(abilityID, thrownID, ClientSimulator.Instance.mSimContext, out var rootabilityID);
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
		int num = config.SkillIndex - 1;
		long baseValue = 1L;
		if (config.SkillIndex != -1)
		{
			if (num == -1)
			{
				num = ConfigHelper.GetInstance().GetConfig<public_skill>(rootabilityID).SkillIndex - 1;
			}
			if (num != -1)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeID, 2120 + num, out baseValue, out var _, out var _);
			}
		}
		if (baseValue != 0L)
		{
			return (int)baseValue;
		}
		return 1;
	}

	public static int GetRootAbilityID(Graph graph, int abilityID, int thrownID)
	{
		if (thrownID != 0)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(ClientSimulator.Instance.mSimContext, thrownID, out thrownState))
			{
				return abilityID;
			}
			abilityID = thrownState.mCreatedRootTimelineID;
		}
		return abilityID;
	}
}
