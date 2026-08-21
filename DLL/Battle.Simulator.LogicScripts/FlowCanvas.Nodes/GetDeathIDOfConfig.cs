using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[通用死亡行为ID]得到配置值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("从 RoleConfig 表中得到角色ID的 Death;\nError:配置不存在")]
public class GetDeathIDOfConfig : FlowControlNode
{
	private ValueInput<int> _roleIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _deathID;

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_deathID = 0;
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(_roleIDInput.value, out var config))
			{
				_errorOut.Call(f);
			}
			else
			{
				_deathID = config.Death;
				_output.Call(f);
			}
		});
		AddValueOutput("实体类型ID", "roleID", () => _roleIDInput.value);
		AddValueOutput("通用死亡行为ID", "deathID", () => _deathID);
	}
}
