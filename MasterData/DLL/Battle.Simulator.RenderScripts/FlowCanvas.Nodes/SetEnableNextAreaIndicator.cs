using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置指示器状态", 0)]
[Category("Render/Trigger")]
[Description("设置下个区域的指示器是否显示")]
public class SetEnableNextAreaIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> valueInput = AddValueInput<bool>("状态");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			((BattleScene)NScene.GetCurrentScene()).SetEnableNextAreaIndicator(valueInput.value);
			output.Call(f);
		});
	}
}
