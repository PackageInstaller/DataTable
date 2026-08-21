using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取属性", 0)]
[Category("Logic/Attribute")]
[Description("获取实体黑板属性,如果不存在的话,就加一个0(int)")]
public class GetAttributeByID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> IDInput = AddValueInput<int>("属性ID");
		AddValueOutput("值", () => AttributeProcessor.GetFinalAttributeByAttributeID(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), IDInput.value, AttributeCalcType.Add));
	}
}
