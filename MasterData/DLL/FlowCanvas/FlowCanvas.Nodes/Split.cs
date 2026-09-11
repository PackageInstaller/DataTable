using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Split the Flow in multiple directions. Calls all outputs in the same frame but in order")]
[Name("Split", 90)]
public class Split : FlowControlNode
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

	protected override void RegisterPorts()
	{
		List<FlowOutput> outs = new List<FlowOutput>();
		for (int i = 0; i < _portCount; i++)
		{
			outs.Add(AddFlowOutput(i.ToString()));
		}
		AddFlowInput("In", delegate(Flow f)
		{
			for (int j = 0; j < _portCount; j++)
			{
				if (!base.graph.isRunning)
				{
					break;
				}
				outs[j].Call(f);
			}
		});
	}
}
