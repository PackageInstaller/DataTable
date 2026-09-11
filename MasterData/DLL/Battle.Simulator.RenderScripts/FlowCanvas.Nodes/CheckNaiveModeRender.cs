using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否处于和谐模式(渲染)", 0)]
[Category("Render/Control")]
[Description("根据游戏模式进行分支")]
public class CheckNaiveModeRender : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("和谐模式");
		FlowOutput falseOut = AddFlowOutput("非和谐模式");
		AddFlowInput("", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(PlayerPrefs.GetString("naive_angle_mode_key", "naive")))
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
