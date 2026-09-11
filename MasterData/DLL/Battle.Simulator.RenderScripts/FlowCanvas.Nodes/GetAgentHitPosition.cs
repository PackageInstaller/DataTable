using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取受击位置", 0)]
[Category("Render/Agent")]
[Description("获取受击位置")]
[ExposeAsDefinition]
public class GetAgentHitPosition : PureFunctionNode<Vector3, int, int>
{
	public override Vector3 Invoke(int agentID, int castorID)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
		((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().GetRole(agent.AgentConfigID);
		string empty = string.Empty;
		AttachPointSetup component = agent.GetComponent<AttachPointSetup>();
		((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(castorID);
		empty = component.GetAttachPointPath(En_BaseAttachPointType.HitPoint);
		if (string.IsNullOrEmpty(empty))
		{
			empty = component.GetAttachPointPath("gua_hit");
		}
		Transform transform = agent.transform.Find(empty);
		if (null == transform)
		{
			return agent.ChestPosition;
		}
		return transform.position;
	}
}
