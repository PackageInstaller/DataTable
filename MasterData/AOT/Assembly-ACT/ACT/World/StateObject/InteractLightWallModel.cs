using System;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractLightWallModel")]
public class InteractLightWallModel : StateObjectBase
{
	public Vector3 offset;

	public BoxCollider boxCollider;

	public Transform wall;

	public LayerMask colliderLayer;

	public float maxLength;

	public Vector2 sizeXY;

	[NonSerialized]
	public Vector3 endPoint;

	private RaycastHit m_Hit;

	private bool m_init;

	public override bool serviceSave => true;

	protected override void HandleEnterInteract()
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is LightWallData lightWallData)
		{
			sizeXY = lightWallData.sizeXY;
			maxLength = lightWallData.maxLength;
			colliderLayer = lightWallData.colliderLayer;
			boxCollider.size = new Vector3(sizeXY.x, sizeXY.y, 0.5f);
			wall.gameObject.SetActive(value: false);
			m_init = true;
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		wall.gameObject.SetActive(value: false);
		base.ReleaseStateObject();
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 1:
			wall.gameObject.SetActive(value: true);
			break;
		case 0:
			wall.gameObject.SetActive(value: false);
			break;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	protected override void HandleExitInteract()
	{
	}

	private void Update()
	{
		if (currentStateId != 0 && m_init)
		{
			if (Physics.BoxCast(boxCollider.bounds.center, boxCollider.size / 2f, transform.forward, out m_Hit, transform.rotation, maxLength, colliderLayer.value))
			{
				endPoint = transform.position + Vector3.Project(m_Hit.point - transform.position, transform.forward);
			}
			else
			{
				endPoint = transform.position + transform.forward * maxLength;
			}
			float num = Vector3.Distance(transform.position + offset, endPoint);
			if (Math.Abs(num - wall.localScale.z) > 0.1f)
			{
				wall.localScale = new Vector3(sizeXY.x, sizeXY.y, num);
				Vector3 position = (endPoint + transform.position + offset) * 0.5f;
				wall.position = position;
			}
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}
}
