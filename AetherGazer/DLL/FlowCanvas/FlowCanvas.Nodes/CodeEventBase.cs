using System;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Subscribes to a C# System.Action Event and is called when the event is raised")]
[Category("Events/Script")]
[Obsolete]
public abstract class CodeEventBase : EventNode<Transform>
{
	[SerializeField]
	protected string eventName;

	[SerializeField]
	protected Type targetType;

	protected Component targetComponent;

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

	public void SetEvent(EventInfo e, object instace = null)
	{
		targetType = e.RTReflectedType();
		eventName = e.Name;
		GatherPorts();
	}

	public override void OnGraphStarted()
	{
		ResolveSelf();
		if (string.IsNullOrEmpty(eventName))
		{
			Debug.LogError("No Event Selected for CodeEvent, or target is NULL");
			return;
		}
		targetComponent = target.value.GetComponent(targetType);
		if (targetComponent == null)
		{
			Debug.LogError("Target is null");
		}
		else if (eventInfo == null)
		{
			Debug.LogError($"Event {eventName} is not found");
		}
	}
}
