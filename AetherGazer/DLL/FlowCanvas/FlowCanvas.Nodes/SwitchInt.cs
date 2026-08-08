using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Switch Integer", 0)]
[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on an integer value. The Default output is called when the Index value is out of range.")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
public class SwitchInt : FlowControlNode
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
		ValueInput<int> selector = AddValueInput<int>("Value", "Index");
		FlowOutput[] cases = new FlowOutput[_portCount];
		for (int i = 0; i < cases.Length; i++)
		{
			cases[i] = AddFlowOutput(i.ToString());
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = selector.value;
			f.Call((value >= 0 && value < cases.Length) ? cases[value] : defaultCase);
		});
	}
}
