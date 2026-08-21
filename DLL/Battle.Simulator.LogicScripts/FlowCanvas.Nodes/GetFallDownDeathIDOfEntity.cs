using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[落地死亡行为ID]得到黑板值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到实体使用的落地死亡行为ID;\nError:实体不存在或者无黑板")]
public class GetFallDownDeathIDOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _fallDownDeathID;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_fallDownDeathID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else
			{
				_fallDownDeathID = entityWithEntityID.entityBlackboard.var.mFallDownDeathSlot;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("落地死亡行为ID", "fallDownDeathID", () => _fallDownDeathID);
	}
}
