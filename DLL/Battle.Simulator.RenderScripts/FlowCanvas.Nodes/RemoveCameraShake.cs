using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除相机震动", 0)]
[Category("Render/Camera")]
[Description("移除相机震动")]
public class RemoveCameraShake : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("AgentID", () => agentIDInput.value);
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("全局震动");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				output.Call(f);
			}
			else if (agentManager.mPlayerAgentID != agentIDInput.value && !botherOthersInput.value)
			{
				output.Call(f);
			}
			else
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent == null)
				{
					output.Call(f);
				}
				else
				{
					ComponentCameraAnimation component = playerAgent.GetComponent<ComponentCameraAnimation>();
					if (component == null)
					{
						output.Call(f);
					}
					else
					{
						component.RemoveCameraShake(buffIDInput.value);
						output.Call(f);
					}
				}
			}
		});
	}
}
