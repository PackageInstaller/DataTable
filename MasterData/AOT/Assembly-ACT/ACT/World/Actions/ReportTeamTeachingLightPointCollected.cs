using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class ReportTeamTeachingLightPointCollected : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		TeamTeachingLightPointCollectedEvt evt = Singleton<EventManager>.instance.GetEvt<TeamTeachingLightPointCollectedEvt>();
		evt.stateWorldAssetUid = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TeamTeachingLightPointCollected, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		return UniTask.CompletedTask;
	}
}
