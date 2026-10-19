using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Drama;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class ShowDramaTimeline : InteractAction
{
	public int dramaId;

	public string[] abilities;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		behave.GetCompAbility().AddAbilities(abilities, AbilitySource.Ability);
		await Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId);
		if (behave.TryGetCompAbility(out CompAbility component))
		{
			string[] array = abilities;
			foreach (string text in array)
			{
				component.RemoveAbility(text);
			}
		}
	}
}
