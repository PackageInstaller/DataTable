using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

internal class DecalEntityIndexer
{
	public struct DecalEntityItem
	{
		public int chunkIndex;

		public int arrayIndex;

		public int version;
	}

	private List<DecalEntityItem> m_Entities = new List<DecalEntityItem>();

	private Queue<int> m_FreeIndices = new Queue<int>();

	public bool IsValid(DecalEntity decalEntity)
	{
		if (m_Entities.Count <= decalEntity.index)
		{
			return false;
		}
		return m_Entities[decalEntity.index].version == decalEntity.version;
	}

	public DecalEntity CreateDecalEntity(int arrayIndex, int chunkIndex)
	{
		if (m_FreeIndices.Count != 0)
		{
			int index = m_FreeIndices.Dequeue();
			int version = m_Entities[index].version + 1;
			m_Entities[index] = new DecalEntityItem
			{
				arrayIndex = arrayIndex,
				chunkIndex = chunkIndex,
				version = version
			};
			return new DecalEntity
			{
				index = index,
				version = version
			};
		}
		int count = m_Entities.Count;
		int version2 = 1;
		m_Entities.Add(new DecalEntityItem
		{
			arrayIndex = arrayIndex,
			chunkIndex = chunkIndex,
			version = version2
		});
		return new DecalEntity
		{
			index = count,
			version = version2
		};
	}

	public void DestroyDecalEntity(DecalEntity decalEntity)
	{
		m_FreeIndices.Enqueue(decalEntity.index);
		DecalEntityItem value = m_Entities[decalEntity.index];
		value.version++;
		m_Entities[decalEntity.index] = value;
	}

	public DecalEntityItem GetItem(DecalEntity decalEntity)
	{
		return m_Entities[decalEntity.index];
	}

	public void UpdateIndex(DecalEntity decalEntity, int newArrayIndex)
	{
		DecalEntityItem value = m_Entities[decalEntity.index];
		value.arrayIndex = newArrayIndex;
		value.version = decalEntity.version;
		m_Entities[decalEntity.index] = value;
	}

	public void RemapChunkIndices(List<int> remaper)
	{
		for (int i = 0; i < m_Entities.Count; i++)
		{
			int chunkIndex = remaper[m_Entities[i].chunkIndex];
			DecalEntityItem value = m_Entities[i];
			value.chunkIndex = chunkIndex;
			m_Entities[i] = value;
		}
	}

	public void Clear()
	{
		m_Entities.Clear();
		m_FreeIndices.Clear();
	}
}
