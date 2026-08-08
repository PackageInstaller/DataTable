using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置零时空间时长", 0)]
[Category("Logic/Attribute")]
[Description("设置零时空间时长")]
public class SetUltimateAvoidTimeScaleTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> valueInput = AddValueInput<int>("值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			AttributeProcessor.SetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityID), 2015, valueInput.value, 0L, 0L);
			output.Call(f);
		});
	}
}
