using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关部位破坏值UI(渲染)", 0)]
[Category("Render/UI")]
[Description("开关部位破坏值UI")]
public class OpenCloseBreakUI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> openInput = AddValueInput<bool>("开关");
		FlowOutput mOutput = AddFlowOutput("out");
		FlowOutput mError = AddFlowOutput("error");
		AddFlowInput("in", delegate(Flow f)
		{
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI == null)
			{
				mError.Call(f);
			}
			else
			{
				battleUI.PartBreakUI.mInit = openInput.value;
				mOutput.Call(f);
			}
		});
	}
}
