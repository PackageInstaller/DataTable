using UnityEngine;

public class AdventureActorAccessElevatorEvent : BaseAdventureEvent
{
	public bool isEnter;

	public string floorPath;

	public Transform floorTrans;

	public static AdventureActorAccessElevatorEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAccessElevatorEvent>("ACTOR_ACCESS_ELEVATOR");
	}

	public AdventureActorAccessElevatorEvent()
		: base("ACTOR_ACCESS_ELEVATOR")
	{
	}

	public override void Clear()
	{
		isEnter = false;
		floorPath = "";
		floorTrans = null;
	}
}
