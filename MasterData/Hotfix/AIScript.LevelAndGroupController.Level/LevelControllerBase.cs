using System.Collections.Generic;
using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class LevelControllerBase : AIBase
{
	private List<GroupControllerBase> groupControllers = new List<GroupControllerBase>();

	public void OnStart()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
		OnControllerStart();
	}

	public void OnUpdate()
	{
		foreach (GroupControllerBase groupController in groupControllers)
		{
			groupController.Update();
		}
		OnControllerUpdate();
	}

	protected virtual void OnControllerUpdate()
	{
	}

	protected virtual void OnControllerStart()
	{
	}

	public void OnStop()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
		foreach (GroupControllerBase groupController in groupControllers)
		{
			groupController.Stop();
		}
		groupControllers.Clear();
		OnControllerStop();
	}

	protected virtual void OnControllerStop()
	{
	}

	private void OnReceiveInterActiveMessage(IEvent iEvt)
	{
		if (iEvt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger)
		{
			OnReceiveInterActiveMessage(adventureInteractiveIDTrigger.interactiveID);
		}
	}

	protected virtual void OnReceiveInterActiveMessage(string message)
	{
	}

	protected void AddGroupController(GroupControllerBase groupController)
	{
		if (groupController != null)
		{
			groupControllers.Add(groupController);
			groupController.Start();
		}
	}

	protected void RemoveGroupController(GroupControllerBase groupController)
	{
		if (groupController != null && groupControllers.Contains(groupController))
		{
			groupController.Stop();
			groupControllers.Remove(groupController);
		}
	}
}
