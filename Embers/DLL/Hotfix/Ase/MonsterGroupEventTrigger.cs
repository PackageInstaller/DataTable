namespace Ase;

public class MonsterGroupEventTrigger : BaseEventTriggerNode
{
	public MonsterGroupEventType messageType;

	public MonsterGroup monsterGroup;

	public override string TriggerName => "怪物组事件触发器";

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		monsterGroup.RegisterSubscription(this);
	}

	public void OnMessage(MonsterGroup group, MonsterGroupEventType message)
	{
		if (message == messageType)
		{
			Execute();
		}
	}

	public override void OnDisposed()
	{
		monsterGroup.UnRegisterSubscription(this);
	}
}
