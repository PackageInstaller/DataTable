using System;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Mathematics;

namespace UnityEngine.Rendering.Universal;

internal class DecalEntityManager : IDisposable
{
	private struct CombinedChunks
	{
		public DecalEntityChunk entityChunk;

		public DecalCachedChunk cachedChunk;

		public DecalCulledChunk culledChunk;

		public DecalDrawCallChunk drawCallChunk;

		public int previousChunkIndex;

		public bool valid;
	}

	public List<DecalEntityChunk> entityChunks = new List<DecalEntityChunk>();

	public List<DecalCachedChunk> cachedChunks = new List<DecalCachedChunk>();

	public List<DecalCulledChunk> culledChunks = new List<DecalCulledChunk>();

	public List<DecalDrawCallChunk> drawCallChunks = new List<DecalDrawCallChunk>();

	public int chunkCount;

	private ProfilingSampler m_AddDecalSampler;

	private ProfilingSampler m_ResizeChunks;

	private ProfilingSampler m_SortChunks;

	private DecalEntityIndexer m_DecalEntityIndexer = new DecalEntityIndexer();

	private Dictionary<Material, int> m_MaterialToChunkIndex = new Dictionary<Material, int>();

	private List<CombinedChunks> m_CombinedChunks = new List<CombinedChunks>();

	private List<int> m_CombinedChunkRemmap = new List<int>();

	private Material m_ErrorMaterial;

	private Mesh m_DecalProjectorMesh;

	public Material errorMaterial
	{
		get
		{
			if (m_ErrorMaterial == null)
			{
				m_ErrorMaterial = CoreUtils.CreateEngineMaterial(Shader.Find("Hidden/InternalErrorShader"));
			}
			return m_ErrorMaterial;
		}
	}

	public Mesh decalProjectorMesh
	{
		get
		{
			if (m_DecalProjectorMesh == null)
			{
				m_DecalProjectorMesh = CoreUtils.CreateCubeMesh(new Vector4(-0.5f, -0.5f, -0.5f, 1f), new Vector4(0.5f, 0.5f, 0.5f, 1f));
			}
			return m_DecalProjectorMesh;
		}
	}

	public DecalEntityManager()
	{
		m_AddDecalSampler = new ProfilingSampler("DecalEntityManager.CreateDecalEntity");
		m_ResizeChunks = new ProfilingSampler("DecalEntityManager.ResizeChunks");
		m_SortChunks = new ProfilingSampler("DecalEntityManager.SortChunks");
	}

	public bool IsValid(DecalEntity decalEntity)
	{
		return m_DecalEntityIndexer.IsValid(decalEntity);
	}

	public DecalEntity CreateDecalEntity(DecalProjector decalProjector)
	{
		Material material = decalProjector.material;
		if (material == null)
		{
			material = errorMaterial;
		}
		using (new ProfilingScope(null, m_AddDecalSampler))
		{
			int num = CreateChunkIndex(material);
			int count = entityChunks[num].count;
			DecalEntity decalEntity = m_DecalEntityIndexer.CreateDecalEntity(count, num);
			DecalEntityChunk decalEntityChunk = entityChunks[num];
			DecalCachedChunk decalCachedChunk = cachedChunks[num];
			DecalCulledChunk decalCulledChunk = culledChunks[num];
			DecalDrawCallChunk decalDrawCallChunk = drawCallChunks[num];
			if (entityChunks[num].capacity == entityChunks[num].count)
			{
				using (new ProfilingScope(null, m_ResizeChunks))
				{
					int y = entityChunks[num].capacity + entityChunks[num].capacity;
					y = math.max(8, y);
					decalEntityChunk.SetCapacity(y);
					decalCachedChunk.SetCapacity(y);
					decalCulledChunk.SetCapacity(y);
					decalDrawCallChunk.SetCapacity(y);
				}
			}
			decalEntityChunk.Push();
			decalCachedChunk.Push();
			decalCulledChunk.Push();
			decalDrawCallChunk.Push();
			decalEntityChunk.decalProjectors[count] = decalProjector;
			decalEntityChunk.decalEntities[count] = decalEntity;
			decalEntityChunk.transformAccessArray.Add(decalProjector.transform);
			UpdateDecalEntityData(decalEntity, decalProjector);
			return decalEntity;
		}
	}

