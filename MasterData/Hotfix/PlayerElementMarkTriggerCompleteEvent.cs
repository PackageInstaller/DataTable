public class PlayerElementMarkTriggerCompleteEvent : BaseAdventureEvent
{
	public ElementMarkType markType;

	public AdventureActor triggerActor;

	public AdventureActor markActor;

	public static PlayerElementMarkTriggerCompleteEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<PlayerElementMarkTriggerCompleteEvent>("ELEMENT_MARK_TRIGGER_ALFTER");
	}

	public PlayerElementMarkTriggerCompleteEvent()
		: base("ELEMENT_MARK_TRIGGER_ALFTER")
	{
	}

	public override void Clear()
	{
		markType = ElementMarkType.None;
		triggerActor = null;
		markActor = null;
	}
}
