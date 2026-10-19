using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

public class InteractLadder : StateObjectBase
{
	public Ladder ladderScript;

	private LadderData m_Data;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is LadderData data)
		{
			m_Data = data;
			base.InitStateObject(stateId);
		}
	}

	public override void BindParentRigidBody(Rigidbody parentRig)
	{
		if (parentRig != null)
		{
			ladderScript.isMove = true;
			ladderScript.rig = parentRig;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
