using Bamboo.ECS;
using EasyCharacterMovement;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("覆盖栖点偏移", "Action", new string[] { "override", "perch", "offset" })]
public class ActionOverridePerchOffset : ActionOverrideEcm2Params
{
	public float perchOffset;

	public override void Do(ActionMemory memory)
	{
		CompPhysics compPhysics = memory.owner.GetCompPhysics();
		if (compPhysics != null)
		{
			CharacterMovement characterMovement = compPhysics.characterMovement;
			if ((object)characterMovement != null)
			{
				characterMovement.perchOffset = perchOffset;
			}
		}
	}
}
