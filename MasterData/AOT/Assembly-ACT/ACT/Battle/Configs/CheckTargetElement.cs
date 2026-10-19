using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标元素", "Predicate", new string[] { "check", "target", "element", "retarget", "aim", "predicate", "condition" })]
public class CheckTargetElement : ConfigPredicate
{
	public Element element;

	public override bool Check(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (compAbility != null)
		{
			return compAbility.element == element;
		}
		return false;
	}
}
