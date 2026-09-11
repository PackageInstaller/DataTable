using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Flip Flop (Multi)", 0)]
[Category("Flow Controllers/Togglers")]
[Description("Each time input is signaled, the next output in order is called. After the last output, the order loops from the start.\nReset, resets the current index to zero.")]
[ContextDefinedOutputs(new Type[] { typeof(int) })]
public class Sequence : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	[MinValue(0)]
	public int current;

	private int original;

	public override string name => base.name + " " + $"[{current.ToString()}]";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
		writer.Write(current);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
		current = reader.ReadInt32();
	}

	public override void OnGraphStarted()
	{
		current = Mathf.Clamp(current, 0, _portCount - 1);
		original = current;
	}

	public override void OnGraphStoped()
	{
		current = original;
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
			outs[current].Call(f);
			current = (int)Mathf.Repeat(current + 1, _portCount);
		});
		AddFlowInput("Reset", delegate
		{
			current = 0;
		});
		AddValueOutput("Current", () => current);
	}
}
