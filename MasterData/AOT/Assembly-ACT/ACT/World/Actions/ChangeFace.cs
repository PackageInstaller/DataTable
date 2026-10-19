using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class ChangeFace : InteractAction
{
	public bool faceInteractObject;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		bool flag = behave.GetCompTransform().colliderPosition.x > stateObjectBase.transform.position.x;
		behave.SetFaceLeft(faceInteractObject ? flag : (!flag));
		return UniTask.CompletedTask;
	}
}
