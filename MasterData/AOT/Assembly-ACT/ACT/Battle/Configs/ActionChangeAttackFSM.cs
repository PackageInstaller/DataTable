using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class ActionChangeAttackFSM : ConfigAction
{
	public bool change;

	public string variantName;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (entity.IsValid)
		{
			GameManager.behaveSystem.RequestAttackFSMSwitch(entity, change ? variantName : "default");
		}
	}
}
