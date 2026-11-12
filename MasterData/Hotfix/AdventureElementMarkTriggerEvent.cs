public class AdventureElementMarkTriggerEvent : BaseAdventureEvent
{
	public int elementTag;

	public AdventureActor triggerActor;

	public AdventureActor markActor;

	public HotfixEnum.elementType elementType;

	public HotfixEnum.AdventureActorElementTriggerType markTriggerType;

	public string tipsKey;

	public static AdventureElementMarkTriggerEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureElementMarkTriggerEvent>("ELEMENT_MARK_TRIGGER");
	}

	public AdventureElementMarkTriggerEvent()
		: base("ELEMENT_MARK_TRIGGER")
	{
	}

	public override void Clear()
	{
		elementTag = 0;
		triggerActor = null;
		markActor = null;
		elementType = HotfixEnum.elementType.NONE;
		markTriggerType = HotfixEnum.AdventureActorElementTriggerType.None;
		tipsKey = "";
	}
}
