using System;
using UnityEngine;

namespace GameFramework.Runtime;

public class View : MonoBehaviour, IView
{
	[NonSerialized]
	private IAttributes attributes = new Attributes();

	public virtual string Name
	{
		get
		{
			return (base.gameObject != null) ? base.gameObject.name : null;
		}
		set
		{
			if (!(base.gameObject == null))
			{
				base.gameObject.name = value;
			}
		}
	}

	public virtual Transform Parent => (base.transform != null) ? base.transform.parent : null;

	public virtual GameObject Owner => base.gameObject;

	public virtual Transform Transform => base.transform;

	public virtual bool Visibility
	{
		get
		{
			return base.gameObject != null && base.gameObject.activeSelf;
		}
		set
		{
			if (!(base.gameObject == null) && base.gameObject.activeSelf != value)
			{
				base.gameObject.SetActive(value);
			}
		}
	}

	public virtual IAttributes ExtraAttributes => attributes;

	protected virtual void OnEnable()
	{
		OnVisibilityChanged();
	}

	protected virtual void OnDisable()
	{
		OnVisibilityChanged();
	}

	protected virtual void OnVisibilityChanged()
	{
	}
}
