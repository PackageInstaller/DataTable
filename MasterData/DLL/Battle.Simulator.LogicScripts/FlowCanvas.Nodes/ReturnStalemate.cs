using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("回到对峙状态", 0)]
[Category("Logic/AI")]
[Description("回到对峙状态")]
public class ReturnStalemate : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AttributeProcessor.SetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2209, 1L, 0L, 0L);
			output.Call(f);
		});
	}
}
