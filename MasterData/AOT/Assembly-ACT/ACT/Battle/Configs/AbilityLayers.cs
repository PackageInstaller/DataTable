using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能层数", "Function", new string[] { "ability", "layers" })]
public class AbilityLayers : ConfigFunction<float>
{
	public bool useExtra;

	public string name;

	protected override float Evaluate(ActionMemory memory)
	{
		int num = ((!useExtra) ? memory.ability.stack : 0);
		if (useExtra && memory.target.entity.TryGetCompAbility(out CompAbility component) && component.HasAbility(name))
		{
			num = 0;
			foreach (Ability ability in component.abilities)
			{
				if (ability.config.name == name)
				{
					num = ability.stack;
				}
			}
		}
		return num;
	}
}
