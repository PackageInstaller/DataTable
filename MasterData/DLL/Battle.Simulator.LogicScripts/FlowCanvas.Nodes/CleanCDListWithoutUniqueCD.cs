using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]移除全部技能CD(排除奥义)", 0)]
[Category("Logic/Attribute")]
[Description("排除掉UniqueSkill表中的ability_id列，将剩下的清除掉CD")]
public class CleanCDListWithoutUniqueCD : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOutput = AddFlowOutput("True", "true");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.GetValue());
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				if (config == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					UniqueSkill config2 = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID);
					for (int i = 0; i < config.AllSkills.Count; i++)
					{
						int num = config.AllSkills.get_Item(i);
						if (!config2.AbilityId.Contains(num) && CDProcessor.GetCD(entityWithEntityID, num, out var abilityCD))
						{
							num = CDProcessor.CheckAbilityIsAvoid(num);
							CDProcessor.SetCD(entityWithEntityID, num, 0, abilityCD.UsedCount);
						}
					}
					trueOutput.Call(f);
				}
			}
		});
	}
}
