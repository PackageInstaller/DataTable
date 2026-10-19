using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using UnityEngine;

namespace ACT.World;

internal static class ConfigWorldPartitionSettingDataExtension
{
	private static readonly Dictionary<int, string> MAIN_WORLD_NAMES = new Dictionary<int, string>
	{
		{ 3, "Lumin(3)_v2" },
		{ 4, "Void(4)_v2" }
	};

	public static MainWorldPartition Merge(this ICollection<ConfigWorldPartition_v2_SubworldData> subworldDataList, int worldId)
	{
		List<InteractRule> list = new List<InteractRule>();
		List<SceneChunk> list2 = new List<SceneChunk>();
		List<int> list3 = new List<int>();
		List<Bounds> list4 = new List<Bounds>();
		foreach (ConfigWorldPartition_v2_SubworldData subworldData in subworldDataList)
		{
			list2.AddRange(subworldData.SceneChunks);
			list.AddRange(subworldData.Rules);
			list3.AddRange(subworldData.ChunkBoundsIds);
			list4.AddRange(subworldData.ChunkBoundsDatas);
		}
		MainWorldPartition mainWorldPartition = ScriptableObject.CreateInstance<MainWorldPartition>();
		mainWorldPartition.Setup(worldId, list2, list, list3, list4);
		mainWorldPartition.GenerateMaterialTrackTransferData();
		if (MAIN_WORLD_NAMES.TryGetValue(worldId, out var value))
		{
			mainWorldPartition.name = value;
		}
		else
		{
			mainWorldPartition.name = $"MainWorld({worldId})_v2";
		}
		return mainWorldPartition;
	}
}
