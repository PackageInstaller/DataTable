using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Events")]
[TaskDescription("Returns success after receiving the specified event with a string argument.")]
[TaskIcon("{SkinColor}HasReceivedEventIcon.png")]
public class HasReceivedStringEvent : Conditional
{
	[Tooltip("The name of the event to receive")]
	public SharedString eventName = "";

	[Tooltip("Stores the received string argument")]
	[SharedRequired]
	public SharedString storedValue;

	private bool eventReceived;

	private bool registered;

	public override void OnStart()
	{
		if (!registered)
		{
			Owner.RegisterEvent<object>(eventName.Value, ReceivedEvent);
			registered = true;
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (!eventReceived)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}

	public override void OnEnd()
	{
		if (eventReceived)
		{
			Owner.UnregisterEvent<object>(eventName.Value, ReceivedEvent);
			registered = false;
		}
		eventReceived = false;
	}

	public override void OnBehaviorComplete()
	{
		if (registered)
		{
			Owner.UnregisterEvent<object>(eventName.Value, ReceivedEvent);
			registered = false;
		}
		eventReceived = false;
	}

	public override void OnReset()
	{
		eventName = "";
		storedValue = "";
	}

	private void ReceivedEvent(object value)
	{
		if (value is string value2)
		{
			eventReceived = true;
			if (storedValue != null && !storedValue.IsNone)
			{
				storedValue.Value = value2;
			}
		}
	}
}
