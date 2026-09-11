using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开启俯视角指示器模式", 0)]
[Category("Render/UI")]
[Description("设置指示器模式，其实也就相当于把y轴是否在屏幕内也添加了判定，然后多了一个显示友方的功能")]
public class SetIndicatorMode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> modeInput = AddValueInput<bool>("开关");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.overlookMode = modeInput.value;
				}
			}
			output.Call(f);
		});
	}
}
