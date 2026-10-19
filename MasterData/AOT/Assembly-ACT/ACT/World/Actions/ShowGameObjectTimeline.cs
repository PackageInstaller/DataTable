using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Drama;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class ShowGameObjectTimeline : InteractAction
{
	public GameObject timelineGo;

	public string[] abilities;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		CompAbility compAbility = behave.GetCompAbility();
		compAbility.AddAbilities(abilities, AbilitySource.Ability);
		await Singleton<TimelineConversationManager>.instance.PlayTimeline(timelineGo);
		string[] array = abilities;
		foreach (string text in array)
		{
			compAbility.RemoveAbility(text);
		}
	}
}
