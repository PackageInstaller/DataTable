namespace P08.EnvironmentHelper;

public class GlitchEffectClip : ClipBase, IFramePooledObject
{
	public int CreationIndex;

	public int Key;

	public float Intensity;

	public float Frequency;

	public int Priority;

	public void OnEnterPool()
	{
		CreationIndex = 0;
		Key = 0;
		Intensity = 0f;
		Frequency = 0f;
		Priority = 0;
	}
}
