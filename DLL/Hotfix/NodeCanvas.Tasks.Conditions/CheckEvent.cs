using System;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Utility")]
[Description("Check if an event is received and return true for one frame")]
public class CheckEvent : ConditionTask<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName;

	protected override string info => "[" + eventName.ToString() + "]";

	protected override void OnEnable()
	{
		base.router.onCustomEvent += OnCustomEvent;
	}

	protected override void OnDisable()
	{
		base.router.onCustomEvent -= OnCustomEvent;
	}

	protected override bool OnCheck()
	{
		return false;
	}

	private void OnCustomEvent(string eventName, IEventData data)
	{
		if (eventName.Equals(this.eventName.value, StringComparison.OrdinalIgnoreCase))
		{
			YieldReturn(value: true);
		}
	}
}
[Category("✫ Utility")]
[Description("Check if an event is received and return true for one frame. Optionaly save the received event's value")]
public class CheckEvent<T> : ConditionTask<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName;

	[BlackboardOnly]
	public BBParameter<T> saveEventValue;

	protected override string info => $"Event [{eventName}]\n{saveEventValue} = EventValue";

	protected override void OnEnable()
	{
		base.router.onCustomEvent += OnCustomEvent;
	}

	protected override void OnDisable()
	{
		base.router.onCustomEvent -= OnCustomEvent;
	}

	protected override bool OnCheck()
	{
		return false;
	}

	private void OnCustomEvent(string eventName, IEventData data)
	{
		if (eventName.Equals(this.eventName.value, StringComparison.OrdinalIgnoreCase))
		{
			if (data is EventData<T>)
			{
				saveEventValue.value = ((EventData<T>)(object)data).value;
			}
			else if (data.valueBoxed is T)
			{
				saveEventValue.value = (T)data.valueBoxed;
			}
			YieldReturn(value: true);
		}
	}
}
