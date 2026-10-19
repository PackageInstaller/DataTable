using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class ChangeOtherIneractState : InteractAction
{
	public int swid;

	public int stateId;

	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, stateId);
		return UniTask.CompletedTask;
	}
}
