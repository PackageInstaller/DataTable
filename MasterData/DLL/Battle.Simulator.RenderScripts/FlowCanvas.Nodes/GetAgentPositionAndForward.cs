using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到实体位置和朝向(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("得到实体位置和朝向")]
public class GetAgentPositionAndForward : FlowControlNode
{
	private Transform m_transform;

	private Vector3 m_position = Vector3.zero;

	private Vector3 m_forward = Vector3.forward;

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
				m_position = agent.transform.position;
				m_forward = agent.transform.forward.normalized;
				trueOutput.Call(f);
			}
			else
			{
				m_transform = null;
				m_position = Vector3.zero;
				m_forward = Vector3.forward;
				falseOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.GetValue());
		AddValueOutput("Transform", "transform", () => m_transform);
		AddValueOutput("位置", "position", () => m_position);
		AddValueOutput("朝向", "forward", () => m_forward);
	}
}
