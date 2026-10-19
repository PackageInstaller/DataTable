using System;

namespace ACT.World;

[Serializable]
internal class WorldMapGraphDataReference : YooAssetReference<ConfigWorldMapGraphData>
{
	public WorldMapGraphDataReference(string guid)
		: base(guid)
	{
	}
}
