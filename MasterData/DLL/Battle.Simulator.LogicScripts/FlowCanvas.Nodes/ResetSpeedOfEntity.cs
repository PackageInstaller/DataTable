using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置速度(非曲线移动)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("将非曲线移动下的角色速度重置为配置表中的速度")]
public class ResetSpeedOfEntity : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RoleConfig config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID, out config))
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mMaxSpeed = new VFactor(config.Speed, 1000L);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
