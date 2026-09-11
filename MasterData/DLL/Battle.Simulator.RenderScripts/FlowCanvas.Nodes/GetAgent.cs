using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent", 0)]
[Category("Render/Agent")]
[Description("获取Agent")]
[ExposeAsDefinition]
public class GetAgent : CallableFunctionNode<NAgent, int>
{
	public override NAgent Invoke(int id)
	{
		return (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(id);
	}
}
