using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("判断实体是否有修正值")]
public class HasExposedValue : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _has;

	private FlowOutput _none;

	private FlowOutput _error;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_has = AddFlowOutput("有修正值", "has");
		_none = AddFlowOutput("没有修正值", "none");
		_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _entityIDInput.GetValue(), out var simEntity))
			{
				_error.Call(f);
			}
			else if (simEntity.hasEntityExposedValue)
			{
				_has.Call(f);
			}
			else
			{
				_none.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
	}
}
