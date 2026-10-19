using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("献祭献祭", "Action", new string[] { "sacrifice", "heal", "recover", "hp" })]
public class ActionSacrifice : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		float num = value.Return(memory);
		memory.target.entity.GetCompAbility().Sacrifice((int)num, memory.ability);
	}
}
