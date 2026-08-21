using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机初始位置(缓动版)", 0)]
[Category("Render/Camera")]
[Description("设置相机初始位置(缓动版)")]
[ExposeAsDefinition]
public class SetCameraPosAndRotWithTime : CallableActionNode<Int3, Int3, float>
{
	public override void Invoke(Int3 pos, Int3 rot, float time)
	{
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		int mPlayerAgentID = agentManager.mPlayerAgentID;
		agentManager.GetAgent(mPlayerAgentID)?.GetComponent<ComponentCameraAnimation>().RotateCameraToRoleaBackWithTime(time);
	}
}
