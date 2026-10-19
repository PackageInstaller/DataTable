using ACT.World.Actions;
using ACT.World.Behave;
using Bamboo.ECS;

namespace ACT.World.StateObject;

public class InteractDecodeRay : StateObjectBase
{
	public DecodeRayEmitterBehaveEvent emitter;

	public override bool serviceSave { get; }

	public override void InitStateObject(int stateId)
	{
		base.InitStateObject(stateId);
		if (stateId == 1)
		{
			emitter.EmitRay();
		}
		else
		{
			emitter.StopRay();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId >= 0)
		{
			return stateId <= 1;
		}
		return false;
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

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (toStateId == 1)
		{
			emitter.EmitRay();
		}
		else
		{
			emitter.StopRay();
		}
		base.HandleChangeState(fromStateId, toStateId);
	}

	public void ChangeState(int uid, int newState)
	{
	}
}
