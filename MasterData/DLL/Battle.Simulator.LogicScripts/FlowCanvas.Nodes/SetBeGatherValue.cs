using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[聚怪]设置被聚值", 0)]
[Category("Logic/聚怪")]
[Description("设置被聚值")]
public class SetBeGatherValue : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> valueInput = AddValueInput<int>("值", "value");
		AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2219, valueInput.value, 0L, 0L);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
