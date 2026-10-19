namespace UnityEngine.Rendering.Universal;

internal class DecalSkipCulledSystem
{
	private DecalEntityManager m_EntityManager;

	private ProfilingSampler m_Sampler;

	private Camera m_Camera;

	public DecalSkipCulledSystem(DecalEntityManager entityManager)
	{
		m_EntityManager = entityManager;
		m_Sampler = new ProfilingSampler("DecalSkipCulledSystem.Execute");
	}

	public void Execute(Camera camera)
	{
		using (new ProfilingScope(null, m_Sampler))
		{
			m_Camera = camera;
			for (int i = 0; i < m_EntityManager.chunkCount; i++)
			{
				Execute(m_EntityManager.culledChunks[i], m_EntityManager.culledChunks[i].count);
			}
		}
	}

	private void Execute(DecalCulledChunk culledChunk, int count)
	{
		if (count != 0)
		{
			culledChunk.currentJobHandle.Complete();
			for (int i = 0; i < count; i++)
			{
				culledChunk.visibleDecalIndices[i] = i;
			}
			culledChunk.visibleDecalCount = count;
			culledChunk.cameraPosition = m_Camera.transform.position;
			culledChunk.cullingMask = m_Camera.cullingMask;
		}
	}

	internal static ulong GetSceneCullingMaskFromCamera(Camera camera)
	{
		return 0uL;
	}
}
