using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取黑板属性(pure)(黑板ID)", 0)]
[Category("Logic/Attribute")]
[Description("获取实体黑板属性,如果不存在的话,就加一个0(int)")]
public class GetEntityBlackboardAttributePureByAttributeID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueInput<int>("黑板ID");
		ValueInput<int> varNameInput = AddValueInput<int>("变量名");
		AddValueOutput("值", delegate
		{
			AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), varNameInput.value, out var baseValue, out var _, out var _);
			return baseValue;
		});
	}
}
