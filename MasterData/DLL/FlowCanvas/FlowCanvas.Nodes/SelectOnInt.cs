using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[ExposeAsDefinition]
[ContextDefinedInputs(new Type[]
{
	typeof(Wild),
	typeof(int)
})]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[Category("Flow Controllers/Selectors")]
[Description("Select a Result value out of the input cases provided, based on an Integer")]
public class SelectOnInt<T> : FlowControlNode
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
		ValueInput<int> selector = AddValueInput<int>("Value");
		ValueInput<T>[] cases = new ValueInput<T>[_portCount];
		for (int i = 0; i < _portCount; i++)
		{
			cases[i] = AddValueInput<T>("Is " + i, i.ToString());
		}
		ValueInput<T> defaultCase = AddValueInput<T>("Default");
		AddValueOutput("Result", "Value", (ValueHandler<T>)delegate
		{
			int value = selector.value;
			return (value >= 0 && value < cases.Length) ? cases[value].value : defaultCase.value;
		});
	}
}
