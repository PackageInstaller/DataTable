using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[落地死亡行为ID]得到配置值(逻辑)", 0)]
[Category("Logic/Config")]
[Description("从 RoleConfig 表中得到角色ID的 FallDownDeath;\nError:配置不存在")]
public class GetFallDownDeathIDOfConfig : FlowControlNode
{
	private ValueInput<int> _roleIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _fallDownDeathID;

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_fallDownDeathID = 0;
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(_roleIDInput.value, out var config))
			{
				_errorOut.Call(f);
			}
			else
			{
				_fallDownDeathID = config.FallDownDeath;
				_output.Call(f);
			}
		});
		AddValueOutput("实体类型ID", "roleID", () => _roleIDInput.value);
		AddValueOutput("落地死亡行为ID", "fallDownDeathID", () => _fallDownDeathID);
	}
}
