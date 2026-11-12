public class TriggerBubbleDialogEnd : TriggerConditionBase
{
	private const string AVG_BB_END = "AVG_BB_END";

	public string dialogID;

	public int groupID;

	public override void ToActive()
	{
		base.ToActive();
		Singleton<EventDispatchManager>.Instance.AddEventListener("AVG_BB_END", OnBubbleDialogEnd);
	}

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("AVG_BB_END", OnBubbleDialogEnd);
	}

	private void OnBubbleDialogEnd(IEvent evt)
	{
		if (!(evt is GeneralEvent { data: string data }))
		{
			return;
		}
		string[] array = data.Split('|');
		if (array.Length >= 2)
		{
			string text = array[0];
			string text2 = array[1];
			if (text == dialogID && text2 == groupID.ToString())
			{
				OnTrigger();
			}
		}
	}
}
