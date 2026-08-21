using System;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Delegate Callback", 1)]
[Category("Events/Custom")]
[Description("The exposed Delegate points directly to the 'Callback' output. You can connect this delegate as listener to a Unity or C# Event using the AddListener function of that Unity Event, or the += function of that C# Event. When that event is raised, this node will be called.")]
[ContextDefinedOutputs(new Type[]
{
	typeof(Flow),
	typeof(Delegate)
})]
public class DelegateCallbackEvent : EventNode
{
	[SerializeField]
	private SerializedTypeInfo _type;

	private ReflectedDelegateEvent reflectedEvent;

	private ValueOutput delegatePort;

	private FlowOutput callbackPort;

	private object[] args;

	private Type delegateType
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

	protected override void RegisterPorts()
	{
		delegateType = ((delegateType != null) ? delegateType : typeof(Delegate));
		delegatePort = AddValueOutput(delegateType.FriendlyName(), "Delegate", delegateType, () => reflectedEvent.AsDelegate());
		callbackPort = AddFlowOutput("Callback");
		if (delegateType == typeof(Delegate))
		{
			return;
		}
		if (reflectedEvent == null)
		{
			reflectedEvent = new ReflectedDelegateEvent(delegateType);
			reflectedEvent.Add(Callback);
		}
		ParameterInfo[] array = delegateType.RTGetDelegateTypeParameters();
		for (int num = 0; num < array.Length; num++)
		{
			int i = num;
			ParameterInfo parameterInfo = array[i];
			AddValueOutput(parameterInfo.Name, "arg" + i, parameterInfo.ParameterType, () => args[i]);
		}
	}

	private void Callback(params object[] args)
	{
		this.args = args;
		callbackPort.Call(default(Flow));
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (port == delegatePort && otherPort.type.RTIsSubclassOf(typeof(Delegate)))
		{
			delegateType = otherPort.type;
			GatherPorts();
		}
	}
}
