using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class SetMotionPathAction : InteractAction
{
	public MotionPath motionPath;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		behave.GetCompPhysics().AddPath(motionPath);
		return UniTask.CompletedTask;
	}
}
