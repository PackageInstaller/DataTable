using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class RemoveHintIcon : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		_ = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		return UniTask.CompletedTask;
	}
}
