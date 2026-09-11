using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟按下按钮", 0)]
[Category("Logic/AI")]
[Description("AI模拟点击按钮, true是按下, false是抬起")]
public class AIpressButton : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<ButtonType> buttonIDInput = AddValueInput<ButtonType>("按钮类型");
		ValueInput<bool> pressInput = AddValueInput<bool>("按下还是抬起");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			AIProcessor.RunMelee(base.mSimContext.GetEntityWithEntityID(entityIDInput.value), pressInput.value, (int)buttonIDInput.value);
			output.Call(f);
		});
	}
}
