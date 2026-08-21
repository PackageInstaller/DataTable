using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class WindowView : UIView, IWindowView, IUIViewGroup, IUIView, IView
{
	private IAnimation activationAnimation;

	private IAnimation passivationAnimation;

	public virtual IAnimation ActivationAnimation
	{
		get
		{
			return activationAnimation;
		}
		set
		{
			activationAnimation = value;
		}
	}

	public virtual IAnimation PassivationAnimation
	{
		get
		{
			return passivationAnimation;
		}
		set
		{
			passivationAnimation = value;
		}
	}

	public virtual List<IUIView> Views
	{
		get
		{
			Transform transform = Transform;
			List<IUIView> list = new List<IUIView>();
			int childCount = transform.childCount;
			for (int i = 0; i < childCount; i++)
			{
				Transform child = transform.GetChild(i);
				IUIView component = child.GetComponent<IUIView>();
				if (component != null)
				{
					list.Add(component);
				}
			}
			return list;
		}
	}

	public virtual IUIView GetView(string name)
	{
		return Views.Find((IUIView v) => v.Name.Equals(name));
	}

	public virtual void AddView(IUIView view, bool worldPositionStays = false)
	{
		if (view != null)
		{
			Transform transform = view.Transform;
			if (!(transform == null) && !(transform.parent == base.transform))
			{
				view.Owner.layer = base.gameObject.layer;
				transform.SetParent(base.transform, worldPositionStays);
			}
		}
	}

	public virtual void AddView(IUIView view, UILayout layout)
	{
		if (view == null)
		{
			return;
		}
		Transform transform = view.Transform;
		if (!(transform == null))
		{
			if (transform.parent == base.transform)
			{
				layout?.Invoke(view.RectTransform);
				return;
			}
			view.Owner.layer = base.gameObject.layer;
			transform.SetParent(base.transform, worldPositionStays: false);
			layout?.Invoke(view.RectTransform);
		}
	}

	public virtual void RemoveView(IUIView view, bool worldPositionStays = false)
	{
		if (view != null)
		{
			Transform transform = view.Transform;
			if (!(transform == null) && !(transform.parent != base.transform))
			{
				transform.SetParent(null, worldPositionStays);
			}
		}
	}
}
