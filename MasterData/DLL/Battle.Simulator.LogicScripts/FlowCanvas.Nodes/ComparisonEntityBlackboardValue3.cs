using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较黑板值(位索引)", 0)]
[Category("Logic/Control")]
[Description("得到黑板值对应位，如果为1走True，为0走False")]
public class ComparisonEntityBlackboardValue3 : FlowControlNode
{
	private long _blackboardValue;

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True", "==");
		FlowOutput falseOut = AddFlowOutput("False", "!=");
		FlowOutput error = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("EntityID");
		ValueInput<int> blackboardValueIDInput = AddValueInput<int>("黑板值ID");
		ValueInput<int> indexInput = AddValueInput<int>("标志位(0-31)", "index");
		AddFlowInput("In", delegate(Flow f)
		{
			_blackboardValue = 0L;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, out var baseValue, out var _, out var _);
				_blackboardValue = baseValue;
				if ((((uint)baseValue >> indexInput.value) & 1) == 1)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("黑板值", "bbvalue", () => _blackboardValue);
	}
}
