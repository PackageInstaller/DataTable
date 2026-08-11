#define ENABLE_FATAL_AND_ABOVE_LOG
namespace GameFramework.Runtime;

public class DefaultSoundHelper : SoundHelperBase
{
	private ResourceComponent m_ResourceComponent = null;

	public override void ReleaseSoundAsset(string soundAsset)
	{
		m_ResourceComponent.UnloadAsset(soundAsset);
	}

	private void Start()
	{
		m_ResourceComponent = GameEntryRuntime.GetComponent<ResourceComponent>();
		if (m_ResourceComponent == null)
		{
			Log.Fatal("Resource component is invalid.");
		}
	}
}
