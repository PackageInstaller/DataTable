using Entitas;

public class SimSystem : IExecuteSystem, ISystem, IInitializeSystem, ICleanupSystem
{
	public delegate void SimTickedHandler(SimResult tickResult, Checksum tickChecksum);

	private SimContext mSimContext;

	public SimSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
	}

	public void Execute()
	{
		Tick();
	}

	public void Cleanup()
	{
	}

	internal Checksum Tick()
	{
		mSimContext.simStatus.expectedChecksum.Equals(mSimContext.simStatus.mMostRecentChecksum);
		mSimContext.simStatus.mSimTime += mSimContext.simStatus.runtimeSetting.kSimTickPeriodMS;
		Checksum mMostRecentChecksum = mSimContext.simStatus.mMostRecentChecksum;
		mMostRecentChecksum.Add((int)mSimContext.simStatus.mServerFrame);
		return mMostRecentChecksum;
	}
}
