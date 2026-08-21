namespace FlowCanvas.Nodes;

public class SetBattleSceneDisable : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				battleScene.enabled = false;
			}
			f.Call(output);
		});
	}
}
