using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除IllogicalEffects", "Action", new string[] { "remove", "illogical", "effects" })]
public class ActionRemoveIllogicalEffects : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		memory.owner.GetCompEffect()?.RemoveIllogicalEffects();
	}
}
