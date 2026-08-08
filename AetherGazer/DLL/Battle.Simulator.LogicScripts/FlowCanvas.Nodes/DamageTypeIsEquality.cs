using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("输入的伤害类型是否为指定伤害类型", 0)]
[Category("Logic/Control")]
[Description("输入的伤害类型是否为指定伤害类型")]
public class DamageTypeIsEquality : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput inRange = AddFlowOutput("True");
		FlowOutput outRange = AddFlowOutput("False");
		ValueInput<DamageType> v = AddValueInput<DamageType>("Value");
		ValueInput<DamageType> i = AddValueInput<DamageType>("Input");
		AddFlowInput("In", delegate(Flow f)
		{
			if (v.value == i.value)
			{
				inRange.Call(f);
			}
			else
			{
				outRange.Call(f);
			}
		});
	}
}
