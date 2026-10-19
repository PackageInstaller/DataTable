using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace Battle.Configs.Ability.Action;

[AbilityTypeMetadata("修改移动Mode", "Action", new string[] { "change", "movement", "mode", "move", "position", "velocity" })]
public class ActionChangeMovementMode : ConfigAction
{
	public ACTMovementMode changeTo;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompPhysics()?.SetMovementMode(changeTo);
	}
}
