using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断角色伤害类型", "Predicate", new string[] { "check", "character", "damage", "type", "predicate", "condition" })]
public class CheckCharacterDamageType : ConfigPredicate
{
	public CharacterDamageType characterDamageType;

	public override bool Check(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (compAbility != null && compAbility.HasAbilityTag(BuffTag.DamageTypeMask))
		{
			switch (characterDamageType)
			{
			case CharacterDamageType.Striker:
				return compAbility.HasAbilityTag(BuffTag.Striker);
			case CharacterDamageType.Breaker:
				return compAbility.HasAbilityTag(BuffTag.Breaker);
			case CharacterDamageType.AssistStriker:
				return compAbility.HasAbilityTag(BuffTag.AssistStriker);
			}
		}
		if (memory.target.entity.TryGetCompCharacter(out CompCharacter component))
		{
			return RuntimeConfigs.data.entityCharacterDatas[component.characterSource.Id()].characterDamageType == (int)characterDamageType;
		}
		return false;
	}
}
