namespace ACT.Initialize.Flow;

public class InitUWASDK : RuntimeLoadFlow
{
	public InitUWASDK()
		: base("InitUWASDK")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		DoInitUWASDK();
		WaitInitializer.CompleteOne();
	}

	private void DoInitUWASDK()
	{
	}
}
