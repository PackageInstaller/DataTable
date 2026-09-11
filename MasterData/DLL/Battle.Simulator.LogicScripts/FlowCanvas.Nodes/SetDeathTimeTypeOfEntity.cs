using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[死亡执行类型]设置黑板值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("设置实体使用的死亡执行类型;\nError:实体不存在或者无黑板")]
public class SetDeathTimeTypeOfEntity : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<DeathTimeType> _deathTimeTypeInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_deathTimeTypeInput = AddValueInput<DeathTimeType>("死亡执行类型", "deathTimeType");
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
				entityWithEntityID.entityBlackboard.var.mDeathTimeType = _deathTimeTypeInput.value;
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("死亡执行类型", "deathTimeType", () => _deathTimeTypeInput.value);
	}
}
