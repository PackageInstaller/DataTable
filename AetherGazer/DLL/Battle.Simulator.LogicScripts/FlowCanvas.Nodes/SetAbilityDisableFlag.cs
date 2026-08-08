using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用或关闭技能(标志位)", 0)]
[Category("Logic/Abilities")]
[Description("需要自行定义每个标志位的意义, 非计数")]
public class SetAbilityDisableFlag : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _abilityIDInput;

	private ValueInput<int> _indexInput;

	private ValueInput<bool> _enableInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_abilityIDInput = AddValueInput<int>("AbilityID", "abilityID");
		_indexInput = AddValueInput<int>("标志位(0-31)", "index");
		_enableInput = AddValueInput<bool>("启用", "disable");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_errorOut.Call(f);
			}
			else if (_indexInput.value < 0 || _indexInput.value > 31)
			{
				_errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.SetAbilityDisableFlag(_abilityIDInput.value, _indexInput.value, !_enableInput.value);
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
		AddValueOutput("AbilityID", "abilityID", () => _abilityIDInput.value);
	}
}
