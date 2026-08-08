using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("尝试更新碰撞(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("尝试更新实体当前的碰撞盒状态")]
public class UpdateCollisionByID : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityShape)
			{
				_errorOut.Call(f);
			}
			else
			{
				DisableCollisionByID.Invoke(base.mSimContext, entityWithEntityID);
				_output.Call(f);
			}
		});
	}
}
