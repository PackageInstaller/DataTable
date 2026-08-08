using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置锁定图标缩放", 0)]
[Category("Render/Camera")]
[Description("设置锁定图标缩放")]
public class SetLockEffectScale : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<float> scaleInput = AddValueInput<float>("大小");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.lockEffectScale = scaleInput.value;
				}
			}
			output.Call(f);
		});
	}
}
