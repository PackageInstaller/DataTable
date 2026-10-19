using System;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;

namespace ACT.UI;

public abstract class BookViewBaseVH : BaseItemViewsHolder
{
	private float size;

	public override void CollectViews()
	{
		base.CollectViews();
		size = root.rect.width;
	}

	public virtual ACT.ViewControl.SelectableEx GetCurrentSelectableEx()
	{
		ACT.ViewControl.SelectableEx component = root.GetComponent<ACT.ViewControl.SelectableEx>();
		if (component != null)
		{
			return component;
		}
		ACT.ViewControl.SelectableEx[] componentsInChildren = root.GetComponentsInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
		if (componentsInChildren.Length != 0)
		{
			return componentsInChildren[0];
		}
		return null;
	}

	public abstract bool CanPresentModelType(Type modelType);

	public virtual void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
	}

	public virtual void UpdateSize()
	{
		root.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, size);
	}

	public virtual void SetSelect(bool isSelect)
	{
	}
}
