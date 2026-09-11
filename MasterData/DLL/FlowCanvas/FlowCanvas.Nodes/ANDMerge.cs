using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AND", 0)]
[Category("Flow Controllers/Flow Merge")]
[Description("Calls Out when all inputs are called together in the same frame, but the output is only called once per frame regardless of number of inputs called.")]
public class ANDMerge : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 2;

	private FlowOutput fOut;

	private int[] calls;

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
		calls = new int[_portCount];
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
		calls[index] = Time.frameCount;
		for (int i = 0; i < calls.Length; i++)
		{
			if (calls[i] != calls[index])
			{
				return;
			}
		}
		if (Time.frameCount != lastFrameCall)
		{
			lastFrameCall = Time.frameCount;
			fOut.Call(f);
		}
	}
}
