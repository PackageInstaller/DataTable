namespace UnityEngine.Rendering.Universal;

internal struct DecalSubDrawCall
{
	public int start;

	public int end;

	public int count => end - start;
}
