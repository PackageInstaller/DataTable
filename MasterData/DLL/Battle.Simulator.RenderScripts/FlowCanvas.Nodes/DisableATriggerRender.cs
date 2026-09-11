using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用单个触发器(渲染)", 0)]
[Category("Render/Trigger")]
[Description("禁用触发器")]
public class DisableATriggerRender : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager().DisableATrigger(triggerIDInput.value);
			output.Call(f);
		});
	}
}