	private int CreateChunkIndex(Material material)
	{
		if (!m_MaterialToChunkIndex.TryGetValue(material, out var value))
		{
			MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
			materialPropertyBlock.SetMatrixArray("_NormalToWorld", new Matrix4x4[64]);
			entityChunks.Add(new DecalEntityChunk
			{
				material = material
			});
			cachedChunks.Add(new DecalCachedChunk
			{
				propertyBlock = materialPropertyBlock
			});
			culledChunks.Add(new DecalCulledChunk());
			drawCallChunks.Add(new DecalDrawCallChunk
			{
				subCallCounts = new NativeArray<int>(1, Allocator.Persistent)
			});
			m_CombinedChunks.Add(default);
			m_CombinedChunkRemmap.Add(0);
			m_MaterialToChunkIndex.Add(material, chunkCount);
			return chunkCount++;
		}
		return value;
	}

	public void UpdateDecalEntityData(DecalEntity decalEntity, DecalProjector decalProjector)
	{
		DecalEntityIndexer.DecalEntityItem item = m_DecalEntityIndexer.GetItem(decalEntity);
		int chunkIndex = item.chunkIndex;
		int arrayIndex = item.arrayIndex;
		DecalCachedChunk decalCachedChunk = cachedChunks[chunkIndex];
		decalCachedChunk.sizeOffsets[arrayIndex] = Matrix4x4.Translate(decalProjector.decalOffset) * Matrix4x4.Scale(decalProjector.decalSize);
		float drawDistance = decalProjector.drawDistance;
		float fadeScale = decalProjector.fadeScale;
		float startAngleFade = decalProjector.startAngleFade;
		float endAngleFade = decalProjector.endAngleFade;
		Vector4 uvScaleBias = decalProjector.uvScaleBias;
		int layer = decalProjector.gameObject.layer;
		ulong sceneCullingMask = decalProjector.gameObject.sceneCullingMask;
		float fadeFactor = decalProjector.fadeFactor;
		decalCachedChunk.drawDistances[arrayIndex] = new Vector2(drawDistance, fadeScale);
		if (startAngleFade == 180f)
		{
			decalCachedChunk.angleFades[arrayIndex] = new Vector2(0f, 0f);
		}
		else
		{
			float num = startAngleFade / 180f;
			float num2 = endAngleFade / 180f;
			float num3 = Mathf.Max(0.0001f, num2 - num);
			decalCachedChunk.angleFades[arrayIndex] = new Vector2(1f - (0.25f - num) / num3, -0.25f / num3);
		}
		decalCachedChunk.uvScaleBias[arrayIndex] = uvScaleBias;
		decalCachedChunk.layerMasks[arrayIndex] = layer;
		decalCachedChunk.sceneLayerMasks[arrayIndex] = sceneCullingMask;
		decalCachedChunk.fadeFactors[arrayIndex] = fadeFactor;
		decalCachedChunk.scaleModes[arrayIndex] = decalProjector.scaleMode;
		decalCachedChunk.positions[arrayIndex] = decalProjector.transform.position;
		decalCachedChunk.rotation[arrayIndex] = decalProjector.transform.rotation;
		decalCachedChunk.scales[arrayIndex] = decalProjector.transform.lossyScale;
		decalCachedChunk.dirty[arrayIndex] = true;
	}

	public void DestroyDecalEntity(DecalEntity decalEntity)
	{
		if (m_DecalEntityIndexer.IsValid(decalEntity))
		{
			DecalEntityIndexer.DecalEntityItem item = m_DecalEntityIndexer.GetItem(decalEntity);
			m_DecalEntityIndexer.DestroyDecalEntity(decalEntity);
			int chunkIndex = item.chunkIndex;
			int arrayIndex = item.arrayIndex;
			DecalEntityChunk decalEntityChunk = entityChunks[chunkIndex];
			DecalCachedChunk decalCachedChunk = cachedChunks[chunkIndex];
			DecalCulledChunk decalCulledChunk = culledChunks[chunkIndex];
			DecalDrawCallChunk decalDrawCallChunk = drawCallChunks[chunkIndex];
			int num = decalEntityChunk.count - 1;
			if (arrayIndex != num)
			{
				m_DecalEntityIndexer.UpdateIndex(decalEntityChunk.decalEntities[num], arrayIndex);
			}
			decalEntityChunk.RemoveAtSwapBack(arrayIndex);
			decalCachedChunk.RemoveAtSwapBack(arrayIndex);
			decalCulledChunk.RemoveAtSwapBack(arrayIndex);
			decalDrawCallChunk.RemoveAtSwapBack(arrayIndex);
		}
	}

