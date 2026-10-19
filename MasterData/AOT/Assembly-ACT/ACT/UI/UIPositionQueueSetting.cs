namespace ACT.UI;

public class UIPositionQueueSetting
{
	public UIPosition Position { get; }

	public bool IgnorePriorityRule { get; set; }

	public UIPositionQueueSetting(UIPosition position, bool ignorePriorityRule = false)
	{
		Position = position;
		IgnorePriorityRule = ignorePriorityRule;
	}
}
