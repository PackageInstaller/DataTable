using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到平衡值配置(实体类型ID)", 0)]
[Category("Common/Config")]
[Description("根据传入的实体类型ID得到对应的平衡值")]
public class GetBalanceValue : FlowControlNodeOfCommon
{
	private int _balanceValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("无数据", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_balanceValue = 0;
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleIDInput.value, out var config))
			{
				errorOut.Call(f);
			}
			else
			{
				_balanceValue = config.BalanceValue;
				output.Call(f);
			}
		});
		AddValueOutput("平衡值", "balanceValue", () => _balanceValue);
	}
}
