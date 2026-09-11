using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到席位AgentID(渲染)", 0)]
[Category("Render/Agent")]
[Description("根据传入的席位参数,得到玩家的AgentID")]
public class GetAgentIDByMemberPosition : PureFunctionNode<int, MemberPosition>
{
	public override int Invoke(MemberPosition memberPosition)
	{
		return (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgentIDByMemberPosition(memberPosition);
	}
}
