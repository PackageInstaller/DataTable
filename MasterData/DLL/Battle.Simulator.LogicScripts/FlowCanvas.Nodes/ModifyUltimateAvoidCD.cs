using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改闪避效果CD(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("修改闪避效果的CD,加算一个值")]
public class ModifyUltimateAvoidCD : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _addValueInput;

	private FlowOutput _out;

	private FlowOutput _error;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_addValueInput = AddValueInput<int>("增量(毫秒)", "addValue");
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
				entityWithEntityID.entityUltimateAvoidCD.mRuntime += _addValueInput.GetValue();
				if (entityWithEntityID.entityUltimateAvoidCD.mRuntime <= 0)
				{
					entityWithEntityID.entityUltimateAvoidCD.mRuntime = 0;
				}
				_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => _entityIDInput.GetValue());
	}
}
