using System.Collections.Generic;

namespace Capture.Runtime;

public class ComponnetChunkAdaptor
{
	private Dictionary<int, HashSet<ComponentChunkEnum>> queryChunk = new Dictionary<int, HashSet<ComponentChunkEnum>>();

	private Dictionary<ComponentChunkEnum, HashSet<int>> queryChunkList = new Dictionary<ComponentChunkEnum, HashSet<int>>();

	private Dictionary<ComponentChunkEnum, HashSet<int>> aboutChunkEntities = new Dictionary<ComponentChunkEnum, HashSet<int>>();

	public ComponnetChunkAdaptor()
	{
		for (int i = 0; i < ComponnetChunk.QueryChunks.Count; i++)
		{
			queryChunkList.Add(ComponnetChunk.QueryChunks[i], new HashSet<int>());
			aboutChunkEntities.Add(ComponnetChunk.QueryChunks[i], new HashSet<int>());
		}
	}

	public HashSet<int> GetArchTypeListByChunk(ComponentChunkEnum chunk)
	{
		queryChunkList.TryGetValue(chunk, out var value);
		return value;
	}

	public HashSet<int> GetEntities(ComponentChunkEnum chunk)
	{
		return aboutChunkEntities[chunk];
	}

	public void InsertEntity(CaptureEntity entity)
	{
		if (!queryChunk.TryGetValue(entity.ArcheType.type, out var value))
		{
			queryChunk[entity.ArcheType.type] = new HashSet<ComponentChunkEnum>();
			{
				foreach (ComponentChunkEnum queryChunk in ComponnetChunk.QueryChunks)
				{
					if ((ComponnetChunk.GetChunkTemplate(queryChunk) & entity.ArcheType.type) == ComponnetChunk.GetChunkTemplate(queryChunk))
					{
						this.queryChunk[entity.ArcheType.type].Add(queryChunk);
						queryChunkList[queryChunk].Add(entity.ArcheType.type);
						aboutChunkEntities[queryChunk].Add(entity.Identify);
					}
				}
				return;
			}
		}
		foreach (ComponentChunkEnum item in value)
		{
			aboutChunkEntities[item].Add(entity.Identify);
		}
	}

	public void RemoveEntity(CaptureEntity entity)
	{
		foreach (ComponentChunkEnum item in queryChunk[entity.ArcheType.type])
		{
			aboutChunkEntities[item].Remove(entity.Identify);
		}
	}
}
