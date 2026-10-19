using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断队伍元素", "Predicate", new string[] { "check", "team", "element", "predicate", "condition" })]
public class CheckTeamElement : ConfigPredicate
{
	public Element checkElement;

	[Range(0f, 3f)]
	public int num;

	public override bool Check(ActionMemory memory)
	{
		int num = 0;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.TryGetCompAbility(out CompAbility component) && component.element == checkElement)
			{
				num++;
			}
		}
		return num >= this.num;
	}
}
