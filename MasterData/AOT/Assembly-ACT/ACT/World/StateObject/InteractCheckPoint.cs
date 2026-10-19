using ACT.Battle;
using ACT.EventTrack;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractCheckPoint")]
public class InteractCheckPoint : StateObjectBase
{
	public override bool serviceSave => true;

	protected override bool AllowTriggerEnter(MonoECS.ControlType controlType)
	{
		return true;
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		MonoECS.instance.checkPointManager.SetCheckPoint(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		MovementEvent evt = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt.eventType = 1;
		evt.swid = compStateObject.StateWorldAssetData.stateWorldAssetUid;
		evt.pos = entity.GetCompTransform().physicsPosition;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		base.InitStateObject(stateId);
		CheckPointData checkPointData = entity.GetCompStateObject().StateWorldAssetData as CheckPointData;
		BoxCollider component = GetComponent<BoxCollider>();
		component.center = checkPointData.bounds.center;
		component.size = checkPointData.bounds.size;
	}
}
