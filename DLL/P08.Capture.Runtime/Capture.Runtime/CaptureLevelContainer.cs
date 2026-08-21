using System.Collections.Generic;

namespace Capture.Runtime;

public class CaptureLevelContainer
{
	private int versionCode;

	private List<CaptureEntity> objects = new List<CaptureEntity>();

	private Dictionary<int, int> versionIdx = new Dictionary<int, int>();

	private Dictionary<int, HashSet<int>> chunk = new Dictionary<int, HashSet<int>>();

	private ComponnetChunkAdaptor queryChunk = new ComponnetChunkAdaptor();

	public void InsertObject(CaptureEntity obj)
	{
		obj.Identify = versionCode++;
		objects.Add(obj);
		versionIdx.Add(obj.Identify, objects.Count - 1);
		UpdateEntityArch(obj);
	}

	public void RemoveObj(CaptureEntity obj)
	{
		RemoveEntity(obj.Identify);
	}

	public void RemoveEntity(int entityId)
	{
		if (versionIdx.ContainsKey(entityId))
		{
			int idx = versionIdx[entityId];
			Swap(idx, objects.Count - 1);
			CaptureEntity captureEntity = objects[objects.Count - 1];
			if (captureEntity.ArcheType.type != 0)
			{
				chunk[captureEntity.ArcheType.type].Remove(captureEntity.Identify);
				queryChunk.RemoveEntity(captureEntity);
			}
			objects.RemoveAt(objects.Count - 1);
			versionIdx.Remove(entityId);
		}
	}

	public CaptureEntity GetEntity(int entityId)
	{
		if (versionIdx.TryGetValue(entityId, out var value))
		{
			return objects[value];
		}
		return null;
	}

	private void Swap(int idx1, int idx2)
	{
		CaptureEntity captureEntity = objects[idx1];
		CaptureEntity captureEntity2 = objects[idx2];
		objects[idx1] = captureEntity2;
		objects[idx2] = captureEntity;
		versionIdx[captureEntity.Identify] = idx2;
		versionIdx[captureEntity2.Identify] = idx1;
	}

	private void UpdateEntityArch(CaptureEntity entity)
	{
		if (entity.ArcheType.type != 0)
		{
			HashSet<int> value = null;
			if (!chunk.TryGetValue(entity.ArcheType.type, out value))
			{
				value = new HashSet<int>();
				chunk.Add(entity.ArcheType.type, value);
			}
			value.Add(entity.Identify);
			queryChunk.InsertEntity(entity);
		}
	}

	public HashSet<int> GetEntitiesByArch(EntityArcheType arch)
	{
		HashSet<int> value = null;
		chunk.TryGetValue(arch.type, out value);
		return value;
	}

	public HashSet<int> GetContainsArchEntities(ComponentChunkEnum chunkEnum)
	{
		return queryChunk.GetEntities(chunkEnum);
	}
}
