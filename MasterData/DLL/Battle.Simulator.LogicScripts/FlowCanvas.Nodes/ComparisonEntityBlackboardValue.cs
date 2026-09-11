using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较黑板值", 0)]
[Category("Logic/Control")]
[Description("Branch the Flow based on a comparison between two comparable objects")]
public class ComparisonEntityBlackboardValue : FlowControlNode
{
	private long _blackboardValue;

	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("相等", "==");
		FlowOutput notEqual = AddFlowOutput("不等", "!=");
		FlowOutput greater = AddFlowOutput("黑板值大", ">");
		FlowOutput less = AddFlowOutput("比较值大", "<");
		FlowOutput error = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("EntityID");
		ValueInput<int> blackboardValueIDInput = AddValueInput<int>("黑板值ID");
		ValueInput<int> comparisonValueInput = AddValueInput<int>("比较值");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, out var baseValue, out var _, out var _);
				_blackboardValue = baseValue;
				if (baseValue == comparisonValueInput.value)
				{
					equal.Call(f);
				}
				else
				{
					notEqual.Call(f);
				}
				if (baseValue > comparisonValueInput.value)
				{
					greater.Call(f);
				}
				if (baseValue < comparisonValueInput.value)
				{
					less.Call(f);
				}
			}
			else
			{
				error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("黑板值", () => _blackboardValue);
	}
}
