using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机初始位置", 0)]
[Category("Render/Camera")]
[Description("设置相机初始位置")]
[ExposeAsDefinition]
public class SetCameraPosAndRot : CallableActionNode<Int3, Int3>
{
	public override void Invoke(Int3 pos, Int3 rot)
	{
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		int mPlayerAgentID = agentManager.mPlayerAgentID;
		agentManager.GetAgent(mPlayerAgentID)?.GetComponent<ComponentCameraAnimation>().RotateCameraToRoleaBack();
	}
}
