using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("取消相机锁敌", 0)]
[Category("Render/Camera")]
[Description("取消相机锁敌")]
public class SetCameraLoseTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			if (agent.IsLocalPlayer)
			{
				agent.GetComponent<ComponentCameraAnimation>().LockTargetCinemachine.SetLoseTarget();
			}
			output.Call(f);
		});
	}
}
