using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Events/Community/Returns")]
[RenamedFrom("Lasm.BoltExtensions.TriggerReturnEvent")]
[RenamedFrom("Lasm.UAlive.TriggerReturnEvent")]
[TypeIcon(typeof(BoltUnityEvent))]
[RenamedFrom("Bolt.Addons.Community.ReturnEvents.TriggerReturnEvent")]
public sealed class TriggerReturnEvent : GlobalEventUnit<ReturnEventArg>
{
	[Serialize]
	private int _count;

	[UnitHeaderInspectable("Global")]
	public bool global;

	public object storingValue;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter;

	[PortLabelHidden]
	[NullMeansSelf]
	[DoNotSerialize]
	public ValueInput target;

	[PortLabelHidden]
	[NullMeansSelf]
	[DoNotSerialize]
	public ValueInput name;

	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ControlOutput complete;

	[DoNotSerialize]
	public List<ValueInput> arguments = new List<ValueInput>();

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput value;

	protected override string hookName => "TriggerReturn";

	[UnitHeaderInspectable("Arguments")]
	[Inspectable]
	public int count
	{
		get
		{
			return _count;
		}
		set
		{
			_count = Mathf.Clamp(value, 0, 10);
		}
	}

	protected override void Definition()
	{
		base.Definition();
		arguments.Clear();
		enter = ControlInput("enter", Enter);
		name = ValueInput("name", string.Empty);
		if (!global)
		{
			target = ValueInput<GameObject>("target", null).NullMeansSelf();
		}
		for (int i = 0; i < count; i++)
		{
			ValueInput valueInput = ValueInput<object>(i.ToString());
			arguments.Add(valueInput);
			Requirement(valueInput, enter);
		}
		exit = ControlOutput("exit");
		value = ValueOutput("value", GetValue);
		Succession(enter, exit);
		Requirement(name, enter);
		if (!global)
		{
			Requirement(target, enter);
		}
		Succession(enter, trigger);
	}

	public ControlOutput Enter(Flow flow)
	{
		List<object> list = new List<object>();
		ReturnEventData item = new ReturnEventData(new ReturnEventArg(this, global ? null : flow.GetValue<GameObject>(target), flow.GetValue<string>(name), global, list.ToArray()));
		list.Add(item);
		list.AddRange(arguments.Select(flow.GetConvertedValue));
		ReturnEvent.Trigger(this, global ? null : flow.GetValue<GameObject>(target), flow.GetValue<string>(name), global, list.ToArray());
		return exit;
	}

	public object GetValue(Flow flow)
	{
		return storingValue;
	}

	public static void Trigger(ReturnEventArg args)
	{
		_ = args.global;
		EventBus.Trigger("TriggerReturn", args);
	}

	protected override bool ShouldTrigger(Flow flow, ReturnEventArg args)
	{
		if (args.trigger == this && global && args.name == flow.GetValue<string>(name))
		{
			return true;
		}
		if (args.trigger == this && !global && args.target == flow.GetValue<GameObject>(target))
		{
			return true;
		}
		return false;
	}
}
