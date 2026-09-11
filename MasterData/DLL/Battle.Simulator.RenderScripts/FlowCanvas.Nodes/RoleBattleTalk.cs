using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放战斗喊话", 0)]
[Category("Render/战斗喊话")]
[Description("角色在战斗中的喊话")]
public class RoleBattleTalk : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> AgentIDVar = AddValueInput<int>("AgentID", "RoleBattleTalk_AgentIDVar");
		ValueInput<string> TalkContentVar = AddValueInput<string>("喊话内容", "RoleBattleTalk_TalkContentVar");
		ValueInput<long> TalkTimeVar = AddValueInput<long>("喊话时长(毫秒)", "RoleBattleTalk_TalkTimeVar");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(AgentIDVar.GetValue());
			if (agent == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				UIHelper.ShowRoleTalkContent(agent.AgentConfigID, TalkContentVar.GetValue(), TalkTimeVar.GetValue());
				flowOut.Call(f);
			}
		});
		AddValueOutput("AgentID", () => AgentIDVar.GetValue());
	}
}
