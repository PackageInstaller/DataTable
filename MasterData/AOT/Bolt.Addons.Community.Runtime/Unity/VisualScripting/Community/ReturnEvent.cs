using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Lasm.UAlive.ReturnEvent")]
[RenamedFrom("Bolt.Addons.Community.ReturnEvents.ReturnEvent")]
[UnitCategory("Events/Community/Returns")]
[RenamedFrom("Lasm.BoltExtensions.ReturnEvent")]
public sealed class ReturnEvent : GlobalEventUnit<ReturnEventArg>
{
	[Serialize]
	private int _count;

	[UnitHeaderInspectable("Global")]
	public bool global;

	[DoNotSerialize]
	public ValueOutput eventData;

	[DoNotSerialize]
	public List<ValueOutput> arguments = new List<ValueOutput>();

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name;

	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput target;

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

	protected override string hookName => "Return";

	protected override void Definition()
	{
		base.Definition();
		arguments.Clear();
		if (!global)
		{
			target = ValueInput<GameObject>("target", null).NullMeansSelf();
		}
		name = ValueInput("name", string.Empty);
		eventData = ValueOutput<ReturnEventData>("data");
		for (int i = 0; i < count; i++)
		{
			arguments.Add(ValueOutput<object>(i.ToString()));
		}
	}

	protected override bool ShouldTrigger(Flow flow, ReturnEventArg args)
	{
		bool flag = flow.GetValue<string>(name) == args.name;
		if ((args.isCallback ? (arguments.Count == args.arguments.Length) : (arguments.Count + 1 == args.arguments.Length || (arguments.Count == 0 && args.arguments.Length == 0))) & flag)
		{
			if (args.global)
			{
				return true;
			}
			if (args.target != null && args.target == flow.GetValue<GameObject>(target))
			{
				return true;
			}
		}
		return false;
	}

	protected override void AssignArguments(Flow flow, ReturnEventArg args)
	{
		flow.SetValue(eventData, new ReturnEventData(args));
		for (int i = 0; i < arguments.Count; i++)
		{
			flow.SetValue(arguments[i], args.arguments[args.isCallback ? i : (i + 1)]);
		}
	}

	public static void Trigger(TriggerReturnEvent trigger, GameObject target, string name, bool global = false, params object[] args)
	{
		EventBus.Trigger("Return", new ReturnEventArg(trigger, target, name, global, args));
	}

	public static void Trigger(GameObject target, string name, Action<object> callback = null, bool global = false, params object[] args)
	{
		EventBus.Trigger("Return", new ReturnEventArg(callback, target, name, global, args));
	}
}
