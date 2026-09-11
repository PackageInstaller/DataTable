using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Create a Dictionary of <T1, T2> objects")]
[ContextDefinedInputs(new Type[]
{
	typeof(int),
	typeof(Wild)
})]
public class MyCreateDictionary<T> : VariableNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	private Dictionary<int, T> keyvalue = new Dictionary<int, T>();

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
	}

	public override void SetVariable(object o)
	{
	}

	protected override void RegisterPorts()
	{
		new List<ValueInput<int>>();
		new List<ValueInput<T>>();
		for (int i = 0; i < _portCount; i++)
		{
			ValueInput<int> valueInput = AddValueInput<int>("Key" + i);
			ValueInput<T> valueInput2 = AddValueInput<T>("Value" + i);
			keyvalue[valueInput.value] = valueInput2.value;
		}
		AddValueOutput("Dictionary", () => keyvalue);
	}
}
