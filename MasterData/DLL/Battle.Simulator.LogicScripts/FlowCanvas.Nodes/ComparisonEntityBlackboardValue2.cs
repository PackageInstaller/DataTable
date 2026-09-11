using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较黑板值(位为1的数量)", 0)]
[Category("Logic/Control")]
[Description("统计黑板值中为1的位数量，再与比较值比较")]
public class ComparisonEntityBlackboardValue2 : FlowControlNode
{
	private long _blackboardValue;

	private int _count;

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
			_blackboardValue = 0L;
			_count = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, out var baseValue, out var _, out var _);
				_blackboardValue = baseValue;
				uint num = (uint)baseValue;
				num = (num & 0x55555555) + ((num >> 1) & 0x55555555);
				num = (num & 0x33333333) + ((num >> 2) & 0x33333333);
				num = (num & 0xF0F0F0F) + ((num >> 4) & 0xF0F0F0F);
				uint num2 = num * 16843009 >> 24;
				if (num2 == (uint)comparisonValueInput.value)
				{
					equal.Call(f);
				}
				else
				{
					notEqual.Call(f);
				}
				if ((int)num2 > comparisonValueInput.value)
				{
					greater.Call(f);
				}
				if ((int)num2 < comparisonValueInput.value)
				{
					less.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("黑板值", "bbvalue", () => _blackboardValue);
		AddValueOutput("1的数量", "count", () => _count);
	}
}
