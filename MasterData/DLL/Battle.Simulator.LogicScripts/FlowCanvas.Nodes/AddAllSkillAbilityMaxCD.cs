using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增加全部技能CD上限(毫秒)", 0)]
[Category("Logic/Attribute")]
[Description("增加RoleConfig表格中AllSkills字段(技能)下的全部条目的CD上限值;\n减少传入【负数】")]
public class AddAllSkillAbilityMaxCD : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> changedValueVar = AddValueInput<int>("改变量", "changedValueVar");
		ValueInput<bool> isIgnoreUniqueSkill = AddValueInput<bool>("是否忽略奥义", "isIgnoreUniqueSkill");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormalOutput = AddFlowOutput("异常", "abnormalOutput");
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
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
					for (int i = 0; i < config.AllSkills.Count; i++)
					{
						int num = config.AllSkills.get_Item(i);
						if (!isIgnoreUniqueSkill.value || !CommonProcessor.IsInUniqueSkillABility(entityWithEntityID, num))
						{
							if (CDProcessor.GetCD(entityWithEntityID, num, out var abilityCD))
							{
								num = CDProcessor.CheckAbilityIsAvoid(num);
								CDProcessor.SetCD(entityWithEntityID, num, abilityCD.CD + changedValueVar.GetValue(), abilityCD.UsedCount);
							}
							int num2 = 0;
							if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(num, out var value))
							{
								ConfigProcessor.TryGetCDConfig(entityWithEntityID, num, out var cd, out var _);
								num2 = 0;
								value.baseValue = cd;
							}
							else
							{
								num2 = value.deltaValue;
							}
							num2 += changedValueVar.GetValue();
							value.deltaValue = num2;
							entityWithEntityID.entityCD.mAbilityMaxCD[num] = value;
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
