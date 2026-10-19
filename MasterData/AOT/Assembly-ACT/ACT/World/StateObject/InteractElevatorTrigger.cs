using ACT.Battle;
using ACT.World.Actions;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractElevatorTrigger")]
public class InteractElevatorTrigger : StateObjectBase
{
	public GameObject workSpace;

	[Tooltip("")]
	public InteractActionList enterActionList = new InteractActionList();

	[Tooltip("")]
	public InteractActionList exitActionList = new InteractActionList();

	private bool interact;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		enterActionList.BindInteractObject(this);
		exitActionList.BindInteractObject(this);
		base.InitStateObject(stateId);
	}

	protected override async void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == 1 && toStateId == 0 && !interact)
		{
			await exitActionList.TryInteract(MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
		}
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

	private async void OnTriggerEnter(Collider collision)
	{
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if (component != null && MonoECS.instance.localPlayer.battleEntity.IsValid && component.entity == MonoECS.instance.localPlayer.battleEntity)
		{
			interact = true;
			switch (currentStateId)
			{
			case 0:
				await enterActionList.TryInteract(MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
				break;
			}
		}
	}

	private async void OnTriggerExit(Collider collision)
	{
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if (component != null && MonoECS.instance.localPlayer.battleEntity.IsValid && component.entity == MonoECS.instance.localPlayer.battleEntity)
		{
			interact = false;
			switch (currentStateId)
			{
			case 0:
				await exitActionList.TryInteract(MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
				break;
			}
		}
	}
}
