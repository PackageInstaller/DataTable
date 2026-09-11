using System;
using System.Collections.Generic;
using System.Linq;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Create a collection of <T> objects")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
[ContextDefinedOutputs(new Type[] { typeof(List<>) })]
public class CreateCollection<T> : VariableNode
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
		List<ValueInput<T>> ins = new List<ValueInput<T>>();
		for (int i = 0; i < _portCount; i++)
		{
			ins.Add(AddValueInput<T>("Element" + i));
		}
		AddValueOutput("Collection", () => ins.Select((ValueInput<T> p) => p.value).ToArray());
	}
}
