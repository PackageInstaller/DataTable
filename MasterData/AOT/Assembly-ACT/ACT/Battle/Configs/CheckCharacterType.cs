using ACT.Core;
using ACT.Utility;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断角色类型", "Predicate", new string[] { "check", "character", "type", "predicate", "condition" })]
public class CheckCharacterType : ConfigPredicate
{
	public CharacterCountFilterType filterType;

	public FilterCharacterDamageType CharacterDamageType;

	public FilterCharacterFrequencyType CharacterFrequencyType;

	public FilterMannerType MannerType;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.IsCharacter())
		{
			switch (filterType)
			{
			case CharacterCountFilterType.DamageType:
				return CharacterDamageType.HasCharacterDamageType(memory.target.entity.GetCompAbility().characterDamageType);
			case CharacterCountFilterType.FrequencyType:
				return CharacterFrequencyType.HasCharacterFrequencyType(memory.target.entity.GetCompAbility().characterFrequencyType);
			case CharacterCountFilterType.MannerType:
				return MannerType.HasCharacterMannerType(memory.target.entity.GetCompAbility().mannerType);
			}
		}
		return false;
	}
}
