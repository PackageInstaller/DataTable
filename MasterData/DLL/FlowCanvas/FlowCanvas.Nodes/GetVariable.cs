using System;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Graph Variable", 99)]
[Category("Variables")]
[Description("Returns a constant or linked variable value.\nYou can alter between constant or linked at any time using the radio button.")]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public class GetVariable<T> : VariableNode
{
	public BBParameter<T> value;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		value.varRef = null;
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			Debug.LogError("var is empty!!");
		}
		options.Resolver.GetFormatterWithVerify<BBParameter<T>>().Serialize(ref writer, value, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		value = options.Resolver.GetFormatterWithVerify<BBParameter<T>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("Value", () => value.value);
	}

	public void SetTargetVariableName(string name)
	{
		value.name = name;
	}

	public override void SetVariable(object o)
	{
		if (o is Variable<T>)
		{
			value.name = (o as Variable<T>).name;
		}
		else if (o is T)
		{
			value.value = (T)o;
		}
		else
		{
			Debug.LogError("Set Variable Error");
		}
	}
}
