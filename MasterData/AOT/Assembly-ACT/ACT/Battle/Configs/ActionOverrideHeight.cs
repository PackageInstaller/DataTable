using Bamboo.ECS;
using EasyCharacterMovement;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("覆盖高度", "Action", new string[] { "override", "height" })]
public class ActionOverrideHeight : ActionOverrideEcm2Params
{
	public float height;

	public override void Do(ActionMemory memory)
	{
		CompPhysics compPhysics = memory.owner.GetCompPhysics();
		if (compPhysics != null)
		{
			CharacterMovement characterMovement = compPhysics.characterMovement;
			if ((object)characterMovement != null)
			{
				characterMovement.height = height;
			}
		}
	}
}
