using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class RefreshTempleTargetState : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.CompletedTask;
	}
}
