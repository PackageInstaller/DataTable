using ACT.Battle;

namespace ACT.Event;

public class NpcEvent : BaseEventContent
{
	public int AvgGroupID { get; set; }

	public int NpcID { get; set; }

	public NpcBehaviorState BehaviorState { get; set; }

	public override void OnGet()
	{
		AvgGroupID = 0;
		NpcID = 0;
		BehaviorState = NpcBehaviorState.ReachedDestination;
	}
}
