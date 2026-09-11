using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Toggle (Multi)", 0)]
[Description("Whenever In is called the 'current' output is called as well. Calling '+' or '-' changes the current output respectively up or down.")]
[Category("Flow Controllers/Togglers")]
[ContextDefinedOutputs(new Type[] { typeof(int) })]
public class MultiToggle : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	[Name("Start Index", 0)]
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
		});
		AddFlowInput("+", delegate
		{
			current = (int)Mathf.Repeat(current + 1, _portCount);
		});
		AddFlowInput("-", delegate
		{
			current = (int)Mathf.Repeat(current - 1, _portCount);
		});
		AddValueOutput("Current", () => current);
	}
}
