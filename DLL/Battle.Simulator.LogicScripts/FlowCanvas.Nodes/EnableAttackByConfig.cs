using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用普攻(表)", 0)]
[Category("Logic/Buff/效果/普攻")]
[Description("计数型，启用RoleConfig中Melees列里的所有技能")]
public class EnableAttackByConfig : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null)
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				if (config != null)
				{
					foreach (int melee in config.Melees)
					{
						entityWithEntityID.entityBlackboard.var.EnableAbility(melee, isEnable: true);
					}
				}
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
