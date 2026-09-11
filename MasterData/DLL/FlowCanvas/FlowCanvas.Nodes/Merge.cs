using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Utility node to merge the flow. It's exactly the same as connecting multiple Flow outputs to the same Flow input.")]
[Name("Merge", 89)]
public class Merge : FlowControlNode
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
		FlowOutput flowOutput = AddFlowOutput("Out");
		for (int i = 0; i < _portCount; i++)
		{
			AddFlowInput(i.ToString(), flowOutput.Call);
		}
	}
}
