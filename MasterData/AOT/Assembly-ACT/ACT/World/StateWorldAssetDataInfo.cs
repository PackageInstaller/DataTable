using ACT.World.Asset;

namespace ACT.World;

internal struct StateWorldAssetDataInfo<T>(int chunkId, int subMapAreaId, int mapAreaId, T data) where T : StateWorldAssetData
{
	public readonly int ChunkId = chunkId;

	public readonly int SubMapAreaId = subMapAreaId;

	public readonly int MapAreaId = mapAreaId;

	public readonly T Data = data;
}
