using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[死亡执行类型]得到配置值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("从 RoleConfig 表中得到角色ID的 DeathTimeType;\nError:配置不存在")]
public class GetDeathTimeTypeOfConfig : FlowControlNode
{
	private ValueInput<int> _roleIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private DeathTimeType _deathTimeType;

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_deathTimeType = DeathTimeType.ImmediatelyDeath;
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(_roleIDInput.value, out var config))
			{
				_errorOut.Call(f);
			}
			else
			{
				_deathTimeType = config.DeathTime;
				_output.Call(f);
			}
		});
		AddValueOutput("实体类型ID", "roleID", () => _roleIDInput.value);
		AddValueOutput("死亡执行类型", "deathTimeType", () => _deathTimeType);
	}
}
