using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[聚怪]比较被聚值", 0)]
[Category("Logic/聚怪")]
[Description("比较被聚值")]
public class ComparisonBeGatherValue : FlowControlNodeOfLogic
{
	private int _beGatherValue;

	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("相等", "==");
		FlowOutput notEqual = AddFlowOutput("不等", "!=");
		FlowOutput greater = AddFlowOutput("被聚值大", ">");
		FlowOutput less = AddFlowOutput("比较值大", "<");
		FlowOutput noneOut = AddFlowOutput("无被聚值", "none");
		FlowOutput errorOut = AddFlowOutput("error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> comparisonValueInput = AddValueInput<int>("比较值");
		AddFlowInput("In", delegate(Flow f)
		{
			_beGatherValue = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int pValue;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (!GatherHelper.TryGetBeGatherValue(entityWithEntityID, out pValue))
			{
				noneOut.Call(f);
			}
			else
			{
				_beGatherValue = pValue;
				if (pValue == comparisonValueInput.value)
				{
					equal.Call(f);
				}
				else
				{
					notEqual.Call(f);
				}
				if (pValue > comparisonValueInput.value)
				{
					greater.Call(f);
				}
				if (pValue < comparisonValueInput.value)
				{
					less.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("被聚值", "beGatherValue", () => _beGatherValue);
	}
}
