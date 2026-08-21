using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Latch Integer", 0)]
[Category("Flow Controllers/Flow Convert")]
[Description("Convert a Flow signal to an integer value")]
[ContextDefinedOutputs(new Type[] { typeof(int) })]
public class LatchInt : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	private int latched;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		for (int i = 0; i < _portCount; i++)
		{
			int i2 = i;
			AddFlowInput(i2.ToString(), delegate(Flow f)
			{
				latched = i2;
				o.Call(f);
			});
		}
		AddValueOutput("Value", () => latched);
	}
}
