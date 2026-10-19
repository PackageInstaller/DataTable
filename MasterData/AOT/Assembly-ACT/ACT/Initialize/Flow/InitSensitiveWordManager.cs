using Fundamental;

namespace ACT.Initialize.Flow;

public class InitSensitiveWordManager : RuntimeLoadFlow
{
	public InitSensitiveWordManager()
		: base("InitSensitiveWordManager")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		Singleton<SensitiveWordManager>.CreateInstance();
		WaitInitializer.CompleteOne();
	}
}
