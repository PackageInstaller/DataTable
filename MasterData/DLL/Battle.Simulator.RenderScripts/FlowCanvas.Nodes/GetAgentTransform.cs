using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到实体绑定的Transform(渲染)", 0)]
[Category("Render/Agent")]
[Description("得到实体绑定的Transform")]
public class GetAgentTransform : FlowControlNode
{
	private Transform m_transform;

	protected override void RegisterPorts()
	{
		FlowOutput trueOutput = AddFlowOutput("找到", "trueOutput");
		FlowOutput falseOutput = AddFlowOutput("未找到", "falseOutput");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar").SetDefaultAndSerializedValue(0);
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDVar.GetValue());
			if (agent != null)
			{
				m_transform = agent.transform;
				trueOutput.Call(f);
			}
			else
			{
				m_transform = null;
				falseOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.GetValue());
		AddValueOutput("位置", "position", () => m_transform);
	}
}
