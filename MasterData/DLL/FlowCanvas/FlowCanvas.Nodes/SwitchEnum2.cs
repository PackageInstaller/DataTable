using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("自定义的SwitchEnum", 0)]
[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on an enum value.\nPlease connect an Enum first for the options to show, or directly select the enum type with the relevant button bellow.")]
[ContextDefinedInputs(new Type[] { typeof(Enum) })]
public class SwitchEnum2<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		Type typeFromHandle = typeof(T);
		ValueInput<T> selector = AddValueInput<T>(typeFromHandle.Name, "Enum");
		if (typeFromHandle != typeof(Enum))
		{
			string[] names = Enum.GetNames(typeFromHandle);
			Array values = Enum.GetValues(typeFromHandle);
			Dictionary<T, FlowOutput> cases = new Dictionary<T, FlowOutput>();
			for (int i = 0; i < names.Length; i++)
			{
				cases[(T)values.GetValue(i)] = AddFlowOutput(names[i]);
			}
			AddFlowInput("In", delegate(Flow f)
			{
				T value = selector.value;
				cases[value].Call(f);
			});
		}
	}
}
