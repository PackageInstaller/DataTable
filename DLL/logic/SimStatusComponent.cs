using Entitas;
using Entitas.CodeGeneration.Attributes;

[Unique]
[Sim]
public class SimStatusComponent : IComponent
{
	public SimStatusSetting runtimeSetting;

	public SimSettings simSetting;

	public uint mServerFrame;

	public uint mClientPredictionFrame;

	public bool mIsRollback;

	public ReplayMode replayMode;

	public GameMode gameMode;

	public long mSimTime;

	public Checksum expectedChecksum = new Checksum();

	public Checksum mMostRecentChecksum = new Checksum();
}
