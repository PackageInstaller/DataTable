using ACT.Core;
using ACT.Utility;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取战斗队伍角色数量", "Function", new string[] { "get", "battle", "team", "character", "count", "value", "float", "int" })]
public class GetBattleTeamCharacterCount : ConfigFunction<float>
{
	public CharacterCountFilterType filterType;

	public FilterCharacterDamageType FilterCharacterDamageType;

	public FilterCharacterFrequencyType FilterCharacterFrequencyType;

	public FilterMannerType FilterMannerType;

	protected override float Evaluate(ActionMemory memory)
	{
		int num = 0;
		for (int i = 0; i < 3; i++)
		{
			if (!MonoECS.instance.localPlayer.GetTeamCharacter(i).TryGetCompAbility(out CompAbility component))
			{
				continue;
			}
			switch (filterType)
			{
			case CharacterCountFilterType.DamageType:
				if (FilterCharacterDamageType.HasCharacterDamageType(component.characterDamageType))
				{
					num++;
				}
				break;
			case CharacterCountFilterType.FrequencyType:
				if (FilterCharacterFrequencyType.HasCharacterFrequencyType(component.characterFrequencyType))
				{
					num++;
				}
				break;
			case CharacterCountFilterType.MannerType:
				if (FilterMannerType.HasCharacterMannerType(component.mannerType))
				{
					num++;
				}
				break;
			}
		}
		return num;
	}
}
