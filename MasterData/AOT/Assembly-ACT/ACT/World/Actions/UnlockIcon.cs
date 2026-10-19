using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

[Tooltip("点亮对应的图标")]
public class UnlockIcon : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.ServerOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		_ = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		return UniTask.CompletedTask;
	}
}
