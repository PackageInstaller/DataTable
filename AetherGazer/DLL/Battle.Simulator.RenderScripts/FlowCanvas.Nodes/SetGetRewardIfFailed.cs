using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置失败也能获得奖励", 0)]
[Category("Render/UI")]
[Description("设置失败也能获得奖励")]
public class SetGetRewardIfFailed : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> valueInput = AddValueInput<bool>("失败是否能获得奖励");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().getRewardIfFailed = valueInput.value;
			output.Call(f);
		});
	}
}
