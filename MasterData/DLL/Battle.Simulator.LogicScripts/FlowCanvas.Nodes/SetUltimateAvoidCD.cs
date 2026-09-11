using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置闪避效果CD(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("设置闪避效果CD")]
public class SetUltimateAvoidCD : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _valueInput;

	private FlowOutput _out;

	private FlowOutput _error;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "EntityID");
		_valueInput = AddValueInput<int>("新值(毫秒)", "value");
		_out = AddFlowOutput("Out", "output");
		_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUltimateAvoidCD)
			{
				_error.Call(f);
			}
			else
			{
				entityWithEntityID.entityUltimateAvoidCD.mRuntime = _valueInput.GetValue();
				_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => _entityIDInput.GetValue());
	}
}
