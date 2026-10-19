using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

public class InteractSpring : StateObjectBase
{
	public Animator animator;

	public BoxCollider box;

	private SpringData m_Data;

	private float m_Cd;

	private bool m_StartCD;

	private static readonly int State = Animator.StringToHash("state");

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is SpringData data)
		{
			m_Data = data;
			m_Cd = m_Data.cd;
			base.InitStateObject(stateId);
		}
	}

	private void FixedUpdate()
	{
		if (m_Data != null && currentStateId == 0 && m_StartCD)
		{
			m_Cd -= entity.GetCompTime().fixedDeltaTime;
			if (m_Cd < 0f)
			{
				m_Cd += m_Data.cd;
				m_StartCD = false;
			}
		}
	}

	protected override void HandleInitState(int stateId)
	{
		gameObject.SetActive(stateId == 0);
	}

	protected override void HandleEnterInteract()
	{
	}

	public void OnSpringInteract(Entity entity)
	{
		Vector3 vector = box.transform.TransformPoint(box.center);
		Vector3 endPoint = box.transform.up * m_Data.dis + vector;
		if (!m_StartCD && entity.GetCompPhysics().TriggerEnterSpring(vector, endPoint))
		{
			if (animator != null)
			{
				animator.SetTrigger(State);
			}
			m_StartCD = true;
		}
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
