using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Description("Calls one random output each time In is called")]
[Category("Render/Flow Controllers/Togglers")]
[ContextDefinedOutputs(new Type[]
{
	typeof(Flow),
	typeof(int)
})]
public class Random : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	private int current;

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
			current = UnityEngine.Random.Range(0, _portCount);
			outs[current].Call(f);
		});
		AddValueOutput("Current", () => current);
	}
}
