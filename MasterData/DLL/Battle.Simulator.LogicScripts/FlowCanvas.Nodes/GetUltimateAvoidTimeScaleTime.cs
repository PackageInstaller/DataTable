using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取零时空间时长", 0)]
[Category("Logic/Attribute")]
[Description("获取零时空间时长，最终时长为考虑属性加成的")]
public class GetUltimateAvoidTimeScaleTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("零时空间基础时长", delegate
		{
			AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2015, out var baseValue, out var _, out var _);
			return (int)baseValue;
		});
		AddValueOutput("零时空间最终时长", delegate
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
			long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDByEntityID, 1006, AttributeCalcType.Add);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2015, out var baseValue, out var _, out var _);
			return (int)baseValue + (int)finalAttributeByAttributeID;
		});
	}
}
