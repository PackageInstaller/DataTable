using FMODUnity;
using UnityEngine;
using UnityEngine.Animations;

namespace Ase.ECS;

public class FmodListenerLinkComponent : BaseComponent
{
	protected ParentConstraint _listener;

	protected BaseEntity ownerEntity;

	protected BaseEntity followEntity;

	public void ChangeLinkState(bool aiCtrl, Transform linkTransform)
	{
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		if (linkTransform == null)
		{
			return;
		}
		if (aiCtrl)
		{
			if ((Object)(object)_listener != null)
			{
				((Component)(object)_listener).gameObject.SetActive(value: false);
			}
			return;
		}
		if ((Object)(object)_listener == null)
		{
			GameObject gameObject = new GameObject();
			gameObject.name = "FmodListener_" + linkTransform.name;
			gameObject.transform.SetParent(linkTransform.parent);
			_listener = gameObject.AddComponent<ParentConstraint>();
			_listener.rotationAxis = (Axis)0;
			ConstraintSource val = default(ConstraintSource);
			((ConstraintSource)(ref val)).weight = 1f;
			((ConstraintSource)(ref val)).sourceTransform = linkTransform;
			_listener.AddSource(val);
			if (base.Entity.GetWorld().GetSystem<CameraSystem>() != null && base.Entity.GetWorld().GetSystem<CameraSystem>().BattleCamera != null)
			{
				gameObject.transform.rotation = base.Entity.GetWorld().GetSystem<CameraSystem>().BattleCamera.transform.rotation;
				gameObject.AddComponent<StudioListener>();
				_listener.constraintActive = true;
			}
		}
		((Component)(object)_listener).gameObject.SetActive(value: true);
	}

	public override void OnDispose()
	{
		TryDispose();
	}

	private void TryDispose()
	{
		if ((Object)(object)_listener != null)
		{
			Object.DestroyImmediate(((Component)(object)_listener).gameObject);
			_listener = null;
		}
	}
}
