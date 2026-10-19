using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断无1援护Striker", "Predicate", new string[] { "check", "is", "no", "assist", "striker", "predicate", "condition" })]
public class CheckIsNo1AssistStriker : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.IsCharacter())
		{
			return false;
		}
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.GetCompAbility().characterDamageType == CharacterDamageType.AssistStriker)
			{
				return teamCharacter.Id == memory.target.entity.Id;
			}
		}
		return false;
	}
}
