using ACT.UI;
using Fundamental;

namespace ACT.Initialize.Flow;

public class InitSpriteAtlasLoader : RuntimeLoadFlow
{
	public InitSpriteAtlasLoader()
		: base("InitSpriteAtlasLoader")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		Singleton<SpriteAtlasLoader>.CreateInstance();
		WaitInitializer.CompleteOne();
	}
}
