using System;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Subscribes to a static C# System.Action Event and is called when the event is raised")]
[Category("Events/Script")]
[Obsolete]
public abstract class StaticCodeEventBase : EventNode
{
	[SerializeField]
	protected string eventName;

	[SerializeField]
	protected Type targetType;

	protected EventInfo eventInfo
	{
		get
		{
			if (!(targetType != null))
			{
				return null;
			}
			return targetType.RTGetEvent(eventName);
		}
	}

	public void SetEvent(EventInfo e)
	{
		targetType = e.RTReflectedType();
		eventName = e.Name;
		GatherPorts();
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		if (string.IsNullOrEmpty(eventName))
		{
			Debug.LogError("No Event Selected for 'Static Code Event'");
		}
		else if (eventInfo == null)
		{
			Debug.LogError($"Event {eventName} is not found");
		}
	}
}
