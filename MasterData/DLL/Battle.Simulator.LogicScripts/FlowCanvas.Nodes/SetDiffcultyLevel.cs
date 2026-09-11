using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置难度", 0)]
[Category("Logic/Config")]
[Description("将关卡难度设置为指定id的配置，见difficulty表")]
public class SetDiffcultyLevel : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> valueInput = AddValueInput<int>("难度");
		AddFlowOutput("");
		AddFlowInput("", delegate
		{
			CommonProcessor.GetWorldState().difficulty = valueInput.value;
		});
	}
}
