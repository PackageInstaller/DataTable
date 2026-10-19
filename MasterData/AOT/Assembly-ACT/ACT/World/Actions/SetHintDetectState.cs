using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class SetHintDetectState : InteractAction
{
	public HintDetect hintDetect;

	public bool hintDetectActive;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		hintDetect.SetColliderEnable(hintDetectActive);
		return UniTask.CompletedTask;
	}
}
