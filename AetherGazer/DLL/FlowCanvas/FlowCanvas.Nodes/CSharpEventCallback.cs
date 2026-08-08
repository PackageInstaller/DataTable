using System;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("C# Event Callback", 2)]
[Category("Events/Custom")]
[Description("Providing a C# Event, Register a callback to be called when that event is raised.")]
[ContextDefinedInputs(new Type[] { typeof(SharpEvent) })]
public class CSharpEventCallback : EventNode
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

	private ReflectedDelegateEvent reflectedEvent;

	private Type type
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

	private bool autoHandleRegistration => _autoHandleRegistration;

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

	protected override void RegisterPorts()
	{
		type = ((type != null) ? type : typeof(SharpEvent));
		eventInput = AddValueInput("Event", type);
		if (type == typeof(SharpEvent))
		{
			return;
		}
		Type delegateType = type.RTGetGenericArguments()[0];
		if (reflectedEvent == null)
		{
			reflectedEvent = new ReflectedDelegateEvent(delegateType);
		}
		ParameterInfo[] array = delegateType.RTGetDelegateTypeParameters();
		for (int i = 0; i < array.Length; i++)
		{
			int i2 = i;
			ParameterInfo parameterInfo = array[i2];
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
		if (eventInput.value is SharpEvent sharpEvent)
		{
			sharpEvent.StopListening(reflectedEvent, Callback);
			sharpEvent.StartListening(reflectedEvent, Callback);
		}
	}

	private void Unregister(Flow f = default(Flow))
	{
		if (eventInput.value is SharpEvent sharpEvent)
		{
			sharpEvent.StopListening(reflectedEvent, Callback);
		}
	}

	private void Callback(params object[] args)
	{
		argValues = args;
		flowCallback.Call(default(Flow));
	}

	public override Type GetNodeWildDefinitionType()
	{
		return typeof(SharpEvent);
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (port == eventInput && otherPort.type.RTIsSubclassOf(typeof(SharpEvent)))
		{
			type = otherPort.type;
			GatherPorts();
		}
	}
}
