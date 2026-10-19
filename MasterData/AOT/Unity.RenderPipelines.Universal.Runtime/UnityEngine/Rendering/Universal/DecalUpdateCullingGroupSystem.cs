namespace UnityEngine.Rendering.Universal;

internal class DecalUpdateCullingGroupSystem
{
	private float[] m_BoundingDistance = new float[1];

	private Camera m_Camera;

	private DecalEntityManager m_EntityManager;

	private ProfilingSampler m_Sampler;

	public float boundingDistance
	{
		get
		{
			return m_BoundingDistance[0];
		}
		set
		{
			m_BoundingDistance[0] = value;
		}
	}

	public DecalUpdateCullingGroupSystem(DecalEntityManager entityManager, float drawDistance)
	{
		m_EntityManager = entityManager;
		m_BoundingDistance[0] = drawDistance;
		m_Sampler = new ProfilingSampler("DecalUpdateCullingGroupsSystem.Execute");
	}

	public void Execute(Camera camera)
	{
		using (new ProfilingScope(null, m_Sampler))
		{
			m_Camera = camera;
			for (int i = 0; i < m_EntityManager.chunkCount; i++)
			{
				Execute(m_EntityManager.cachedChunks[i], m_EntityManager.culledChunks[i], m_EntityManager.culledChunks[i].count);
			}
		}
	}

	public void Execute(DecalCachedChunk cachedChunk, DecalCulledChunk culledChunk, int count)
	{
		cachedChunk.currentJobHandle.Complete();
		CullingGroup cullingGroups = culledChunk.cullingGroups;
		cullingGroups.targetCamera = m_Camera;
		cullingGroups.SetDistanceReferencePoint(m_Camera.transform.position);
		cullingGroups.SetBoundingDistances(m_BoundingDistance);
		cachedChunk.boundingSpheres.CopyTo(cachedChunk.boundingSphereArray);
		cullingGroups.SetBoundingSpheres(cachedChunk.boundingSphereArray);
		cullingGroups.SetBoundingSphereCount(count);
		culledChunk.cameraPosition = m_Camera.transform.position;
		culledChunk.cullingMask = m_Camera.cullingMask;
	}

	internal static ulong GetSceneCullingMaskFromCamera(Camera camera)
	{
		return 0uL;
	}
}
