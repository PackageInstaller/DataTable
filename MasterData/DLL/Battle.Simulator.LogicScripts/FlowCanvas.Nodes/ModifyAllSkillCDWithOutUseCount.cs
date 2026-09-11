using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增加全部技能CD(毫秒)(过时)", 0)]
[Category("Logic/Attribute")]
[Description("增加RoleConfig表格中Ability字段(技能)下的全部条目的CD值;\n减少传入【负数】")]
public class ModifyAllSkillCDWithOutUseCount : FlowControlNode
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
					for (int i = 0; i < config.Ability.Count; i++)
					{
						int abilityID = config.Ability.get_Item(i);
						if (CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
						{
							abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
							CDProcessor.SetCD(entityWithEntityID, abilityID, IntMath.Divide(abilityCD.CD * percentVar.GetValue(), 100) + incrementVar.GetValue(), abilityCD.UsedCount);
						}
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
	}
}
