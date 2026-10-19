namespace ACT.World;

public interface ILoadPartitionResult<T> where T : IBakedWorldData
{
	bool Success { get; }

	T Data { get; }
}
