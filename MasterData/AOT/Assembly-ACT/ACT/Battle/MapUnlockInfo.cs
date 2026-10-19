using System.Collections.Generic;
using ACT.World;
using ACT.World.Asset;
using Fundamental;

namespace ACT.Battle;

public class MapUnlockInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 2)
		{
			int num = param[0];
			_ = param[1];
			Dictionary<int, TemporaryPortalData> dictionary = Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas<TemporaryPortalData>();
			if (dictionary.Count != 0)
			{
				foreach (TemporaryPortalData value in dictionary.Values)
				{
					if (value.mapArea == (MapArea)num && value.stateId == 0)
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 1f;
	}

	public override int GetCompleteCount(int[] param)
	{
		return 1;
	}

	public override int GetNeedCount(int[] param)
	{
		return 1;
	}
}
