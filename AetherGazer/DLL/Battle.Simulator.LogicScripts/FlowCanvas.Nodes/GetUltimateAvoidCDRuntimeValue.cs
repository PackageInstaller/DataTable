using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到当前闪避效果CD(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到闪避效果CD")]
public class GetUltimateAvoidCDRuntimeValue : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _out;

	private FlowOutput _none;

	private FlowOutput _error;

	private int _value;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_out = AddFlowOutput("有CD", "output");
		_none = AddFlowOutput("没有CD", "none");
		_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				_error.Call(f);
			}
			else if (!entityWithEntityID.hasEntityUltimateAvoidCD || entityWithEntityID.entityUltimateAvoidCD.mRuntime <= 0)
			{
				_none.Call(f);
			}
			else
			{
				_value = entityWithEntityID.entityUltimateAvoidCD.mRuntime;
				_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => _entityIDInput.GetValue());
		AddValueOutput("当前值", "value", () => _value);
	}
}
