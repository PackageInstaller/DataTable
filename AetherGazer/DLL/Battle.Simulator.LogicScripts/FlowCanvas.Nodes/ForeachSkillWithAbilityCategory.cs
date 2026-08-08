using Config;
using Google.Protobuf.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("根据槽位遍历实体技能", 0)]
[Category("Logic/Abilities")]
[Description("通过实体ID查询对应实体类型ID来输出对应的槽位的技能ID")]
public class ForeachSkillWithAbilityCategory : FlowNode
{
	private int entityID;

	private int skillID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<SkillCategory> skillTypeInput = AddValueInput<SkillCategory>("槽位").SetDefaultAndSerializedValue(SkillCategory.Skill1);
		ValueInput<bool> includeTransfigurationInput = AddValueInput<bool>("考虑变身").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("技能ID", () => skillID);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				int num = entityWithEntityID.entityConfig.mId;
				if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(num, out var config))
				{
					Debug.LogError($"实体对应实体类型ID {num} 不存在");
					errorOut.Call(f);
				}
				else
				{
					RepeatedField<int> allSkills = config.AllSkills;
					public_skill config2;
					for (int i = 0; i < allSkills.Count; i++)
					{
						if (!ConfigHelper.GetInstance().TryGetConfig<public_skill>(allSkills.get_Item(i), out config2))
						{
							Debug.LogError($"AllSkill与public_skill中技能不匹配 : {allSkills.get_Item(i)}");
							errorOut.Call(f);
							return;
						}
						if (config2.AbilityCategory == (int)skillTypeInput.value)
						{
							skillID = config2.ID;
							output.Call(f);
						}
					}
					if (includeTransfigurationInput.value)
					{
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2220, out var baseValue, out var plusValue, out var tempPlusValue);
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2221, out var baseValue2, out tempPlusValue, out plusValue);
						bool flag = false;
						if (num != baseValue && baseValue != 0L)
						{
							num = (int)baseValue;
							flag = true;
						}
						else if (num != baseValue2 && baseValue2 != 0L)
						{
							num = (int)baseValue2;
							flag = true;
						}
						if (flag)
						{
							if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(num, out config))
							{
								Debug.LogError($"实体对应实体类型ID {num} 不存在");
								errorOut.Call(f);
								return;
							}
							allSkills = config.AllSkills;
							for (int j = 0; j < allSkills.Count; j++)
							{
								if (!ConfigHelper.GetInstance().TryGetConfig<public_skill>(allSkills.get_Item(j), out config2))
								{
									Debug.LogError($"AllSkill与public_skill中技能不匹配 : {allSkills.get_Item(j)}");
									errorOut.Call(f);
									return;
								}
								if (config2.AbilityCategory == (int)skillTypeInput.value)
								{
									skillID = config2.ID;
									output.Call(f);
								}
							}
						}
					}
					doneOut.Call(f);
				}
			}
		});
	}
}
