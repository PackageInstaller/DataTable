using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑曲线", 0)]
[Category("Common/Config")]
[Description("将输入值直接变换为曲线内计算的直线插值\n适用情况：值变换为超过2段的分段函数时。")]
public class LogicInterpolator : LogicInterpolatorBase
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> xInput = AddValueInput<int>("x");
		int y = 0;
		AddValueOutput("y", () => y);
		AddFlowInput("", delegate(Flow f)
		{
			y = intCurve.Evaluate(xInput.value);
			output.Call(f);
		});
	}
}
