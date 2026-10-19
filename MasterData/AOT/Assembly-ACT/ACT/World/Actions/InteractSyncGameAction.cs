using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class InteractSyncGameAction : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		MonoECS.instance.SyncGameInfos();
		return UniTask.CompletedTask;
	}
}
