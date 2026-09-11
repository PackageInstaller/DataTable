using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到第三席位AgentID(渲染)", 0)]
[Category("Render/Agent")]
[Description("获取第三席位玩家的AgentID,没有则为0")]
public class GetThirdPositionAgentID : PureFunctionNode<int>
{
	public override int Invoke()
	{
		return (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mThirdAgentID;
	}
}
