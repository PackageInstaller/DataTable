namespace ACT.World.StateObject.EntryProcessors;

public class TriggerExitEntryProcessor : CommonEntryProcessor
{
	protected override void OnLeave(ICommonInteractEntrySetting entry)
	{
		if (!entry.TriggerExiting)
		{
			entry.TriggerExiting = true;
			NetInteract(entry);
			entry.TriggerExiting = false;
		}
	}
}
