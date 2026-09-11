using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新最大血量", 0)]
[Category("Logic/Attribute")]
[Description("更新最大血量")]
public class UpdateMaxHP : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AttributeProcessor.UpdateMaxHp(entityIDInput.value);
			output.Call(f);
		});
	}
}
