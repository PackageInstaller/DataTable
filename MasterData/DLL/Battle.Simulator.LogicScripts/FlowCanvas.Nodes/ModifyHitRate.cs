using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增减命中率", 0)]
[Category("Logic/Attribute")]
[Description("增减命中率, 增量填负数就是减")]
public class ModifyHitRate : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> deltaInput = AddValueInput<int>("增量");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2007, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(plusValue: plusValue + deltaInput.value, attributeID: attributeIDByEntityID, varName: 2007, baseValue: baseValue, factor: tempPlusValue);
			output.Call(f);
		});
	}
}
