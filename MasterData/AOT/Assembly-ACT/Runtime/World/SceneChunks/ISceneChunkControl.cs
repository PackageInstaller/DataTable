namespace Runtime.World.SceneChunks;

public interface ISceneChunkControl
{
	int WorldConfigId { get; }

	int ChunkId { get; }

	int MapId { get; }

	int AreaId { get; }
}
