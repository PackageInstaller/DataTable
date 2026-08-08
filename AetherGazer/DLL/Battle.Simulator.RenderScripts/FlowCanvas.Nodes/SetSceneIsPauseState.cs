using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Set BattleScene.isPause", 0)]
[Category("Render/Helper")]
[Description("Set BattleScene.isPause")]
public class SetSceneIsPauseState : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<bool> valueInput = AddValueInput<bool>("值");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene.isPause = valueInput.value;
			output.Call(f);
		});
	}
}
