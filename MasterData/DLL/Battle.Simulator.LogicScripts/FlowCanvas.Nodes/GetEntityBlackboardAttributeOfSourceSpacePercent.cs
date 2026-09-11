using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到黑板属性【修正值占血量百分比】(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到黑板属性【修正值占血量百分比】")]
public class GetEntityBlackboardAttributeOfSourceSpacePercent : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _False;

	private FlowOutput _Error;

	private long _BaseValue;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Out = AddFlowOutput("存在属性", "output");
		_False = AddFlowOutput("不存在属性", "false");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_BaseValue = 0L;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			long plusValue;
			long tempPlusValue;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else if (!AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2170, out _BaseValue, out plusValue, out tempPlusValue))
			{
				_False.Call(f);
			}
			else
			{
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("修正值占血量百分比", "SourceSpacePercent", () => (int)_BaseValue);
	}
}
