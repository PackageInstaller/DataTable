namespace ACT.World.StateObject.EntryProcessors;

public class TriggerEnterEntryProcessor : CommonEntryProcessor
{
	protected override void OnEnter(ICommonInteractEntrySetting entryObj)
	{
		if (entryObj.Interactable)
		{
			NetInteract(entryObj);
		}
	}

	protected override void OnLeave(ICommonInteractEntrySetting entry)
	{
		base.OnLeave(entry);
	}
}
