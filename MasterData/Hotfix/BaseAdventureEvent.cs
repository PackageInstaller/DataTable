public abstract class BaseAdventureEvent : BaseEvent
{
	protected BaseAdventureEvent(string eventType)
		: base(eventType)
	{
	}

	public virtual void Clear()
	{
	}
}
