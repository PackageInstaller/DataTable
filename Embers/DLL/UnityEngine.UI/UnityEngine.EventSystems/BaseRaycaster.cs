using System;
using System.Collections.Generic;

namespace UnityEngine.EventSystems;

public abstract class BaseRaycaster : UIBehaviour
{
	private BaseRaycaster m_RootRaycaster;

	public abstract Camera eventCamera { get; }

	[Obsolete("Please use sortOrderPriority and renderOrderPriority", false)]
	public virtual int priority => 0;

	public virtual int sortOrderPriority => int.MinValue;

	public virtual int renderOrderPriority => int.MinValue;

	public BaseRaycaster rootRaycaster
	{
		get
		{
			if (m_RootRaycaster == null)
			{
				BaseRaycaster[] componentsInParent = GetComponentsInParent<BaseRaycaster>();
				if (componentsInParent.Length != 0)
				{
					m_RootRaycaster = componentsInParent[componentsInParent.Length - 1];
				}
			}
			return m_RootRaycaster;
		}
	}

	public abstract void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList);

	public override string ToString()
	{
		return "Name: " + base.gameObject?.ToString() + "\neventCamera: " + eventCamera?.ToString() + "\nsortOrderPriority: " + sortOrderPriority + "\nrenderOrderPriority: " + renderOrderPriority;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		RaycasterManager.AddRaycaster(this);
	}

	protected override void OnDisable()
	{
		RaycasterManager.RemoveRaycasters(this);
		base.OnDisable();
	}

	protected override void OnCanvasHierarchyChanged()
	{
		base.OnCanvasHierarchyChanged();
		m_RootRaycaster = null;
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		m_RootRaycaster = null;
	}
}
