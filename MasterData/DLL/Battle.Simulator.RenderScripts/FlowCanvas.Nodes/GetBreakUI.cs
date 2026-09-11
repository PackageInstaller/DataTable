using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取正在显示的破坏条(渲染)", 0)]
[Category("Render/UI")]
[Description("获取正在显示的破坏条")]
public class GetBreakUI : FlowNode
{
	protected override void RegisterPorts()
	{
		int entityID = 0;
		int partID = 0;
		AddValueOutput("agentID", () => entityID);
		AddValueOutput("部位ID", () => partID);
		FlowOutput output = AddFlowOutput("Success");
		FlowOutput failOutput = AddFlowOutput("Fail");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleUI battleUI = BattleUI.GetBattleUI();
			BreakUIStruct firstRuningUI;
			if (battleUI == null)
			{
				failOutput.Call(f);
			}
			else if (battleUI.PartBreakUI.GetFirstRuningUI(out firstRuningUI))
			{
				entityID = firstRuningUI.mTarget.AgentID;
				partID = firstRuningUI.mLockAgentPart;
				output.Call(f);
			}
			else
			{
				failOutput.Call(f);
			}
		});
	}
}
