using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]修改全部技能CD上限(千分比)", 0)]
[Category("Logic/Attribute")]
[Description("增加RoleConfig表格中AllSkills字段(技能)下的全部条目的CD上限值;\n减少传入【负数】")]
public class AddAllSkillAbilityMaxCDPercent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> percentInput = AddValueInput<int>("千分比变化量");
		ValueInput<bool> isIgnoreUniqueSkill = AddValueInput<bool>("是否忽略奥义", "isIgnoreUniqueSkill");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				f.Call(output);
			}
			else
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
				if (config == null)
				{
					f.Call(output);
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
								int cd = abilityCD.CD * percentInput.value / 1000 + abilityCD.CD;
								CDProcessor.SetCD(entityWithEntityID, num, cd, abilityCD.UsedCount);
							}
							int num2 = 0;
							if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(num, out var value))
							{
								ConfigProcessor.TryGetCDConfig(entityWithEntityID, num, out var cd2, out var _);
								num2 = 0;
								value.baseValue = cd2;
							}
							else
							{
								num2 = value.deltaPercent;
							}
							num2 += percentInput.value;
							value.deltaPercent = num2;
							entityWithEntityID.entityCD.mAbilityMaxCD[num] = value;
						}
					}
					f.Call(output);
				}
			}
		});
	}
}
