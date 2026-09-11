using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent", 0)]
[Category("Render/Agent")]
[Description("获取Agent")]
[ExposeAsDefinition]
public class GetAllAgents : CallableFunctionNode<Dictionary<int, NAgent>>
{
	public override Dictionary<int, NAgent> Invoke()
	{
		return (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mAgentsCreatedThisFrame;
	}
}
