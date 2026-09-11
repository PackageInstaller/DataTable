using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]遍历技能(逻辑)", 0)]
[Category("Logic/统合")]
[Description("遍历选定类型的技能，结果不会重复\n\nAllSkills：RoleConfig中的AllSkill列\nAvoid：实时闪避槽Melee：实时普攻槽")]
public class SearchAbilityTogether : FlowNode
{
	private HashSet<int> set = new HashSet<int>();

	protected override void RegisterPorts()
	{
		FlowOutput doOutput = AddFlowOutput("Do", "do");
		FlowOutput doneOutput = AddFlowOutput("Done", "done");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<E_SkillIterateMode> valueModeX = AddValueInput<E_SkillIterateMode>("模式X", "valueModeX");
		int entityID = 0;
		AddValueOutput("实体ID", "entityID", () => entityID);
		int abilityID = 0;
		AddValueOutput("技能ID", "abilityID", () => abilityID);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				set.Clear();
				if ((valueModeX.value & E_SkillIterateMode.AllSkills) != 0)
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
					{
						error.Call(f);
						return;
					}
					for (int i = 0; i < config.AllSkills.Count; i++)
					{
						set.Add(config.AllSkills.get_Item(i));
					}
				}
				if ((valueModeX.value & E_SkillIterateMode.Avoid) != 0)
				{
					set.Add(entityWithEntityID.entityBlackboard.var.mAvoidForwardSlots);
					set.Add(entityWithEntityID.entityBlackboard.var.mAvoidBackSlots);
				}
				if ((valueModeX.value & E_SkillIterateMode.Melee) != 0)
				{
					for (int j = 0; j < entityWithEntityID.entityBlackboard.var.mMeleesSlots.Count; j++)
					{
						set.Add(entityWithEntityID.entityBlackboard.var.mMeleesSlots[j]);
					}
				}
				foreach (int item in set)
				{
					abilityID = item;
					doOutput.Call(f);
				}
				doneOutput.Call(f);
			}
		});
	}
}
