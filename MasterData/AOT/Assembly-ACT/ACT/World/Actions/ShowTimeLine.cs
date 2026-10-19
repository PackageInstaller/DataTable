using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Drama;
using ACT.Model;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using UnityEngine.Playables;

namespace ACT.World.Actions;

public class ShowTimeLine : InteractAction
{
	public YooAssetReference timelineGOAssetAssetID;

	public bool useLocalPos = true;

	public string[] abilities;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		MonoECS.instance.mainEntity.GetCompAbility().AddAbilities(abilities, AbilitySource.Ability);
		try
		{
			PlayableDirector timelineImmediately = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(timelineGOAssetAssetID);
			timelineImmediately.transform.SetParent(useLocalPos ? stateObjectBase.entity.GetRootTransform() : null);
			await Singleton<TimelineConversationManager>.instance.PlayTimeline(timelineImmediately.gameObject);
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(timelineGOAssetAssetID);
		}
		finally
		{
			CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
			string[] array = abilities;
			foreach (string text in array)
			{
				compAbility.RemoveAbility(text);
			}
		}
	}
}
