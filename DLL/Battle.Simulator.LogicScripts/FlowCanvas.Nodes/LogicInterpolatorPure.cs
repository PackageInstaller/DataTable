using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑曲线(Pure)", 0)]
[Category("Common/Config")]
[Description("将输入值直接变换为曲线内计算的直线插值\n适用情况：值变换为超过2段的分段函数时。")]
public class LogicInterpolatorPure : LogicInterpolatorBase
{
	protected override void RegisterPorts()
	{
		ValueInput<int> xInput = AddValueInput<int>("x");
		AddValueOutput("y", () => intCurve.Evaluate(xInput.value));
	}
}
