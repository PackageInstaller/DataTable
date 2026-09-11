using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[空中死亡行为ID]设置黑板值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("设置实体使用的空中死亡行为ID;\nError:实体不存在或者无黑板")]
public class SetAirDeathIDOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _airDeathIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_airDeathIDInput = AddValueInput<int>("空中死亡行为ID", "airDeathID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mAirDeathSlot = _airDeathIDInput.value;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("空中死亡行为ID", "airDeathID", () => _airDeathIDInput.value);
	}
}
