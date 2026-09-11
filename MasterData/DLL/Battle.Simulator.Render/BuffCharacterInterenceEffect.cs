public class BuffCharacterInterenceEffect : IFramePooledObject
{
	public int CreationIndex;

	public float Intensity;

	public int Order = 1;

	public void OnEnterPool()
	{
		CreationIndex = 0;
		Intensity = 0f;
		Order = 1;
	}
}
