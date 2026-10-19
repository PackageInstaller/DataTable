using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class CompleteTransition : InteractAction
{
	public bool clear = true;

	public int targetStateId;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (clear)
		{
			stateObjectBase.CompleteTransitionClear();
		}
		else
		{
			stateObjectBase.CompleteTransition(targetStateId);
		}
		return UniTask.CompletedTask;
	}
}
