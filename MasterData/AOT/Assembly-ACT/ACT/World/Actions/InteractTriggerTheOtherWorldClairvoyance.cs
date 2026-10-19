using ACT.Battle.Configs;
using ACT.Model;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class InteractTriggerTheOtherWorldClairvoyance : InteractAction
{
	protected override AbilityAuth auth { get; }

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Model<TheOtherWorldModel>.Interface.ActiveFollowClairvoyance = true;
		return UniTask.CompletedTask;
	}
}
