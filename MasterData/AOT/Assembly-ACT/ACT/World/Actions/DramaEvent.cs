using ACT.Battle.Configs;
using ACT.Core;
using ACT.Drama;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class DramaEvent : InteractAction
{
	public int dramaId;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		switch (CoreUtils.GetData(dramaId, RuntimeConfigs.data.dramaDatas).type)
		{
		case 1:
		case 3:
			await Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId);
			break;
		case 4:
			AsideManager.instance.BeginAside(dramaId);
			break;
		case 2:
			Singleton<ConversationManager>.instance.ConversationStart(dramaId, behave);
			break;
		}
	}
}
