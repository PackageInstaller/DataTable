using Unity.Collections;

namespace UnityEngine.Rendering.Universal;

internal abstract class DecalDrawSystem
{
	protected DecalEntityManager m_EntityManager;

	private Matrix4x4[] m_WorldToDecals;

	private Matrix4x4[] m_NormalToDecals;

	private ProfilingSampler m_Sampler;

	public Material overrideMaterial { get; set; }

	public DecalDrawSystem(string sampler, DecalEntityManager entityManager)
	{
		m_EntityManager = entityManager;
		m_WorldToDecals = new Matrix4x4[64];
		m_NormalToDecals = new Matrix4x4[64];
		m_Sampler = new ProfilingSampler(sampler);
	}

	public void Execute(CommandBuffer cmd)
	{
		using (new ProfilingScope(cmd, m_Sampler))
		{
			for (int i = 0; i < m_EntityManager.chunkCount; i++)
			{
				Execute(cmd, m_EntityManager.entityChunks[i], m_EntityManager.cachedChunks[i], m_EntityManager.drawCallChunks[i], m_EntityManager.entityChunks[i].count);
			}
		}
	}

	protected virtual Material GetMaterial(DecalEntityChunk decalEntityChunk)
	{
		return decalEntityChunk.material;
	}

	protected abstract int GetPassIndex(DecalCachedChunk decalCachedChunk);

	private void Execute(CommandBuffer cmd, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk, int count)
	{
		decalCachedChunk.currentJobHandle.Complete();
		decalDrawCallChunk.currentJobHandle.Complete();
		Material material = GetMaterial(decalEntityChunk);
		int passIndex = GetPassIndex(decalCachedChunk);
		if (count != 0 && passIndex != -1 && !(material == null))
		{
			if (SystemInfo.supportsInstancing && material.enableInstancing)
			{
				DrawInstanced(cmd, decalEntityChunk, decalCachedChunk, decalDrawCallChunk, passIndex);
			}
			else
			{
				Draw(cmd, decalEntityChunk, decalCachedChunk, decalDrawCallChunk, passIndex);
			}
		}
	}

	private void Draw(CommandBuffer cmd, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk, int passIndex)
	{
		Mesh decalProjectorMesh = m_EntityManager.decalProjectorMesh;
		Material material = GetMaterial(decalEntityChunk);
		decalCachedChunk.propertyBlock.SetVector("unity_LightData", new Vector4(1f, 1f, 1f, 0f));
		int subCallCount = decalDrawCallChunk.subCallCount;
		for (int i = 0; i < subCallCount; i++)
		{
			DecalSubDrawCall decalSubDrawCall = decalDrawCallChunk.subCalls[i];
			for (int j = decalSubDrawCall.start; j < decalSubDrawCall.end; j++)
			{
				decalCachedChunk.propertyBlock.SetMatrix("_NormalToWorld", decalDrawCallChunk.normalToDecals[j]);
				cmd.DrawMesh(decalProjectorMesh, decalDrawCallChunk.decalToWorlds[j], material, 0, passIndex, decalCachedChunk.propertyBlock);
			}
		}
	}

	private void DrawInstanced(CommandBuffer cmd, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk, int passIndex)
	{
		Mesh decalProjectorMesh = m_EntityManager.decalProjectorMesh;
		Material material = GetMaterial(decalEntityChunk);
		decalCachedChunk.propertyBlock.SetVector("unity_LightData", new Vector4(1f, 1f, 1f, 0f));
		int subCallCount = decalDrawCallChunk.subCallCount;
		for (int i = 0; i < subCallCount; i++)
		{
			DecalSubDrawCall decalSubDrawCall = decalDrawCallChunk.subCalls[i];
			NativeArray<Matrix4x4>.Copy(decalDrawCallChunk.decalToWorlds.Reinterpret<Matrix4x4>(), decalSubDrawCall.start, m_WorldToDecals, 0, decalSubDrawCall.count);
			NativeArray<Matrix4x4>.Copy(decalDrawCallChunk.normalToDecals.Reinterpret<Matrix4x4>(), decalSubDrawCall.start, m_NormalToDecals, 0, decalSubDrawCall.count);
			decalCachedChunk.propertyBlock.SetMatrixArray("_NormalToWorld", m_NormalToDecals);
			cmd.DrawMeshInstanced(decalProjectorMesh, 0, material, passIndex, m_WorldToDecals, decalSubDrawCall.end - decalSubDrawCall.start, decalCachedChunk.propertyBlock);
		}
	}

