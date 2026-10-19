using ACT.World.Actions;
using Bamboo.ECS;

namespace ACT.World.StateObject.EntryProcessors;

public class NoneEntryProcessor : BaseEntryProcessor
{
	public override void Init(object entryObj)
	{
	}

	public override void Deinit(object entryObj)
	{
	}

	public override void Interact(object entryObj, Entity behave, InteractAction.InteractSource interactSource)
	{
	}

	public override void Enter(object entryObj)
	{
	}

	public override void Leave(object entryObj)
	{
	}

	public override void NetInteract(ICommonInteractEntrySetting entry)
	{
	}

	public override void AddTimer(object entryObj, float deltaTime)
	{
	}

	public override void ExitExpose(object entryObj)
	{
	}
}
