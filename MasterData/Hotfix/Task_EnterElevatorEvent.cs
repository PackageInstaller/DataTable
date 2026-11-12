using UnityEngine;

[AddComponentMenu("触发器结果/其他元素事件/进入或离开电梯", 2)]
public class Task_EnterElevatorEvent : TaskCellBase
{
	public enum AccessElevatorType
	{
		[InspectorName("进入")]
		ENTER,
		[InspectorName("离开")]
		LEAVE
	}

	public enum FloorType
	{
		[InspectorName("地板路径")]
		path,
		[InspectorName("地板引用")]
		instance
	}

	public AccessElevatorType accessType;

	public FloorType floorType;

	public string elevatorFloorPath;

	public Transform elevatorFloor;

	protected override void OnExecute()
	{
		if (accessType == AccessElevatorType.ENTER)
		{
			if (floorType == FloorType.path && string.IsNullOrEmpty(elevatorFloorPath))
			{
				EndAction(success: false);
				return;
			}
			if (floorType == FloorType.instance && elevatorFloor == null)
			{
				EndAction(success: false);
				return;
			}
		}
		AdventureActorAccessElevatorEvent adventureActorAccessElevatorEvent = AdventureActorAccessElevatorEvent.Generate();
		adventureActorAccessElevatorEvent.isEnter = accessType == AccessElevatorType.ENTER;
		adventureActorAccessElevatorEvent.floorPath = elevatorFloorPath;
		adventureActorAccessElevatorEvent.floorTrans = elevatorFloor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAccessElevatorEvent);
		EndAction();
	}
}
