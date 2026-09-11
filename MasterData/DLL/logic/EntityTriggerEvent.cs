using Config;

public sealed class EntityTriggerEvent : NEventBase, IPostToSimulation
{
	public TriggerEventType mEventType;

	public int mTrigger;

	public int mSponsor;

	public EntityTriggerEvent()
	{
	}

	protected EntityTriggerEvent(TriggerEventType eventType)
	{
		mEventType = eventType;
		mTrigger = -1;
		mSponsor = -1;
	}

	public static EntityTriggerEvent Claim(TriggerEventType eventType, int trigger, int sponsor)
	{
		EntityTriggerEvent entityTriggerEvent = FrameObjectPool<EntityTriggerEvent>.Claim();
		entityTriggerEvent.mTrigger = trigger;
		entityTriggerEvent.mEventType = eventType;
		entityTriggerEvent.mSponsor = sponsor;
		return entityTriggerEvent;
	}

	public static EntityTriggerEvent Claim(TriggerEventType eventType)
	{
		EntityTriggerEvent entityTriggerEvent = FrameObjectPool<EntityTriggerEvent>.Claim();
		entityTriggerEvent.mEventType = eventType;
		entityTriggerEvent.mTrigger = -1;
		entityTriggerEvent.mSponsor = -1;
		return entityTriggerEvent;
	}

	public override void OnEnterPool()
	{
	}

	public override void Release()
	{
		FrameObjectPool<EntityTriggerEvent>.Release(this);
	}
}
