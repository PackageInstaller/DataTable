using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class CheckCompAIState : ConfigPredicate
{
	public CompAIState compAIState;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAI(out CompAI component))
		{
			return component.compAIState == compAIState;
		}
		return false;
	}
}
