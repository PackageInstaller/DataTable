using System;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Togglers")]
[Description("Flip Flops between the 2 outputs each time In is called")]
[ContextDefinedOutputs(new Type[] { typeof(bool) })]
public class FlipFlop : FlowControlNode
{
	public bool isFlip = true;

	private bool original;

	public override string name => base.name + " " + (isFlip ? "[FLIP]" : "[FLOP]");

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(isFlip);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		isFlip = reader.ReadBoolean();
	}

	public override void OnGraphStarted()
	{
		original = isFlip;
	}

	public override void OnGraphStoped()
	{
		isFlip = original;
	}

	protected override void RegisterPorts()
	{
		FlowOutput fFlip = AddFlowOutput("Flip");
		FlowOutput fFlop = AddFlowOutput("Flop");
		AddFlowInput("In", delegate(Flow f)
		{
			f.Call(isFlip ? fFlip : fFlop);
			isFlip = !isFlip;
		});
		AddFlowInput("Reset", delegate
		{
			isFlip = false;
		});
		AddValueOutput("Is Flip", () => isFlip);
	}
}
