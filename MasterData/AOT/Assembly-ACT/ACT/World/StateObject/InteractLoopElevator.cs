using ACT.World.Actions;
using ACT.World.Behave;
using Bamboo.ECS;

namespace ACT.World.StateObject;

public class InteractLoopElevator : InteractObject
{
	public LoopElevatorBehaveEvent loopElevator;

	public override bool serviceSave { get; }

	public override void InitStateObject(int stateId)
	{
		if (stateId == 0)
		{
			loopElevator.Stop();
		}
		else
		{
			loopElevator.Run();
		}
		base.InitStateObject(stateId);
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (entryIndex == 0)
		{
			loopElevator.Stop();
		}
		else
		{
			loopElevator.Run();
		}
	}
}
