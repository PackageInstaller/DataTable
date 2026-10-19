using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class GetLocalMission : InteractAction
{
	public int missionId;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.CompletedTask;
	}
}
