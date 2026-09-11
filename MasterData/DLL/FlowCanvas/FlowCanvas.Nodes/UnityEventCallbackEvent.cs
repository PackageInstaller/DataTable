using System;
using System.Reflection;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;
using UnityEngine.Events;

namespace FlowCanvas.Nodes;

[Name("Unity Event Callback", 3)]
[Category("Events/Custom")]
[Description("Register a callback on a UnityEvent.\nWhen that event is raised, this node will get called.")]
[ContextDefinedInputs(new Type[] { typeof(UnityEventBase) })]
public class UnityEventCallbackEvent : EventNode
{
	[SerializeField]
	[ExposeField]
	[Tooltip("If enabled, registration will be handled on graph Enable/Disable automatically")]
	[GatherPortsCallback]
	private bool _autoHandleRegistration;

	[SerializeField]
	private SerializedTypeInfo _type;

	private object[] argValues;

	private ValueInput eventInput;

	private FlowOutput flowCallback;

	private ReflectedUnityEvent reflectedEvent;

	private Type eventType
	{
		get
		{
			if (_type == null)
			{
				return null;
			}
			return _type.Get();
		}
		set
		{
			if (_type == null || _type.Get() != value)
			{
				_type = new SerializedTypeInfo(value);
			}
		}
	}

	public bool autoHandleRegistration => _autoHandleRegistration;

	public override void OnGraphStarted()
	{
		if (autoHandleRegistration)
		{
			Register();
		}
	}

	public override void OnGraphStoped()
	{
		if (autoHandleRegistration)
		{
			Unregister();
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_autoHandleRegistration);
		writer.Write(_type._baseInfo);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_autoHandleRegistration = reader.ReadBoolean();
		string text = reader.ReadString();
		SerializedTypeInfo serializedTypeInfo = new SerializedTypeInfo();
		serializedTypeInfo._baseInfo = text;
		serializedTypeInfo.FindType(text);
		_type = serializedTypeInfo;
	}

	protected override void RegisterPorts()
	{
		eventType = ((eventType != null) ? eventType : typeof(UnityEventBase));
		eventInput = AddValueInput("Event", eventType);
		if (eventType == typeof(UnityEventBase))
		{
			return;
		}
		if (reflectedEvent == null)
		{
			reflectedEvent = new ReflectedUnityEvent(eventType);
		}
		if (reflectedEvent.eventType != eventType)
		{
			reflectedEvent.InitForEventType(eventType);
		}
		argValues = new object[reflectedEvent.parameters.Length];
		for (int i = 0; i < reflectedEvent.parameters.Length; i++)
		{
			int i2 = i;
			ParameterInfo parameterInfo = reflectedEvent.parameters[i2];
			AddValueOutput(parameterInfo.Name, "arg" + i2, parameterInfo.ParameterType, () => argValues[i2]);
		}
		flowCallback = AddFlowOutput("Callback");
		if (!autoHandleRegistration)
		{
			AddFlowInput("Register", Register, "Add");
			AddFlowInput("Unregister", Unregister, "Remove");
		}
	}

	private void Register(Flow f = default(Flow))
	{
		if (eventInput.value is UnityEventBase targetEvent)
		{
			reflectedEvent.StopListening(targetEvent, OnEventRaised);
			reflectedEvent.StartListening(targetEvent, OnEventRaised);
		}
	}

	private void Unregister(Flow f = default(Flow))
	{
		if (eventInput.value is UnityEventBase targetEvent)
		{
			reflectedEvent.StopListening(targetEvent, OnEventRaised);
		}
	}

	private void OnEventRaised(params object[] args)
	{
		argValues = args;
		flowCallback.Call(default(Flow));
	}

	public override Type GetNodeWildDefinitionType()
	{
		return typeof(UnityEventBase);
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (port == eventInput && otherPort.type.RTIsSubclassOf(typeof(UnityEventBase)))
		{
			eventType = otherPort.type;
			GatherPorts();
		}
	}
}
