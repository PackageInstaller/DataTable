using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("结束援护保留", "Action", new string[] { "end", "assist", "remain" })]
public class ActionEndAssistRemain : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.owner.IsCharacter())
		{
			Singleton<GameManager>.instance.ecsManager.systemAssist.EndRemain(memory.owner);
		}
	}
}
