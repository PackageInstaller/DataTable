using ACT.Game;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/StateTrigger")]
public class StateTrigger : StateObjectBase
{
	public VarName triggerEnterEventName = "TriggerEnter";

	public VarName triggerExitEventName = "TriggerExit";

	private bool TriggerExiting;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		StateTriggerData obj = entity.GetCompStateObject().StateWorldAssetData as StateTriggerData;
		BoxCollider component = GetComponent<BoxCollider>();
		obj.boxCollider.CopyTo(component);
		base.InitStateObject(stateId);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			G.service.TriggerCustomInteractEvent(entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, triggerEnterEventName, null);
		}
	}

	protected override void HandleExitInteract()
	{
		if (!TriggerExiting)
		{
			TriggerExiting = true;
			if (currentStateId == 0)
			{
				G.service.TriggerCustomInteractEvent(entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, triggerExitEventName, null);
			}
			TriggerExiting = false;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-3 <= stateId)
		{
			return stateId <= 0;
		}
		return false;
	}
}
