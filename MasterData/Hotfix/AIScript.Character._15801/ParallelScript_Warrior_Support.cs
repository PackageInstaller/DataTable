using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ParallelScript_Warrior_Support : ParallelScript_Summoned_Support
{
	protected override void OnBattleReady()
	{
		base.OnBattleReady();
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(playerAdventureActor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = playerAdventureActor.GetRadius(),
			radius = Config_Support.teleportRadius_Warrior,
			position = playerAdventureActor.tsTransform.Position
		});
		_actor.Teleport(randomPointInShape);
	}
}
