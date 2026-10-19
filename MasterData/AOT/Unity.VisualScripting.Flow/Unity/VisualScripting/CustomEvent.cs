using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(0)]
[UnitCategory("Events")]
public sealed class CustomEvent : GameObjectEventUnit<CustomEventArgs>
{
	[SerializeAs("argumentCount")]
	private int _argumentCount;

	public override Type MessageListenerType => null;

	protected override string hookName => "Custom";

	[Inspectable]
	[UnitHeaderInspectable("Arguments")]
	[DoNotSerialize]
	public int argumentCount
	{
		get
		{
			return _argumentCount;
		}
		set
		{
			_argumentCount = Mathf.Clamp(value, 0, 10);
		}
	}

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput name { get; private set; }

	[DoNotSerialize]
	public List<ValueOutput> argumentPorts { get; } = new List<ValueOutput>();

	protected override void Definition()
	{
		base.Definition();
		name = ValueInput("name", string.Empty);
		argumentPorts.Clear();
		for (int i = 0; i < argumentCount; i++)
		{
			argumentPorts.Add(ValueOutput<object>("argument_" + i));
		}
	}

	protected override bool ShouldTrigger(Flow flow, CustomEventArgs args)
	{
		return EventUnit<CustomEventArgs>.CompareNames(flow, name, args.name);
	}

	protected override void AssignArguments(Flow flow, CustomEventArgs args)
	{
		for (int i = 0; i < argumentCount; i++)
		{
			flow.SetValue(argumentPorts[i], args.arguments[i]);
		}
	}

	public static void Trigger(GameObject target, string name, params object[] args)
	{
		EventBus.Trigger("Custom", target, new CustomEventArgs(name, args));
	}
}
