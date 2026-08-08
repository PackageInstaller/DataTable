using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置游戏结束条件触发器ID", 0)]
[Category("Render/UI")]
[Description("设置游戏结束条件触发器ID")]
public class SetGameOverConditionTriggerID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().GameOverConditionTriggerID = triggerIDInput.value;
			output.Call(f);
		});
	}
}
