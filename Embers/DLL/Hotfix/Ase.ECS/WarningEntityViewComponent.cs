using UnityEngine;

namespace Ase.ECS;

public class WarningEntityViewComponent : BaseComponent
{
	private WarningIndicatorView entityView;

	private GameObject virtualObj;

	public override void OnAwake(object data = null)
	{
		GenerateEntityView();
	}

	private void GenerateEntityView()
	{
		GameObject entityObject = mBaseEntity.GetEntityObject();
		if (!(entityObject == null) && mBaseEntity.GetEntityView() != null)
		{
			entityObject.SetActive(value: false);
			entityView = (WarningIndicatorView)entityObject.GetOrAddComponent(mBaseEntity.GetEntityView());
			entityView.OnInit(mBaseEntity);
			entityView.OnAwake();
		}
	}

	public override void OnStart(object data = null)
	{
		if (entityView != null)
		{
			entityView.OnStart(data);
			mBaseEntity.GetEntityObject().SetActive(value: true);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		if (entityView != null)
		{
			entityView.OnUpdate(deltaTime);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (entityView != null)
		{
			entityView.OnFixedUpdate(updateType, deltaTime);
		}
	}

	public override void OnEntityRelease()
	{
		if (entityView != null)
		{
			entityView.GetComponent<IPooledObject>()?.Free();
		}
	}

	public void SetEntityScale(Vector3 vector3)
	{
		if (entityView != null)
		{
			entityView.transform.localScale = vector3;
		}
	}

	public override void OnDispose()
	{
		if (entityView != null)
		{
			entityView.OnDispose();
			entityView = null;
		}
		if (virtualObj != null)
		{
			Object.DestroyImmediate(virtualObj);
			virtualObj = null;
		}
	}
}
