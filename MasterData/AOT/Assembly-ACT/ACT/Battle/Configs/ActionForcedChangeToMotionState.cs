using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class ActionForcedChangeToMotionState : ConfigAction
{
	public string motionName;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (entity.IsValid)
		{
			GameManager.behaveSystem.ForcedChangeToMotionState(entity, motionName);
		}
	}
}
