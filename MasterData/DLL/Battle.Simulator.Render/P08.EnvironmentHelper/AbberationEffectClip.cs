namespace P08.EnvironmentHelper;

public class AbberationEffectClip : ClipBase, IFramePooledObject
{
	public int CreationIndex;

	public int Key;

	public float Intensity;

	public bool IsActive;

	public int Priority;

	public void OnEnterPool()
	{
		CreationIndex = 0;
		Key = 0;
		Intensity = 0f;
		IsActive = false;
		Priority = 0;
	}
}
