using Cinemachine;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机碰撞时的缓动", 0)]
[Category("Render/Camera")]
[Description("设置相机碰撞时的缓动")]
public class SetCameraDampingWhenOccluded : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		ValueInput<float> dampingInput = AddValueInput<float>("Damping");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			if ((NScene.GetCurrentScene() as BattleScene).GetAgentManager().mPlayerAgentID != agentIDInput.value)
			{
				output.Call(f);
			}
			else
			{
				(NScene.GetCurrentScene() as BattleScene).virtualCameraParam.gameObject.GetComponent<CinemachineCollider>().m_DampingWhenOccluded = dampingInput.value;
				output.Call(f);
			}
		});
	}
}
