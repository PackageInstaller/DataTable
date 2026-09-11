using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放动画", 0)]
[Category("Render/Anime")]
[Description("播放指定动画,需要指定动画名和所在layer")]
[ExposeAsDefinition]
public class PlayAnimationWithNameAndLayer : CallableActionNode<int, string, int>
{
	public override void Invoke(int agentID, string name, int layer)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
		if (agent == null)
		{
			Debug.LogError("播放动画节点 " + agentID + " 为空");
		}
		Animator animator = agent.Animator;
		if (animator == null)
		{
			Debug.LogError("播放动画节点 " + agentID + " animator 为空");
		}
		if (animator.layerCount > layer)
		{
			animator.Play(name, layer, 0f);
		}
	}
}
