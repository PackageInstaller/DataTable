using ACT.World.Actions;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/TemporaryPortal")]
public class TemporaryPortal : StateObjectBase
{
	[SerializeField]
	[Tooltip("（前提是交互物需要在服务器存档）")]
	private bool m_ServiceSave = true;

	public override bool serviceSave => m_ServiceSave;

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

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity entity, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		base.InitStateObject(stateId);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
	}
}
