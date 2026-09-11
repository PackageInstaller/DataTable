using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较当前血量(逻辑)", 0)]
[Category("Logic/Control")]
[Description("从黑板获取当前血量进行比较，输出流是有重复的")]
public class CompareHPValue : FlowControlNode
{
	private long _curHp;

	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("相等", "==");
		FlowOutput notEqual = AddFlowOutput("不等", "!=");
		FlowOutput greater = AddFlowOutput("黑板值大", ">");
		FlowOutput less = AddFlowOutput("比较值大", "<");
		FlowOutput error = AddFlowOutput("error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> comparisonValueInput = AddValueInput<int>("比较值", "compVal");
		AddFlowInput("In", delegate(Flow f)
		{
			_curHp = -1L;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2002, out var baseValue, out var _, out var _);
				_curHp = baseValue;
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
		AddValueOutput("当前血量", "curHp", () => _curHp);
	}
}
