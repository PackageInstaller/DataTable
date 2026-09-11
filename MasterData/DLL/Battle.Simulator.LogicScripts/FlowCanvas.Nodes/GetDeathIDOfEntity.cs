using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[通用死亡行为ID]得到黑板值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到实体使用的通用死亡行为ID;\nError:实体不存在或者无黑板")]
public class GetDeathIDOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _deathID;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_deathID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else
			{
				_deathID = entityWithEntityID.entityBlackboard.var.mDeathSlot;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("通用死亡行为ID", "deathID", () => _deathID);
	}
}
