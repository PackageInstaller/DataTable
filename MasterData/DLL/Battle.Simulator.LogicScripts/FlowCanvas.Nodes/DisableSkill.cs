using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用技能", 0)]
[Category("Logic/Buff/效果/技能")]
[Description("禁止全部技能释放")]
public class DisableSkill : FlowControlNode
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
				for (int i = 0; i < config.AllSkills.Count; i++)
				{
					entityWithEntityID.entityBlackboard.var.EnableAbility(config.AllSkills.get_Item(i), isEnable: false);
				}
				for (int j = 0; j < config.AvoidAbility.Count; j++)
				{
					entityWithEntityID.entityBlackboard.var.EnableAbility(config.AvoidAbility.get_Item(j), isEnable: false);
				}
				for (int k = 0; k < config.RageAbility.Count; k++)
				{
					entityWithEntityID.entityBlackboard.var.EnableAbility(config.RageAbility.get_Item(k), isEnable: false);
				}
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
