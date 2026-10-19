using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractAreaCamera : StateObjectBase
{
	public Animator animator;

	public BoxCollider triggerField;

	public BoxCollider conFinerField;

	private AreaCameraData m_Data;

	private static readonly int State = Animator.StringToHash("state");

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is AreaCameraData data)
		{
			m_Data = data;
			m_Data.triggerField.CopyTo(triggerField);
			m_Data.conFinerField.CopyTo(conFinerField);
			CinemachineFramingTransposerACT cinemachineFramingTransposerACT = GetComponentInChildren<CinemachineVirtualCamera>()?.GetCinemachineComponent<CinemachineFramingTransposerACT>();
			if (cinemachineFramingTransposerACT != null)
			{
				cinemachineFramingTransposerACT.m_CameraDistance = m_Data.cameraDistance;
				cinemachineFramingTransposerACT.m_TrackedObjectOffset = m_Data.trackedObjectOffset;
			}
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		animator.SetInteger(State, toStateId);
		base.HandleChangeState(fromStateId, toStateId);
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

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	private void FixedUpdate()
	{
		if (animator != null && entity.IsLogicAvailable())
		{
			animator.speed = entity.GetCompTime().fixedSpeed;
		}
	}
}
