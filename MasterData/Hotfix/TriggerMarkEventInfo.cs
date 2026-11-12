public class TriggerMarkEventInfo
{
	public int markTag;

	public HotfixEnum.elementType triggerElementType;

	public AdventureActor target;

	public TriggerMarkEventInfo(HotfixEnum.elementType triggerElementType, int markTag, AdventureActor target)
	{
		this.triggerElementType = triggerElementType;
		this.markTag = markTag;
		this.target = target;
	}

	public void Clear()
	{
		markTag = 0;
		triggerElementType = HotfixEnum.elementType.NONE;
		target = null;
	}
}
