using ACT.Battle;
using ACT.EventTrack;
using ACT.World.Actions;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.StateObject.EntryProcessors;

public class ExposeEntryProcessor : BaseEntryProcessor<IExposeEntrySetting>
{
	protected override void OnAddTimer(IExposeEntrySetting entry, float deltaTime)
	{
		entry.Timer += deltaTime;
		if (entry.Timer >= entry.ExposeTime)
		{
			entry.OnExposeActionList.TryInteract(MonoECS.instance.localPlayer.battleEntity, InteractAction.InteractSource.Player).Forget();
			entry.Timer = 0f;
			CompStateObject compStateObject = entry.EntityReference.GetCompStateObject();
			TrackOnInteractEntryEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEntryEvt>();
			evt.interactId = compStateObject.StateObjectBase.swid;
			evt.objectName = compStateObject.StateObjectBase.name;
			evt.stateCurrent = compStateObject.StateObjectBase.currentStateId;
			evt.interactType = entry.Data.stateObjectType;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	protected override void OnExitExpose(IExposeEntrySetting entryObj)
	{
		entryObj.Timer = 0f;
	}
}
