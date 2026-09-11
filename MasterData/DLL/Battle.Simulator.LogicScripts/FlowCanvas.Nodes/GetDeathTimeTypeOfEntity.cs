using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[死亡执行类型]得到黑板值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("得到实体使用的死亡执行类型;\nError:实体不存在或者无黑板")]
public class GetDeathTimeTypeOfEntity : FlowControlNode
{
	private DeathTimeType _deathTimeType;

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
			_deathTimeType = DeathTimeType.ImmediatelyDeath;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else
			{
				_deathTimeType = entityWithEntityID.entityBlackboard.var.mDeathTimeType;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("死亡执行类型", "deathTimeType", () => _deathTimeType);
	}
}
