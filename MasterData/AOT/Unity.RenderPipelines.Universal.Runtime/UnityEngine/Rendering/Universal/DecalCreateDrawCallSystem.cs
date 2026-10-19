using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace UnityEngine.Rendering.Universal;

internal class DecalCreateDrawCallSystem
{
	[BurstCompile]
	private struct DrawCallJob : IJob
	{
		[ReadOnly]
		public NativeArray<float4x4> decalToWorlds;

		[ReadOnly]
		public NativeArray<float4x4> normalToWorlds;

		[ReadOnly]
		public NativeArray<float4x4> sizeOffsets;

		[ReadOnly]
		public NativeArray<float2> drawDistances;

		[ReadOnly]
		public NativeArray<float2> angleFades;

		[ReadOnly]
		public NativeArray<float4> uvScaleBiases;

		[ReadOnly]
		public NativeArray<int> layerMasks;

		[ReadOnly]
		public NativeArray<ulong> sceneLayerMasks;

		[ReadOnly]
		public NativeArray<float> fadeFactors;

		[ReadOnly]
		public NativeArray<BoundingSphere> boundingSpheres;

		public Vector3 cameraPosition;

		public ulong sceneCullingMask;

		public int cullingMask;

		[ReadOnly]
		public NativeArray<int> visibleDecalIndices;

		public int visibleDecalCount;

		public float maxDrawDistance;

		[WriteOnly]
		public NativeArray<float4x4> decalToWorldsDraw;

		[WriteOnly]
		public NativeArray<float4x4> normalToDecalsDraw;

		[WriteOnly]
		public NativeArray<DecalSubDrawCall> subCalls;

		[WriteOnly]
		public NativeArray<int> subCallCount;

		public void Execute()
		{
			int value = 0;
			int num = 0;
			int num2 = 0;
			for (int i = 0; i < visibleDecalCount; i++)
			{
				int index = visibleDecalIndices[i];
				int num3 = 1 << layerMasks[index];
				if ((cullingMask & num3) == 0)
				{
					continue;
				}
				BoundingSphere boundingSphere = boundingSpheres[index];
				float2 float5 = drawDistances[index];
				float magnitude = (cameraPosition - boundingSphere.position).magnitude;
				float num4 = math.min(float5.x, maxDrawDistance) + boundingSphere.radius;
				if (!(magnitude > num4))
				{
					decalToWorldsDraw[num] = decalToWorlds[index];
					float num5 = fadeFactors[index];
					float2 float6 = angleFades[index];
					float4 float7 = uvScaleBiases[index];
					float4x4 value2 = normalToWorlds[index];
					float num6 = num5 * math.clamp((num4 - magnitude) / (num4 * (1f - float5.y)), 0f, 1f);
					value2.c0.w = float7.x;
					value2.c1.w = float7.y;
					value2.c2.w = float7.z;
					value2.c3 = new float4(num6 * 1f, float6.x, float6.y, float7.w);
					normalToDecalsDraw[num] = value2;
					num++;
					if (num - num2 >= 64)
					{
						subCalls[value++] = new DecalSubDrawCall
						{
							start = num2,
							end = num
						};
						num2 = num;
					}
				}
			}
			if (num - num2 != 0)
			{
				subCalls[value++] = new DecalSubDrawCall
				{
					start = num2,
					end = num
				};
			}
			subCallCount[0] = value;
		}
	}

	private DecalEntityManager m_EntityManager;

	private ProfilingSampler m_Sampler;

	private float m_MaxDrawDistance;

	public float maxDrawDistance
	{
		get
		{
			return m_MaxDrawDistance;
		}
		set
		{
			m_MaxDrawDistance = value;
		}
	}

	public DecalCreateDrawCallSystem(DecalEntityManager entityManager, float maxDrawDistance)
	{
		m_EntityManager = entityManager;
		m_Sampler = new ProfilingSampler("DecalCreateDrawCallSystem.Execute");
		m_MaxDrawDistance = maxDrawDistance;
	}

	public void Execute()
	{
		using (new ProfilingScope(null, m_Sampler))
		{
			for (int i = 0; i < m_EntityManager.chunkCount; i++)
			{
				Execute(m_EntityManager.cachedChunks[i], m_EntityManager.culledChunks[i], m_EntityManager.drawCallChunks[i], m_EntityManager.cachedChunks[i].count);
			}
		}
	}

	private void Execute(DecalCachedChunk cachedChunk, DecalCulledChunk culledChunk, DecalDrawCallChunk drawCallChunk, int count)
	{
		if (count != 0)
		{
			JobHandle currentJobHandle = (drawCallChunk.currentJobHandle = new DrawCallJob
			{
				decalToWorlds = cachedChunk.decalToWorlds,
				normalToWorlds = cachedChunk.normalToWorlds,
				sizeOffsets = cachedChunk.sizeOffsets,
				drawDistances = cachedChunk.drawDistances,
				angleFades = cachedChunk.angleFades,
				uvScaleBiases = cachedChunk.uvScaleBias,
				layerMasks = cachedChunk.layerMasks,
				sceneLayerMasks = cachedChunk.sceneLayerMasks,
				fadeFactors = cachedChunk.fadeFactors,
				boundingSpheres = cachedChunk.boundingSpheres,
				cameraPosition = culledChunk.cameraPosition,
				sceneCullingMask = culledChunk.sceneCullingMask,
				cullingMask = culledChunk.cullingMask,
				visibleDecalIndices = culledChunk.visibleDecalIndices,
				visibleDecalCount = culledChunk.visibleDecalCount,
				maxDrawDistance = m_MaxDrawDistance,
				decalToWorldsDraw = drawCallChunk.decalToWorlds,
				normalToDecalsDraw = drawCallChunk.normalToDecals,
				subCalls = drawCallChunk.subCalls,
				subCallCount = drawCallChunk.subCallCounts
			}.Schedule(cachedChunk.currentJobHandle));
			cachedChunk.currentJobHandle = currentJobHandle;
		}
	}
}
