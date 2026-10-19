using System;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractLightWall")]
public class InteractLightWall : StateObjectBase
{
	public YooAssetReference effectReferenceAssetID;

	private EffectRuntimeItem m_effect;

	private MonoRayEffect m_MonoRay;

	public BoxCollider wall;

	[NonSerialized]
	private LightWallData m_Data;

	public override bool serviceSave => true;

	protected override void HandleEnterInteract()
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is LightWallData data)
		{
			m_Data = data;
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		if (m_effect != null)
		{
			wall.transform.SetParent(transform);
			m_effect.SetToBeRemove();
		}
		m_effect = null;
		m_MonoRay = null;
		wall = null;
		base.ReleaseStateObject();
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 1:
			if (m_effect != null)
			{
				m_effect.go.SetActive(value: true);
				break;
			}
			m_effect = GameManager.effectSystem.FireEffect(effectReferenceAssetID, m_Data.initPos, m_Data.initRotate);
			SetWall();
			break;
		case 0:
			if (m_effect != null)
			{
				m_effect.go.SetActive(value: false);
			}
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

	public async void SetWall()
	{
		await UniTask.WaitUntil(() => m_effect.status == AsyncOperationStatus.Succeeded);
		m_MonoRay = m_effect.go.GetComponent<MonoRayEffect>();
		wall.transform.SetParent(m_effect.go.transform, worldPositionStays: false);
		ConstraintSource source = new ConstraintSource
		{
			sourceTransform = transform,
			weight = 1f
		};
		ParentConstraint component = m_effect.go.GetComponent<ParentConstraint>();
		for (int num = component.sourceCount - 1; num >= 0; num--)
		{
			component.RemoveSource(num);
		}
		component.AddSource(source);
		component.constraintActive = true;
		m_MonoRay.boxCollider.size = new Vector3(m_Data.sizeXY.x, m_Data.sizeXY.y, 0.5f);
	}

	private void Update()
	{
		if (currentStateId != 0 && !(m_MonoRay == null))
		{
			float num = Vector3.Distance(m_MonoRay.transform.position, m_MonoRay.endPoint);
			if (Math.Abs(num - wall.size.z) > 0.1f)
			{
				m_MonoRay.radius = m_Data.sizeXY.y * 1.8f;
				m_MonoRay.boxCollider.size = new Vector3(m_Data.sizeXY.x, m_Data.sizeXY.y, 0.5f);
				wall.size = new Vector3(m_Data.sizeXY.x, m_Data.sizeXY.y, num);
				Vector3 position = (m_MonoRay.endPoint + m_MonoRay.transform.position) * 0.5f;
				wall.transform.position = position;
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
