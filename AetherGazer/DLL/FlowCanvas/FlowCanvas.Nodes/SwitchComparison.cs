using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on a comparison between two comparable objects, 整型的话用--比较大小--这个节点代替")]
[ContextDefinedInputs(new Type[] { typeof(IComparable) })]
public class SwitchComparison : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("A = B", "==");
		FlowOutput notEqual = AddFlowOutput("A ≠ B", "!=");
		FlowOutput greater = AddFlowOutput("A > B", ">");
		FlowOutput less = AddFlowOutput("A < B", "<");
		ValueInput<IComparable> a = AddValueInput<IComparable>("A");
		ValueInput<IComparable> b = AddValueInput<IComparable>("B");
		AddFlowInput("In", delegate(Flow f)
		{
			IComparable value = a.value;
			IComparable value2 = b.value;
			if (value == null || value2 == null)
			{
				if (value == value2)
				{
					equal.Call(f);
				}
				if (value != value2)
				{
					notEqual.Call(f);
				}
			}
			else
			{
				int num = TypeConverter.QuickConvert<int>(value);
				int num2 = TypeConverter.QuickConvert<int>(value2);
				if (num == num2)
				{
					equal.Call(f);
				}
				else
				{
					notEqual.Call(f);
				}
				if (num > num2)
				{
					greater.Call(f);
				}
				if (num < num2)
				{
					less.Call(f);
				}
			}
		});
	}
}
