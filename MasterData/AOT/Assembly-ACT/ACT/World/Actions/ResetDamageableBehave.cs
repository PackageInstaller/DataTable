using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class ResetDamageableBehave : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<DamageableManager>.instance.ResetAll();
		return UniTask.CompletedTask;
	}
}
