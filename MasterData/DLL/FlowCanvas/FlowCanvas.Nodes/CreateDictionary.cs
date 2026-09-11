using System;
using System.Collections.Generic;
using System.Linq;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Create a Dictionary of <string, T> objects")]
[ContextDefinedInputs(new Type[]
{
	typeof(string),
	typeof(Wild)
})]
public class CreateDictionary<T> : VariableNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
	}

	public override void SetVariable(object o)
	{
	}

	protected override void RegisterPorts()
	{
		List<ValueInput<string>> keys = new List<ValueInput<string>>();
		List<ValueInput<T>> values = new List<ValueInput<T>>();
		for (int i = 0; i < _portCount; i++)
		{
			keys.Add(AddValueInput<string>("Key" + i));
			values.Add(AddValueInput<T>("Value" + i));
		}
		AddValueOutput("Dictionary", (ValueHandler<IDictionary<string, T>>)delegate
		{
			List<string> k = keys.Select((ValueInput<string> x) => x.value).ToList();
			List<T> v = values.Select((ValueInput<T> x) => x.value).ToList();
			return k.ToDictionary((string x) => x, (string x) => v[k.IndexOf(x)]);
		}, "");
	}
}
