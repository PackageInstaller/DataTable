using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Get BattleScene.isPause", 0)]
[Category("Render/Helper")]
[Description("Get BattleScene.isPause")]
public class GetSceneIsPauseState : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("值", () => BattleScene.isPause);
	}
}
