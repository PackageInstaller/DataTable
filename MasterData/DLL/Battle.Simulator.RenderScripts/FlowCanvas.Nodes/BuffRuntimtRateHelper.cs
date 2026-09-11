using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public class BuffRuntimtRateHelper
{
	public static bool TryGetBuffRuntimeRate(BattleScene battleScene, int agentID, int buffID, out float rate, int enterTime = -1, int exitTime = -1)
	{
		List<BuffState> buffList = null;
		if (!battleScene.GetBuffManager().TryGetBuffListByAgentID(agentID, out buffList))
		{
			rate = 0f;
			return false;
		}
		for (int i = 0; i < buffList.Count; i++)
		{
			if (buffList[i].mBuffID != buffID)
			{
				continue;
			}
			if (enterTime > 0 && exitTime > 0 && enterTime + exitTime < buffList[i].mBuffKeepTime)
			{
				int num = buffList[i].mBuffKeepTime - buffList[i].mDuring;
				if (num <= enterTime)
				{
					rate = (float)num / (float)enterTime * 0.5f;
					return true;
				}
				if (buffList[i].mDuring <= exitTime)
				{
					rate = (float)(exitTime - buffList[i].mDuring) / (float)exitTime * 0.5f + 0.5f;
					return true;
				}
				rate = 0.5f;
				return true;
			}
			if (buffList[i].mBuffKeepTime == 0)
			{
				rate = 0f;
				return true;
			}
			rate = 1f - (float)buffList[i].mDuring / (float)buffList[i].mBuffKeepTime;
			return true;
		}
		rate = 0f;
		return false;
	}
}