	public void Update()
	{
		using (new ProfilingScope(null, m_SortChunks))
		{
			for (int i = 0; i < chunkCount; i++)
			{
				if (entityChunks[i].material == null)
				{
					entityChunks[i].material = errorMaterial;
				}
			}
			for (int j = 0; j < chunkCount; j++)
			{
				m_CombinedChunks[j] = new CombinedChunks
				{
					entityChunk = entityChunks[j],
					cachedChunk = cachedChunks[j],
					culledChunk = culledChunks[j],
					drawCallChunk = drawCallChunks[j],
					previousChunkIndex = j,
					valid = (entityChunks[j].count != 0)
				};
			}
			m_CombinedChunks.Sort((CombinedChunks a, CombinedChunks b) =>
			{
				if (a.valid && !b.valid)
				{
					return -1;
				}
				if (!a.valid && b.valid)
				{
					return 1;
				}
				if (a.cachedChunk.drawOrder < b.cachedChunk.drawOrder)
				{
					return -1;
				}
				return (a.cachedChunk.drawOrder > b.cachedChunk.drawOrder) ? 1 : a.entityChunk.material.GetHashCode().CompareTo(b.entityChunk.material.GetHashCode());
			});
			bool flag = false;
			for (int num = 0; num < chunkCount; num++)
			{
				if (m_CombinedChunks[num].previousChunkIndex != num || !m_CombinedChunks[num].valid)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return;
			}
			int num2 = 0;
			m_MaterialToChunkIndex.Clear();
			for (int num3 = 0; num3 < chunkCount; num3++)
			{
				CombinedChunks combinedChunks = m_CombinedChunks[num3];
				if (!m_CombinedChunks[num3].valid)
				{
					combinedChunks.entityChunk.currentJobHandle.Complete();
					combinedChunks.cachedChunk.currentJobHandle.Complete();
					combinedChunks.culledChunk.currentJobHandle.Complete();
					combinedChunks.drawCallChunk.currentJobHandle.Complete();
					combinedChunks.entityChunk.Dispose();
					combinedChunks.cachedChunk.Dispose();
					combinedChunks.culledChunk.Dispose();
					combinedChunks.drawCallChunk.Dispose();
					continue;
				}
				entityChunks[num3] = combinedChunks.entityChunk;
				cachedChunks[num3] = combinedChunks.cachedChunk;
				culledChunks[num3] = combinedChunks.culledChunk;
				drawCallChunks[num3] = combinedChunks.drawCallChunk;
				if (!m_MaterialToChunkIndex.ContainsKey(entityChunks[num3].material))
				{
					m_MaterialToChunkIndex.Add(entityChunks[num3].material, num3);
				}
				m_CombinedChunkRemmap[combinedChunks.previousChunkIndex] = num3;
				num2++;
			}
			if (chunkCount > num2)
			{
				entityChunks.RemoveRange(num2, chunkCount - num2);
				cachedChunks.RemoveRange(num2, chunkCount - num2);
				culledChunks.RemoveRange(num2, chunkCount - num2);
				drawCallChunks.RemoveRange(num2, chunkCount - num2);
				m_CombinedChunks.RemoveRange(num2, chunkCount - num2);
				chunkCount = num2;
			}
			m_DecalEntityIndexer.RemapChunkIndices(m_CombinedChunkRemmap);
		}
	}

	public void Dispose()
	{
		CoreUtils.Destroy(m_ErrorMaterial);
		CoreUtils.Destroy(m_DecalProjectorMesh);
		foreach (DecalEntityChunk entityChunk in entityChunks)
		{
			entityChunk.currentJobHandle.Complete();
		}
		foreach (DecalCachedChunk cachedChunk in cachedChunks)
		{
			cachedChunk.currentJobHandle.Complete();
		}
		foreach (DecalCulledChunk culledChunk in culledChunks)
		{
			culledChunk.currentJobHandle.Complete();
		}
		foreach (DecalDrawCallChunk drawCallChunk in drawCallChunks)
		{
			drawCallChunk.currentJobHandle.Complete();
		}
		foreach (DecalEntityChunk entityChunk2 in entityChunks)
		{
			entityChunk2.Dispose();
		}
		foreach (DecalCachedChunk cachedChunk2 in cachedChunks)
		{
			cachedChunk2.Dispose();
		}
		foreach (DecalCulledChunk culledChunk2 in culledChunks)
		{
			culledChunk2.Dispose();
		}
		foreach (DecalDrawCallChunk drawCallChunk2 in drawCallChunks)
		{
			drawCallChunk2.Dispose();
		}
		m_DecalEntityIndexer.Clear();
		m_MaterialToChunkIndex.Clear();
		entityChunks.Clear();
		cachedChunks.Clear();
		culledChunks.Clear();
		drawCallChunks.Clear();
		m_CombinedChunks.Clear();
		chunkCount = 0;
	}
}
