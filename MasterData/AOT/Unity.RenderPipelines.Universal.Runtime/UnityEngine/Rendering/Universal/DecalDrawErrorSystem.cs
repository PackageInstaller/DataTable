namespace UnityEngine.Rendering.Universal;

internal class DecalDrawErrorSystem : DecalDrawSystem
{
	private DecalTechnique m_Technique;

	public DecalDrawErrorSystem(DecalEntityManager entityManager, DecalTechnique technique)
		: base("DecalDrawErrorSystem.Execute", entityManager)
	{
		m_Technique = technique;
	}

	protected override int GetPassIndex(DecalCachedChunk decalCachedChunk)
	{
		switch (m_Technique)
		{
		case DecalTechnique.GBuffer:
			if (decalCachedChunk.passIndexGBuffer != -1)
			{
				return -1;
			}
			return 0;
		case DecalTechnique.Invalid:
			return 0;
		default:
			return 0;
		}
	}

	protected override Material GetMaterial(DecalEntityChunk decalEntityChunk)
	{
		return m_EntityManager.errorMaterial;
	}
}
