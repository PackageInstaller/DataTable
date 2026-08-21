using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑曲线(抛掷物时间)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("将抛掷物当前运行时间作为输入值，得到曲线内计算的直线插值。\n适用情况：值变换为超过2段的分段函数时。\n抛掷物不存在时输出Error与0\n不使用毫秒时，输入值为帧数")]
public class LogicInterpolatorThrownTime : LogicInterpolatorBase
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<bool> useTimeMSInput = AddValueInput<bool>("使用毫秒");
		int y = 0;
		AddValueOutput("y", () => y);
		AddFlowInput("", delegate(Flow f)
		{
			y = 0;
			List<ThrownState> mThrowns = CommonProcessor.GetWorldState().mThrowns;
			int value = thrownIDInput.GetValue();
			for (int num = mThrowns.Count - 1; num >= 0; num--)
			{
				ThrownState thrownState = mThrowns[num];
				if (thrownState.mCreationIndex == value)
				{
					int num2 = thrownState.mLogicTime;
					if (!useTimeMSInput.value)
					{
						num2 /= CommonProcessor.GetConfigInterval();
					}
					y = intCurve.Evaluate(num2);
					output.Call(f);
					return;
				}
			}
			errorOutput.Call(f);
		});
	}
}
