#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace GameFramework.Runtime;

[RequireComponent(typeof(RectTransform), typeof(CanvasGroup))]
public class UIView : UIBehaviour, IUIView, IView
{
	private IAnimation enterAnimation;

	private IAnimation exitAnimation;

	private RectTransform rectTransform;

	private CanvasGroup canvasGroup;

	private readonly object _lock = new object();

	private EventHandler onDisabled;

	private EventHandler onEnabled;

	[NonSerialized]
	private IAttributes attributes = new Attributes();

	public virtual string Name
	{
		get
		{
			return (!IsDestroyed() && base.gameObject != null) ? base.gameObject.name : null;
		}
		set
		{
			if (!IsDestroyed() && !(base.gameObject == null))
			{
				base.gameObject.name = value;
			}
		}
	}

	public virtual string AssetPath { get; set; }

	public virtual string UIGroup { get; set; }

	public virtual Transform Parent => (!IsDestroyed() && base.transform != null) ? base.transform.parent : null;

	public virtual GameObject Owner => IsDestroyed() ? null : base.gameObject;

	public virtual Transform Transform => IsDestroyed() ? null : base.transform;

	public virtual RectTransform RectTransform
	{
		get
		{
			if (IsDestroyed())
			{
				return null;
			}
			return rectTransform ?? (rectTransform = GetComponent<RectTransform>());
		}
	}

	public virtual bool Visibility
	{
		get
		{
			return !IsDestroyed() && base.gameObject != null && base.gameObject.activeSelf;
		}
		set
		{
			if (!IsDestroyed() && !(base.gameObject == null) && base.gameObject.activeSelf != value)
			{
				base.gameObject.SetActive(value);
			}
		}
	}

	public virtual IAnimation EnterAnimation
	{
		get
		{
			return enterAnimation;
		}
		set
		{
			enterAnimation = value;
		}
	}

	public virtual IAnimation ExitAnimation
	{
		get
		{
			return exitAnimation;
		}
		set
		{
			exitAnimation = value;
		}
	}

	public virtual float Alpha
	{
		get
		{
			return (!IsDestroyed() && base.gameObject != null) ? CanvasGroup.alpha : 0f;
		}
		set
		{
			if (!IsDestroyed() && base.gameObject != null)
			{
				CanvasGroup.alpha = value;
			}
		}
	}

	public virtual bool Interactable
	{
		get
		{
			if (IsDestroyed() || base.gameObject == null)
			{
				return false;
			}
			if (GlobalSetting.useBlocksRaycastsInsteadOfInteractable)
			{
				return CanvasGroup.blocksRaycasts;
			}
			return CanvasGroup.interactable;
		}
		set
		{
			if (!IsDestroyed() && !(base.gameObject == null) && !GlobalSetting.closeCanvasGroupInteractable)
			{
				if (GlobalSetting.useBlocksRaycastsInsteadOfInteractable)
				{
					CanvasGroup.blocksRaycasts = value;
				}
				else
				{
					CanvasGroup.interactable = value;
				}
			}
		}
	}

	public virtual CanvasGroup CanvasGroup
	{
		get
		{
			if (IsDestroyed())
			{
				return null;
			}
			return ((UnityEngine.Object)(object)canvasGroup) ? canvasGroup : (canvasGroup = GetComponent<CanvasGroup>());
		}
	}

	public virtual IAttributes ExtraAttributes => attributes;

	public event EventHandler OnDisabled
	{
		add
		{
			lock (_lock)
			{
				onDisabled = (EventHandler)Delegate.Combine(onDisabled, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				onDisabled = (EventHandler)Delegate.Remove(onDisabled, value);
			}
		}
	}

	public event EventHandler OnEnabled
	{
		add
		{
			lock (_lock)
			{
				onEnabled = (EventHandler)Delegate.Combine(onEnabled, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				onEnabled = (EventHandler)Delegate.Remove(onEnabled, value);
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		OnVisibilityChanged();
		RaiseOnEnabled();
	}

	protected override void OnDisable()
	{
		OnVisibilityChanged();
		base.OnDisable();
		RaiseOnDisabled();
	}

	protected void RaiseOnEnabled()
	{
		try
		{
			if (onEnabled != null)
			{
				onEnabled(this, EventArgs.Empty);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected void RaiseOnDisabled()
	{
		try
		{
			if (onDisabled != null)
			{
				onDisabled(this, EventArgs.Empty);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected virtual void OnVisibilityChanged()
	{
	}
}