	public bool Execute(in CameraData cameraData)
	{
		bool flag = false;
		using (new ProfilingScope(null, m_Sampler))
		{
			for (int i = 0; i < m_EntityManager.chunkCount; i++)
			{
				flag |= Execute(in cameraData, m_EntityManager.entityChunks[i], m_EntityManager.cachedChunks[i], m_EntityManager.drawCallChunks[i], m_EntityManager.entityChunks[i].count);
			}
			return flag;
		}
	}

	private bool Execute(in CameraData cameraData, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk, int count)
	{
		decalCachedChunk.currentJobHandle.Complete();
		decalDrawCallChunk.currentJobHandle.Complete();
		Material material = GetMaterial(decalEntityChunk);
		int passIndex = GetPassIndex(decalCachedChunk);
		if (count == 0 || passIndex == -1 || material == null)
		{
			return false;
		}
		if (decalDrawCallChunk.subCallCount == 0)
		{
			return false;
		}
		if (SystemInfo.supportsInstancing && material.enableInstancing)
		{
			DrawInstanced(in cameraData, decalEntityChunk, decalCachedChunk, decalDrawCallChunk);
		}
		else
		{
			Draw(in cameraData, decalEntityChunk, decalCachedChunk, decalDrawCallChunk);
		}
		return true;
	}

	private void Draw(in CameraData cameraData, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk)
	{
		Mesh decalProjectorMesh = m_EntityManager.decalProjectorMesh;
		Material material = GetMaterial(decalEntityChunk);
		int subCallCount = decalDrawCallChunk.subCallCount;
		for (int i = 0; i < subCallCount; i++)
		{
			DecalSubDrawCall decalSubDrawCall = decalDrawCallChunk.subCalls[i];
			for (int j = decalSubDrawCall.start; j < decalSubDrawCall.end; j++)
			{
				decalCachedChunk.propertyBlock.SetMatrix("_NormalToWorld", decalDrawCallChunk.normalToDecals[j]);
				Graphics.DrawMesh(decalProjectorMesh, decalCachedChunk.decalToWorlds[j], material, decalCachedChunk.layerMasks[j], cameraData.camera, 0, decalCachedChunk.propertyBlock);
			}
		}
	}

	private void DrawInstanced(in CameraData cameraData, DecalEntityChunk decalEntityChunk, DecalCachedChunk decalCachedChunk, DecalDrawCallChunk decalDrawCallChunk)
	{
		Mesh decalProjectorMesh = m_EntityManager.decalProjectorMesh;
		Material material = GetMaterial(decalEntityChunk);
		decalCachedChunk.propertyBlock.SetVector("unity_LightData", new Vector4(1f, 1f, 1f, 0f));
		int subCallCount = decalDrawCallChunk.subCallCount;
		for (int i = 0; i < subCallCount; i++)
		{
			DecalSubDrawCall decalSubDrawCall = decalDrawCallChunk.subCalls[i];
			NativeArray<Matrix4x4>.Copy(decalDrawCallChunk.decalToWorlds.Reinterpret<Matrix4x4>(), decalSubDrawCall.start, m_WorldToDecals, 0, decalSubDrawCall.count);
			NativeArray<Matrix4x4>.Copy(decalDrawCallChunk.normalToDecals.Reinterpret<Matrix4x4>(), decalSubDrawCall.start, m_NormalToDecals, 0, decalSubDrawCall.count);
			decalCachedChunk.propertyBlock.SetMatrixArray("_NormalToWorld", m_NormalToDecals);
			Graphics.DrawMeshInstanced(decalProjectorMesh, 0, material, m_WorldToDecals, decalSubDrawCall.count, decalCachedChunk.propertyBlock, ShadowCastingMode.On, receiveShadows: true, 0, cameraData.camera);
		}
	}
}
