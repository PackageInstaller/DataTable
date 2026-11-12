namespace AIScript.Booter;

public class HotfixBooter
{
	public void Boot()
	{
		HotfixBootSceneManagers.Setup();
		AdventureBootConfigSubscriber.RegisterSubscriber();
		AdventureLinkFXPlayer.InitLineCastLayerMask();
		HotFixPlayerLoop.Inject();
		WwiseVoiceRuntime.Current = new WwiseVoiceRuntimeImpl();
		Singleton<HotfixDataController>.Instance.Load();
	}

	public void UnBoot()
	{
		HotFixPlayerLoop.Uninject();
		WwiseVoiceRuntime.Current = null;
		Singleton<HotfixDataController>.Instance.Unload();
	}
}
