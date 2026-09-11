using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("BUFF子类型检查(全部)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("检查【判断值】是否包含在【配置值】中")]
public class BuffSubTypeCheckNodeAll : FlowControlNode
{
	private ValueInput<List<string>> subTypeInput;

	private ValueInput<string> configSubTypeInput;

	private FlowOutput trueOut;

	private FlowOutput falseOut;

	protected override void RegisterPorts()
	{
		subTypeInput = AddValueInput<List<string>>("子类型(判断值)", "subType");
		configSubTypeInput = AddValueInput<string>("子类型(配置值)", "configSubType");
		trueOut = AddFlowOutput("包含", "trueOut");
		falseOut = AddFlowOutput("不包含", "falseOut");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (BuffSubTypeComparer.ContainsAll(subTypeInput.value, configSubTypeInput.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
