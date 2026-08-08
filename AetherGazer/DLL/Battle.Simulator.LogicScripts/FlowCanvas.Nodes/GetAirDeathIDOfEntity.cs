using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[空中死亡行为ID]得到黑板值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到实体使用的空中死亡行为ID;\nError:实体不存在或者无黑板")]
public class GetAirDeathIDOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _airDeathID;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_airDeathID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else
			{
				_airDeathID = entityWithEntityID.entityBlackboard.var.mAirDeathSlot;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("空中死亡行为ID", "airDeathID", () => _airDeathID);
	}
}
