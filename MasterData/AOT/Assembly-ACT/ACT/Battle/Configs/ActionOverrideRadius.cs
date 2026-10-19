using Bamboo.ECS;
using EasyCharacterMovement;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("覆盖半径", "Action", new string[] { "override", "radius" })]
public class ActionOverrideRadius : ActionOverrideEcm2Params
{
	public float radius;

	public override void Do(ActionMemory memory)
	{
		CompPhysics compPhysics = memory.owner.GetCompPhysics();
		if (compPhysics != null)
		{
			CharacterMovement characterMovement = compPhysics.characterMovement;
			if ((object)characterMovement != null)
			{
				characterMovement.radius = radius;
			}
		}
	}
}
