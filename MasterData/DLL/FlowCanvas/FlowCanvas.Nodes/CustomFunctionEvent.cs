using System;
using System.Collections.Generic;
using System.Linq;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("New Custom Function", 10)]
[Description("A custom function, defined by any number of parameters and an optional return value. It can be called using the 'Call Custom Function' node. To end the function and optionally return a value, the 'Return' node should be used.")]
[Category("Functions/Custom")]
[DeserializeFrom(new string[] { "FlowCanvas.Nodes.RelayFlowOutput" })]
public class CustomFunctionEvent : EventNode, IInvokable, IEditorMenuCallbackReceiver
{
	[Tooltip("The identifier name of the function")]
	[DelayedField]
	public string identifier = "MyFunction";

	[SerializeField]
	private List<DynamicPortDefinition> _parameters = new List<DynamicPortDefinition>();

	[SerializeField]
	private DynamicPortDefinition _returns = new DynamicPortDefinition("Value", null);

	private object[] args;

	private object returnValue;

	private FlowOutput onInvoke;

	private bool isInvoking;

	public List<DynamicPortDefinition> parameters
	{
		get
		{
			return _parameters;
		}
		private set
		{
			_parameters = value;
		}
	}

	public DynamicPortDefinition returns
	{
		get
		{
			return _returns;
		}
		private set
		{
			_returns = value;
		}
	}

	private Type returnType => returns.type;

	private Type[] parameterTypes => parameters.Select((DynamicPortDefinition p) => p.type).ToArray();

	public override string name => "➥ " + identifier;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		int num = reader.ReadInt32();
		for (int i = 0; i < num; i++)
		{
			string iD = reader.ReadString();
			string text = reader.ReadString();
			string typeFullName = reader.ReadString();
			DynamicPortDefinition dynamicPortDefinition = new DynamicPortDefinition();
			dynamicPortDefinition.name = text;
			dynamicPortDefinition.ID = iD;
			dynamicPortDefinition.type = ReflectionTools.GetType(typeFullName, fallbackNoNamespace: true);
			_parameters.Add(dynamicPortDefinition);
		}
		_returns.ID = reader.ReadString();
		_returns.name = reader.ReadString();
		if (reader.ReadBoolean())
		{
			_returns.type = ReflectionTools.GetType(reader.ReadString(), fallbackNoNamespace: true);
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write(_parameters.Count);
		for (int i = 0; i < _parameters.Count; i++)
		{
			writer.Write(_parameters[i].ID);
			writer.Write(_parameters[i].name);
			writer.Write(_parameters[i].type.FullName);
		}
		writer.Write(_returns.ID);
		writer.Write(_returns.name);
		if (_returns.type == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
		writer.Write(_returns.type.FullName);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		isInvoking = false;
	}

	protected override void RegisterPorts()
	{
		onInvoke = AddFlowOutput(" ");
		for (int i = 0; i < parameters.Count; i++)
		{
			int i2 = i;
			DynamicPortDefinition dynamicPortDefinition = parameters[i2];
			AddValueOutput(dynamicPortDefinition.name, dynamicPortDefinition.ID, dynamicPortDefinition.type, () => args[i2]);
		}
	}

	string IInvokable.GetInvocationID()
	{
		return identifier;
	}

	object IInvokable.Invoke(params object[] args)
	{
		return Invoke(default(Flow), args);
	}

	void IInvokable.InvokeAsync(Action<object> callback, params object[] args)
	{
		InvokeAsync(default(Flow), delegate
		{
			callback(returnValue);
		}, args);
	}

	public object Invoke(Flow f, params object[] args)
	{
		if (isInvoking)
		{
			ParadoxNotion.Services.Logger.LogWarning("Invoking a custom function which is already running is currently not supported.", "Execution", this);
			return null;
		}
		this.args = args;
		isInvoking = true;
		f.PushReturnData(delegate(object o)
		{
			returnValue = o;
		}, returns.type);
		isInvoking = false;
		onInvoke.Call(f);
		return returnValue;
	}

	public void InvokeAsync(Flow f, FlowHandler Callback, params object[] args)
	{
		if (isInvoking)
		{
			ParadoxNotion.Services.Logger.LogWarning("Invoking a custom function which is already running is currently not supported.", "Execution", this);
			Debug.LogError("graph.name " + base.graph.name + ", " + name + ", " + Callback.Method.Name + "参数:");
			for (int i = 0; i < args.Length; i++)
			{
				Debug.Log(args[i]);
			}
		}
		else
		{
			this.args = args;
			isInvoking = true;
			f.PushReturnData(delegate(object o)
			{
				returnValue = o;
				isInvoking = false;
				Callback(f);
			}, returns.type);
			onInvoke.Call(f);
		}
	}

	public object GetReturnValue()
	{
		return returnValue;
	}

	private void AddParameter(Type type)
	{
		parameters.Add(new DynamicPortDefinition(type.FriendlyName(), type));
		GatherPortsUpdateRefs();
	}

	private void GatherPortsUpdateRefs()
	{
		GatherPorts();
		foreach (CustomFunctionCall item in from n in base.flowGraph.GetAllNodesOfType<CustomFunctionCall>()
			where n.sourceFunction == this
			select n)
		{
			item.GatherPorts();
		}
	}
}
