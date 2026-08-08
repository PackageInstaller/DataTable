using Google.Protobuf.Collections;
using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是誓约角色(渲染)", 0)]
[Category("Render/Config")]
[Description("判断传进来的角色是否是誓约角色")]
public class IsVowRole : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		FlowOutput trueOut = AddFlowOutput("是", "ture");
		FlowOutput falseOut = AddFlowOutput("否", "false");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			MemberPosition memberPositionByAgentID = AgentManager.GetAgentManager().GetMemberPositionByAgentID(agentIDInput.value);
			RepeatedField<RoleDataForExchangeInfo> roleDataInLua = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
			if (memberPositionByAgentID != MemberPosition.None && roleDataInLua.Count > (int)memberPositionByAgentID && roleDataInLua.get_Item((int)memberPositionByAgentID).IsVow)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
