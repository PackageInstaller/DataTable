using UnityEngine;

public class DormActorFSM_Interactive : DormActorFSM
{
	private DormInteractiveContext interactiveContext;

	private Coroutine corInteractiveWait;

	private Coroutine corInteractiveBehaviour;

	private bool _isElevatorFlow;

	public bool IsElevatorFlow => _isElevatorFlow;

	public DormActorFSM_Interactive(DormActor actor, int state)
		: base(actor, state)
	{
	}

	public override void OnEnter(object data)
	{
		base.OnEnter(data);
		if (data == null)
		{
			actor.InterWithObjeComplete();
			return;
		}
		interactiveContext = data as DormInteractiveContext;
		actor.DisableMovment();
		_isElevatorFlow = false;
		if (interactiveContext.furObj != null && interactiveContext.furObj.IsElevator)
		{
			_isElevatorFlow = true;
			StartElevatorBehaviour();
		}
	}

	private void StartElevatorBehaviour()
	{
		DormLevelController dormLevelController = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		if (dormLevelController == null)
		{
			actor.InterWithObjeComplete();
		}
		else if (interactiveContext.isExitFlow)
		{
			dormLevelController.RunElevatorExitFlow(actor, interactiveContext.furObj, interactiveContext.point);
		}
		else
		{
			dormLevelController.RunElevatorEnterFlow(actor, interactiveContext.furObj, interactiveContext.point, interactiveContext.placeAtStartImmediately);
		}
	}

	public override void OnExit()
	{
		actor.EnableMovment();
		interactiveContext?.furObj?.InterruptInteraction();
		if (corInteractiveBehaviour != null)
		{
			StopCoroutine(corInteractiveBehaviour);
			corInteractiveBehaviour = null;
		}
		if (corInteractiveWait != null)
		{
			StopCoroutine(corInteractiveWait);
			corInteractiveWait = null;
		}
		actor.DiscardInteractiveCompleteCallback();
		interactiveContext = null;
		base.OnExit();
	}

	public override void OnInputUpdate(bool movementHasInput, Vector2 inputValue, bool bWalk = false)
	{
		if (movementHasInput && !_isElevatorFlow && actor is DormPlayer)
		{
			DormLevelController dormLevelController = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
			if (!(dormLevelController == null))
			{
				dormLevelController.InterruptPlayerInteractionByInput(actor);
			}
		}
	}
}
