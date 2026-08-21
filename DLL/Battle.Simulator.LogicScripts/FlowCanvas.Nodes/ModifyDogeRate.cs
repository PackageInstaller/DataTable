using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增减闪避率", 0)]
[Category("Logic/Attribute")]
[Description("增减闪避率, 增量填负数就是减")]
public class ModifyDogeRate : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> deltaInput = AddValueInput<int>("增量");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				int mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
				AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2008, out var baseValue, out var plusValue, out var tempPlusValue);
				AttributeProcessor.SetAttributeWithIntName(plusValue: plusValue + deltaInput.value, attributeID: mAttributeID, varName: 2008, baseValue: baseValue, factor: tempPlusValue);
				output.Call(f);
			}
		});
	}
}
