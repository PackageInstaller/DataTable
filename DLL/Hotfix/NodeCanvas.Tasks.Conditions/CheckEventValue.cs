using System;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Utility")]
[Description("Check if an event is received and it's value is equal to specified value, then return true for one frame")]
public class CheckEventValue<T> : ConditionTask<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName;

	[Name("Compare Value To", 0)]
	public BBParameter<T> value;

	protected override string info => $"Event [{eventName}].value == {value}";

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

	private void OnCustomEvent(string eventName, IEventData msg)
	{
		if (eventName.Equals(this.eventName.value, StringComparison.OrdinalIgnoreCase) && ObjectUtils.AnyEquals(msg.valueBoxed, value.value))
		{
			YieldReturn(value: true);
		}
	}
}
