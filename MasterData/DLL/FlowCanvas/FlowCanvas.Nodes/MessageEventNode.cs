using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public abstract class MessageEventNode<T> : EventNode where T : Component
{
	public enum TargetMode
	{
		SingleTarget,
		MultipleTargets
	}

	public TargetMode targetMode;

	[ShowIf("targetMode", 0)]
	public BBParameter<T> target;

	[ShowIf("targetMode", 1)]
	public BBParameter<List<T>> targets;

	public override string name
	{
		get
		{
			string empty = string.Empty;
			return string.Format(arg1: (targetMode != TargetMode.SingleTarget) ? targets.ToString() : ((target.isNull && !target.useBlackboard) ? "Self" : target.ToString()), format: "{0} ({1})", arg0: base.name.ToUpper());
		}
	}

	protected abstract string[] GetTargetMessageEvents();

	public sealed override void OnGraphStarted()
	{
		if (targetMode == TargetMode.SingleTarget)
		{
			if (target.isNull && !target.useBlackboard)
			{
				target.value = base.graphAgent.GetComponent<T>();
			}
			if (target.isNull)
			{
				Fail($"Target is missing component of type '{typeof(T).Name}'");
				return;
			}
			string[] targetMessageEvents = GetTargetMessageEvents();
			if (targetMessageEvents != null && targetMessageEvents.Length != 0)
			{
				RegisterEvents(target.value, targetMessageEvents);
			}
		}
		if (targetMode != TargetMode.MultipleTargets)
		{
			return;
		}
		if (targets.isNull || targets.value.Count == 0)
		{
			Fail("No Targets specified");
			return;
		}
		string[] targetMessageEvents2 = GetTargetMessageEvents();
		if (targetMessageEvents2 == null || targetMessageEvents2.Length == 0)
		{
			return;
		}
		foreach (T item in targets.value)
		{
			RegisterEvents(item, targetMessageEvents2);
		}
	}

	public sealed override void OnGraphStoped()
	{
		if (targetMode == TargetMode.SingleTarget)
		{
			UnRegisterEvents(target.value, GetTargetMessageEvents());
		}
		if (targetMode != TargetMode.MultipleTargets)
		{
			return;
		}
		string[] targetMessageEvents = GetTargetMessageEvents();
		foreach (T item in targets.value)
		{
			UnRegisterEvents(item, targetMessageEvents);
		}
	}

	protected T ResolveReceiver(GameObject receiver)
	{
		if (targetMode == TargetMode.SingleTarget)
		{
			return target.value;
		}
		return targets.value.Find((T t) => t.gameObject == receiver);
	}
}
