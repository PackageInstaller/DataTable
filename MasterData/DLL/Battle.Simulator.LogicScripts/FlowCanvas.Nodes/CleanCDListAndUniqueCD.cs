using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]移除全部技能和奥义CD", 0)]
[Category("Logic/Attribute")]
[Description("该节点会读取RoleConfig表中的AllSkill列，移除其中对应的技能CD")]
public class CleanCDListAndUniqueCD : FlowControlNode
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
					for (int i = 0; i < config.AllSkills.Count; i++)
					{
						int abilityID = config.AllSkills.get_Item(i);
						if (CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
						{
							abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
							CDProcessor.SetCD(entityWithEntityID, abilityID, 0, abilityCD.UsedCount);
						}
					}
					trueOutput.Call(f);
				}
			}
		});
	}
}
