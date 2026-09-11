using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到平衡值配置(实体ID)", 0)]
[Category("Logic/Config")]
[Description("根据传入的实体ID得到对应的平衡值")]
public class GetBalanceValueByEntityID : FlowControlNodeOfLogic
{
	private int _balanceValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("无数据", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_balanceValue = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RoleConfig config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID, out config))
			{
				errorOut.Call(f);
			}
			else
			{
				_balanceValue = config.BalanceValue;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("平衡值", "balanceValue", () => _balanceValue);
	}
}
