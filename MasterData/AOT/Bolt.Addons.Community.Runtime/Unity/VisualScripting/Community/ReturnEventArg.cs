using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Lasm.BoltExtensions.ReturnEventArg")]
[RenamedFrom("Bolt.Addons.Community.ReturnEvents.ReturnEventArg")]
[RenamedFrom("Lasm.UAlive.ReturnEventArg")]
public struct ReturnEventArg
{
	public readonly TriggerReturnEvent trigger;

	public readonly GameObject target;

	public readonly bool global;

	public readonly object[] arguments;

	public readonly string name;

	public readonly Action<object> callback;

	public readonly bool isCallback;

	public ReturnEventArg(TriggerReturnEvent trigger, GameObject target, string name, bool global, object[] arguments = null)
	{
		this.trigger = trigger;
		callback = null;
		isCallback = false;
		this.target = target;
		this.global = global;
		this.arguments = arguments;
		this.name = name;
	}

	public ReturnEventArg(Action<object> callback, GameObject target, string name, bool global, object[] arguments = null)
	{
		trigger = null;
		this.callback = callback;
		isCallback = true;
		this.target = target;
		this.global = global;
		this.arguments = arguments;
		this.name = name;
	}

	public ReturnEventArg(ReturnEventData data)
	{
		trigger = data.args.trigger;
		callback = data.args.callback;
		isCallback = data.args.isCallback;
		target = data.args.target;
		global = data.args.global;
		arguments = data.args.arguments;
		name = data.args.name;
	}
}
