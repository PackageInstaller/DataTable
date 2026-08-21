using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[DoNotList]
[Description("Returns a reference of a C# event, which can be used with the C# Event Callback node.")]
public class GetSharpEvent : FlowNode
{
	[SerializeField]
	private SerializedEventInfo _event;

	private ValueInput instancePort;

	private EventInfo eventInfo
	{
		get
		{
			if (_event == null)
			{
				return null;
			}
			return _event.Get();
		}
	}

	public override string name
	{
		get
		{
			if (eventInfo != null)
			{
				if (eventInfo.IsStatic())
				{
					return $"{eventInfo.DeclaringType.FriendlyName()}.{eventInfo.Name}";
				}
				return eventInfo.Name;
			}
			return base.name;
		}
	}

	public void SetEvent(EventInfo info, object instance = null)
	{
		_event = new SerializedEventInfo(info);
		GatherPorts();
	}

	protected override void RegisterPorts()
	{
		if (!(eventInfo == null))
		{
			if (!eventInfo.IsStatic())
			{
				instancePort = AddValueInput(eventInfo.RTReflectedType().FriendlyName(), eventInfo.RTReflectedType(), "Instance");
			}
			SharpEvent wrapper = SharpEvent.Create(eventInfo);
			AddValueOutput("Value", wrapper.GetType(), (ValueHandlerObject)delegate
			{
				wrapper.SetInstance((instancePort != null) ? instancePort.value : null);
				return wrapper;
			}, "");
		}
	}
}
