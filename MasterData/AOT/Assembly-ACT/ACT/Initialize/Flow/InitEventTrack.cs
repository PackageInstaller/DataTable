using ACT.EventTrack;

namespace ACT.Initialize.Flow;

public class InitEventTrack : RuntimeLoadFlow
{
	public InitEventTrack()
		: base("InitEventTrack")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		EventTrackSolver.Instance.Init();
		WaitInitializer.CompleteOne();
	}
}
