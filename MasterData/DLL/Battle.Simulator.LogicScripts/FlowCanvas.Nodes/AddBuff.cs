using Config;

namespace FlowCanvas.Nodes;

public class AddBuff
{
	private static bool AddBuffWithConfigIDBase(SimContext simContext, int casterID, int targetID, int configID, int buffClassID, int delay, int keepTime, int tick, int level, bool isOverride, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(configID);
		buffClassID = ((buffClassID != -1) ? buffClassID : config.BuffClassId);
		delay = ((delay != -1) ? delay : config.Delaytime);
		keepTime = ((keepTime != -1) ? keepTime : (config.KeepTime + (level - 1) * config.KeepTimeGrow));
		tick = ((tick != -1) ? tick : config.BuffTicktime);
		bool flag = false;
		if (!BuffProcessor.HasTargetConfigIDBuff(entityWithEntityID, configID))
		{
			flag = BuffProcessor.TryAddBuff(casterID, targetID, buffClassID, delay, keepTime, tick, isOnce: false, isLoop: false, isOverride, param1, param2, param3, param4, configID, level, out var _);
		}
		else
		{
			BuffProcessor.RemoveBuffByConfigID(entityWithEntityID.creationIndex, configID);
			flag = BuffProcessor.TryAddBuff(casterID, targetID, buffClassID, delay, keepTime, tick, isOnce: false, isLoop: false, isOverride, param1, param2, param3, param4, configID, level, out var _);
		}
		if (!flag)
		{
			return false;
		}
		return true;
	}

	public static bool AddBuffWithConfigIDOverride(SimContext simContext, int casterID, int targetID, int configID, int level, int keepTime, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		return AddBuffWithConfigIDBase(simContext, casterID, targetID, configID, -1, -1, keepTime, -1, level, isOverride: true, param1, param2, param3, param4);
	}

	public static bool AddBuffWithConfigID(SimContext simContext, int casterID, int targetID, int configID, int level, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		return AddBuffWithConfigIDBase(simContext, casterID, targetID, configID, -1, -1, -1, -1, level, isOverride: false, param1, param2, param3, param4);
	}

	public static bool AddBuffWithConfigIDWithKeepTime(SimContext simContext, int casterID, int targetID, int configID, int level, int keepTime, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		return AddBuffWithConfigIDBase(simContext, casterID, targetID, configID, -1, -1, keepTime, -1, level, isOverride: false, param1, param2, param3, param4);
	}

	public static bool AddBuffWithConfigID(SimContext simContext, int casterID, int targetID, int configID, int buffClassID, int delay, int tick, int level, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		return AddBuffWithConfigIDBase(simContext, casterID, targetID, configID, buffClassID, delay, -1, tick, level, isOverride: false, param1, param2, param3, param4);
	}

	public static bool AddBuffWithConfigIDUpdateKeepTime(SimContext simContext, int casterID, int targetID, int configID, int delay, int keepTime, int level, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		return AddBuffWithConfigIDBase(simContext, casterID, targetID, configID, -1, delay, keepTime, -1, level, isOverride: false, param1, param2, param3, param4);
	}

	public static int GetBuffClassIDIndex(int classID, SimEntity entity)
	{
		int result = -1;
		for (int i = 0; i < entity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (entity.entityBuff.mBuffClassIDArray[i] == classID && !entity.entityBuff.IsInPendingRemoveArray(entity.entityBuff.mBuffID[i]))
			{
				result = i;
				break;
			}
		}
		return result;
	}
}
