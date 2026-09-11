using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;
using UnityEngine.Events;

namespace FlowCanvas.Nodes;

[DoNotList]
[Name("Unity Event", 0)]
[Description("Automatically Subscribes to the target UnityEvent when the graph is enabled, and is called when the event is raised")]
public class UnityEventAutoCallbackEvent : EventNode
{
	[SerializeField]
	private SerializedFieldInfo _field;

	private ReflectedUnityEvent reflectedEvent;

	private UnityEventBase unityEvent;

	private ValueInput instancePort;

	private FlowOutput callback;

	private object[] args;

	private FieldInfo field
	{
		get
		{
			if (_field == null)
			{
				return null;
			}
			return _field.Get();
		}
	}

	public override string name
	{
		get
		{
			if (field != null && field.IsStatic)
			{
				return $"{base.name} ({field.RTReflectedType().FriendlyName()})";
			}
			return base.name;
		}
	}

	public void SetEvent(FieldInfo field, object instance = null)
	{
		_field = new SerializedFieldInfo(field);
		GatherPorts();
	}

	protected override void RegisterPorts()
	{
		if (field == null)
		{
			return;
		}
		if (reflectedEvent == null)
		{
			reflectedEvent = new ReflectedUnityEvent(field.FieldType);
		}
		if (!field.IsStatic)
		{
			instancePort = AddValueInput(field.RTReflectedType().FriendlyName(), field.RTReflectedType(), "Instance");
		}
		args = new object[reflectedEvent.parameters.Length];
		for (int i = 0; i < reflectedEvent.parameters.Length; i++)
		{
			int i2 = i;
			ParameterInfo parameterInfo = reflectedEvent.parameters[i2];
			AddValueOutput(parameterInfo.Name, "arg" + i2, parameterInfo.ParameterType, () => args[i2]);
		}
		callback = AddFlowOutput(field.Name, "Event");
	}

	public override void OnGraphStarted()
	{
		if (field == null)
		{
			return;
		}
		object obj = null;
		if (!field.IsStatic)
		{
			obj = instancePort.value;
			if (obj == null)
			{
				Fail("Target is null");
				return;
			}
		}
		unityEvent = (UnityEventBase)field.GetValue(obj);
		if (unityEvent != null)
		{
			reflectedEvent.StartListening(unityEvent, OnEventRaised);
		}
	}

	public override void OnGraphStoped()
	{
		if (unityEvent != null)
		{
			reflectedEvent.StopListening(unityEvent, OnEventRaised);
		}
	}

	private void OnEventRaised(params object[] args)
	{
		this.args = args;
		callback.Call(default(Flow));
	}
}
