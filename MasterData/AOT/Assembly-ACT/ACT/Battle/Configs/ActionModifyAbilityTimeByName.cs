using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改技能时间按名称", "Action", new string[] { "modify", "ability", "time", "by", "name", "skill", "cd" })]
public class ActionModifyAbilityTimeByName : ConfigAction
{
	public string ability;

	public bool useTag;

	public BuffTag tag;

	public DynamicFloat add;

	public DynamicFloat mul;

	public override void Do(ActionMemory memory)
	{
		Ability ability = memory.ability;
		if (useTag)
		{
			CompAbility compAbility = memory.target.entity.GetCompAbility();
			if (compAbility != null && compAbility.HasAbilityTag(tag))
			{
				List<Ability> abilitiesByTag = compAbility.GetAbilitiesByTag(tag);
				if (abilitiesByTag == null)
				{
					return;
				}
				{
					foreach (Ability item in abilitiesByTag)
					{
						for (int i = 0; i < item.Duration.StackCount; i++)
						{
							item.Duration.SetVal(i, item.Duration.GetVal(i) * (1f + mul.GetFloat(ability)) + add.GetFloat(ability));
						}
					}
					return;
				}
			}
		}
		CompAbility compAbility2 = memory.target.entity.GetCompAbility();
		if (compAbility2 != null && compAbility2.TryGetAbility(this.ability, includeAdd: true, out var ab))
		{
			for (int j = 0; j < ab.Duration.StackCount; j++)
			{
				ab.Duration.SetVal(j, ab.Duration.GetVal(j) * (1f + mul.GetFloat(ability)) + add.GetFloat(ability));
			}
		}
	}
}
