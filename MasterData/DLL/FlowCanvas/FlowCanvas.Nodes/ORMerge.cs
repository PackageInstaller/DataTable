using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("OR", 0)]
[Category("Flow Controllers/Flow Merge")]
[Description("Calls Out when either input is called, but only once per frame regardless of how many inputs are called.")]
public class ORMerge : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 2;

	private FlowOutput fOut;

	private int lastFrameCall;

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
		fOut = AddFlowOutput("Out");
		for (int i = 0; i < _portCount; i++)
		{
			int i2 = i;
			AddFlowInput(i2.ToString(), delegate(Flow f)
			{
				Check(i2, f);
			});
		}
	}

	private void Check(int index, Flow f)
	{
		if (Time.frameCount != lastFrameCall)
		{
			lastFrameCall = Time.frameCount;
			fOut.Call(f);
		}
	}
}
