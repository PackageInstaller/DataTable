using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("开关指定挂点", 0)]
[Category("Render/Effect")]
[Description("一般用来控制挂载在某个挂点上全部特效的显隐\n只有挂载在该实体对应挂点上的特效才会被此节点控制显隐")]
public class IsHideEffectWithAttachPoint : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID", "agentID");
		ValueInput<string> attachPointInput = AddValueInput<string>("挂点名称", "attachPoint");
		ValueInput<bool> isShowInput = AddValueInput<bool>("开关状态", "isShow");
		FlowOutput trueOut = AddFlowOutput("Out", "out");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "in", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				_ = agent.GetComponent<ComponentTimeline>().TimelinePlayer;
				Transform transform = agent.gameObject.transform;
				string attachPointPath = U3DUtil.Get<AttachPointSetup>(agent.gameObject).GetAttachPointPath(attachPointInput.value);
				transform.Find(attachPointPath).transform.SetActive(isShowInput.value);
				trueOut.Call(f);
			}
		});
	}
}
