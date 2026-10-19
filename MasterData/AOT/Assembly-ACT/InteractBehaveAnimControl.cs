using ACT.World.Actions;
using ACT.World.Behave;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

public class InteractBehaveAnimControl : StateObjectBase
{
	public BehaveControlAnimMoveBehaveEvent behave;

	public Transform root;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		behave.interactBehaveAnimControl = this;
		behave.Init(stateId);
		base.InitStateObject(stateId);
		if (stateId == 2)
		{
			gameObject.SetActive(value: false);
			root.position = transform.position;
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
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

	protected override void HandleInitState(int stateId)
	{
		switch (stateId)
		{
		case -1:
			gameObject.SetActive(value: false);
			root.position = transform.position;
			root.localRotation = Quaternion.identity;
			break;
		case 0:
		case 1:
			gameObject.SetActive(value: true);
			root.position = transform.position;
			break;
		}
		behave.RefreshRunState(stateId);
	}

	public void ChangeState(int state)
	{
		NetEnterState(state);
	}

	public Vector3 GetBehaveWorldPos()
	{
		return behave.transform.position;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
