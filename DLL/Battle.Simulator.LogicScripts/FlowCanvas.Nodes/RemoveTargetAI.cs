using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI关闭", 0)]
[Category("Logic/AI")]
[Description("设置AI关闭, true的话关闭AI, false的话启用AI，计数的")]
public class RemoveTargetAI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<bool> valueInput = AddValueInput<bool>("是否关闭");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2196, out var baseValue, out var _, out var _);
			baseValue = ((!valueInput.value) ? (baseValue - 1) : (baseValue + 1));
			if (baseValue < 0)
			{
				baseValue = 0L;
			}
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2196, baseValue, 0L, 0L);
			f.Call(output);
		});
	}
}
