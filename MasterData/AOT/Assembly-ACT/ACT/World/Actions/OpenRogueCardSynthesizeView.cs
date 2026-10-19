using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class OpenRogueCardSynthesizeView : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUECARDSYNTHESIZE);
		return UniTask.CompletedTask;
	}
}
