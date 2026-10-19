namespace CombatStats.Runtime;

public interface ICombatSegmentTrigger
{
	void NotifyDungeonStarted();

	void NotifyTrainingCountdownFinished();

	void NotifyBossFightStarted();

	void NotifyManualSegmentStart();

	void NotifySegmentEnded(SegmentEndReason reason);
}
