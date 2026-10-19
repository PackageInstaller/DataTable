using System.Collections.Generic;
using ACT.World.Asset;

namespace ACT.World;

public interface IConfigWorldPartition
{
	List<InteractRule> Rules { get; }

	Dictionary<int, NPCPointData> NpcStateAssetDatas { get; }

	List<RoomData> RoomDatas { get; }

	Dictionary<int, int> NpcDictionary { get; }

	YooAssetReference WorldBluePrintAssetID { get; }
}
