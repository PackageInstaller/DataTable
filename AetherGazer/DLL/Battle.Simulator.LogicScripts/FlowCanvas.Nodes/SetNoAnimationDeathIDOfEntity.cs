using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[无动作死亡行为ID]设置黑板值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("设置实体使用的无动作死亡行为ID;\nError:实体不存在或者无黑板")]
public class SetNoAnimationDeathIDOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _noAnimationDeathIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_noAnimationDeathIDInput = AddValueInput<int>("无动作死亡行为ID", "noAnimationDeathID");
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
				entityWithEntityID.entityBlackboard.var.mNoAnimationDeathSlot = _noAnimationDeathIDInput.value;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("无动作死亡行为ID", "noAnimationDeathID", () => _noAnimationDeathIDInput.value);
	}
}
