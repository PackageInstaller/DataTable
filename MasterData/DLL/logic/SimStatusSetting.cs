public class SimStatusSetting
{
	public int kFormationGap = 100;

	public VFactor kGapScale = new VFactor(15L, 10L);

	public bool kSilentEventsOnCommanderInitialization = true;

	public int kNumStateFramesToKeep = 16;

	public int kReplayVersionNumber = 9;

	public int kSimTickPeriodMS;

	public int kSimTicksPerSecond = 8;

	public int kDefaultTransientStateListCapacity = 600;

	public int kMaxTimerBacklogMS = 1500;

	public int kMaxTimerBacklogMSDefault = 1500;

	public int kSimShutdownGracePeriodMS = 3000;
}
