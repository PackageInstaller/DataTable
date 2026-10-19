using System.Collections.Generic;
using System.Linq;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using UnityEngine;

namespace ACT.World;

internal class MainWorldPartition : ConfigWorldPartition_v2
{
	public void Setup(int id, ICollection<SceneChunk> worldChunks, ICollection<InteractRule> worldRules, List<int> allChunkBoundsIds, List<Bounds> allChunkBoundsDatas)
	{
		Setup(id);
		_sceneChunks = worldChunks.ToArray();
		_rules = new List<InteractRule>();
		_rules.AddRange(worldRules);
		_chunkBoundsIds.AddRange(allChunkBoundsIds);
		_chunkBoundsDatas.AddRange(allChunkBoundsDatas);
	}
}
