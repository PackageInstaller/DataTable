public class BuffCharacterSliceEffect : IFramePooledObject
{
	public int CreationIndex;

	public int Order = 1;

	public float Offset;

	public float Range;

	public float Density;

	public float Speed;

	public void OnEnterPool()
	{
		CreationIndex = 0;
		Order = 1;
		Offset = 0f;
		Range = 0f;
		Density = 0f;
		Speed = 0f;
	}
}
