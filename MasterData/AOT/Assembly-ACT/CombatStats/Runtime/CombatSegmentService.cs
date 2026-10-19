using System;

namespace CombatStats.Runtime;

public sealed class CombatSegmentService : ICombatSegmentTrigger
{
	private readonly Func<float> nowProvider;

	private readonly CombatSessionAggregate session;

	public event Action<CombatSegmentDescriptor> OnCombatSegmentStarted;

	public event Action<CombatSegmentDescriptor, SegmentEndReason> OnCombatSegmentEnded;

	public CombatSegmentService(CombatSessionAggregate session, Func<float> nowProvider)
	{
		this.session = session ?? throw new ArgumentNullException("session");
		this.nowProvider = nowProvider ?? throw new ArgumentNullException("nowProvider");
	}

	public void NotifyDungeonStarted()
	{
		StartSegment(SegmentStartReason.DungeonStart);
	}

	public void NotifyTrainingCountdownFinished()
	{
		StartSegment(SegmentStartReason.TrainingCountdownFinish);
	}

	public void NotifyBossFightStarted()
	{
		StartSegment(SegmentStartReason.BossFightStart);
	}

	public void NotifyManualSegmentStart()
	{
		StartSegment(SegmentStartReason.Manual);
	}

	public void NotifySegmentEnded(SegmentEndReason reason)
	{
		CombatSegmentAggregate activeSegment = session.ActiveSegment;
		if (activeSegment != null)
		{
			session.EndActiveSegment(reason, nowProvider());
			OnCombatSegmentEnded?.Invoke(activeSegment.Descriptor, reason);
		}
	}

	private void StartSegment(SegmentStartReason reason)
	{
		CombatSegmentAggregate activeSegment = session.ActiveSegment;
		if (activeSegment != null)
		{
			session.EndActiveSegment(SegmentEndReason.ReplacedByNewSegment, nowProvider());
			OnCombatSegmentEnded?.Invoke(activeSegment.Descriptor, SegmentEndReason.ReplacedByNewSegment);
		}
		CombatSegmentAggregate combatSegmentAggregate = session.StartSegment(reason, nowProvider());
		OnCombatSegmentStarted?.Invoke(combatSegmentAggregate.Descriptor);
	}
}
