using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增加全部技能CD(排除奥义)(毫秒)", 0)]
[Category("Logic/Attribute")]
[Description("增加RoleConfig表格中AllSkills字段(全部技能)（排除奥义）下的全部条目的CD值;\n减少传入【负数】")]
public class ModifyAllSkillCDWithoutUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "EntityID");
		ValueInput<int> percentVar = AddValueInput<int>("百分比", "percentVar").SetDefaultAndSerializedValue(100);
		ValueInput<int> incrementVar = AddValueInput<int>("增减量(毫秒)", "incrementVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormalOutput = AddFlowOutput("异常", "abnormalOutput");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				abnormalOutput.Call(f);
			}
			else
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				if (config == null)
				{
					abnormalOutput.Call(f);
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
							CDProcessor.SetCD(entityWithEntityID, num, IntMath.Divide(abilityCD.CD * percentVar.GetValue(), 100) + incrementVar.GetValue(), abilityCD.UsedCount);
						}
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
	}
}
