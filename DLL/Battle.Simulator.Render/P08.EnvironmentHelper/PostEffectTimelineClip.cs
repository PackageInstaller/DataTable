namespace P08.EnvironmentHelper;

public class PostEffectTimelineClip : ClipBase, IFramePooledObject
{
	public int Key;

	public int CreationIndex;

	public SceneSettingPostEffectClip SceneSettingPostEffectClip;

	public void OnEnterPool()
	{
		Key = 0;
		CreationIndex = 0;
		SceneSettingPostEffectClip = null;
	}
}
