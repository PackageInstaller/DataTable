using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置队友准备状态", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("设置队友准备状态")]
public class ShowReadyMask : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentID = AddValueInput<int>("AgentID");
		ValueInput<bool> readyInput = AddValueInput<bool>("准备状态");
		ValueInput<string> pathInput = AddValueInput<string>("队友准备状态遮罩路径名").SetDefaultAndSerializedValue("OnlineMask");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID.GetValue());
			if (agent == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				RoleTalkPanel roleTalkPanel = (agent as AgentHuman).RoleTalkPanel;
				if (roleTalkPanel != null)
				{
					roleTalkPanel.transform.Find(pathInput.value)?.SetActive(readyInput.value);
				}
				flowOut.Call(f);
			}
		});
	}
}
