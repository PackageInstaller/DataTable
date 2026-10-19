namespace UnityEngine.Rendering.Universal;

internal class DecalDrawGBufferSystem : DecalDrawSystem
{
	public DecalDrawGBufferSystem(DecalEntityManager entityManager)
		: base("DecalDrawGBufferSystem.Execute", entityManager)
	{
	}

	protected override int GetPassIndex(DecalCachedChunk decalCachedChunk)
	{
		return decalCachedChunk.passIndexGBuffer;
	}
}
