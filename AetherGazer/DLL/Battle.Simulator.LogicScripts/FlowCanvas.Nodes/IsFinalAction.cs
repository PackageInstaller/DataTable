using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为终结动作", 0)]
[Category("Common/Config")]
[Description("读配置,判断是否为终结动作")]
public class IsFinalAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			ConfigHelper.GetInstance().TryGetConfig<Timeline>(idInput.value, out var config);
			if (config == null || !config.IsFinalAction)
			{
				falseOut.Call(f);
			}
			else
			{
				trueOut.Call(f);
			}
		});
	}
}
