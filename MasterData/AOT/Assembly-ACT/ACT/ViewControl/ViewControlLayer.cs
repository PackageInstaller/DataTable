using System.Collections.Generic;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace ACT.ViewControl;

public class ViewControlLayer : UIBehaviour, IViewControlLayerInternal
{
	public SelectableEx DefaultSelect;

	[FormerlySerializedAs("TargetTransform")]
	public Transform DefaultFindRoot;

	public UnityEvent<bool> OnFocusChanged;

	private ViewControlRoot m_Root;

	private SelectableEx m_LastSelect;

	private readonly HashSet<SelectableEx> m_Selectables = new HashSet<SelectableEx>();

	private readonly List<SelectableEx> m_SelectablesBuffer = new List<SelectableEx>();

	public ViewControlRoot Root
	{
		get
		{
			if (!m_Root)
			{
				RefreshRoot();
			}
			return m_Root;
		}
	}

	public bool IsFocused => m_Root?.CurrentFocusLayer == this;

	public SelectableEx LastSelect => m_LastSelect;

	public IEnumerable<SelectableEx> Selectables => m_Selectables;

	protected override void Start()
	{
		RefreshRoot();
	}

	protected override void OnDisable()
	{
		UnFocus();
		RefreshChildrenLayer();
	}

	protected override void OnTransformParentChanged()
	{
		RefreshRoot();
	}

	private void RefreshRoot()
	{
		m_Root = GetComponentInParent<ViewControlRoot>(includeInactive: true);
	}

	public bool IsValid()
	{
		return IsActive();
	}

	public bool CanInteract()
	{
		if (IsValid())
		{
			if (!(Root == null))
			{
				return Root.CanInteract();
			}
			return true;
		}
		return false;
	}

	public void Focus(bool autoFindSelectable = true)
	{
		((IViewControlRootInternal)Root)?.FocusLayer(this, (SelectableEx)null, autoFindSelectable);
	}

	public void UnFocus()
	{
		((IViewControlRootInternal)Root)?.UnFocusLayer(this);
		m_LastSelect = null;
	}

	public void ReFocus()
	{
		((IViewControlRootInternal)Root)?.FocusLayer(this, m_LastSelect, true);
	}

	void IViewControlLayerInternal.OnChildSelect(SelectableEx selectable)
	{
		if (!(selectable.Layer != this))
		{
			m_LastSelect = selectable;
			((IViewControlRootInternal)Root)?.FocusLayer(this, selectable, true);
		}
	}

	void IViewControlLayerInternal.OnChildDeselect(SelectableEx selectable)
	{
	}

	void IViewControlLayerInternal.OnChildUnavailable(SelectableEx selectable)
	{
		if (!(m_LastSelect != selectable))
		{
			m_LastSelect = null;
		}
	}

	void IViewControlLayerInternal.Register(SelectableEx selectable)
	{
		if ((bool)selectable)
		{
			m_Selectables.Add(selectable);
		}
	}

	void IViewControlLayerInternal.Unregister(SelectableEx selectable)
	{
		if ((bool)selectable)
		{
			m_Selectables.Remove(selectable);
		}
	}

	void IViewControlLayerInternal.OnFocus()
	{
		OnFocusChanged?.Invoke(arg0: true);
	}

	void IViewControlLayerInternal.OnUnFocus()
	{
		OnFocusChanged?.Invoke(arg0: false);
	}

	public void SetTargetTransform(Transform targetTransform)
	{
		DefaultFindRoot = targetTransform;
	}

	public void SetDefaultSelect(SelectableEx defaultSelect)
	{
		DefaultSelect = defaultSelect;
	}

	public SelectableEx GetDefault()
	{
		SelectableEx selectableEx = null;
		if ((bool)DefaultSelect && DefaultSelect.IsValid())
		{
			selectableEx = DefaultSelect;
		}
		if (!selectableEx)
		{
			List<SelectableEx> list = ListPool<SelectableEx>.Get();
			(DefaultFindRoot ? DefaultFindRoot : transform).GetComponentsInChildren(list);
			foreach (SelectableEx item in list)
			{
				if (item.Layer == this && item.IsValid())
				{
					selectableEx = item;
					break;
				}
			}
			ListPool<SelectableEx>.Release(list);
		}
		return selectableEx;
	}

	private void RefreshChildrenLayer()
	{
		m_SelectablesBuffer.Clear();
		m_SelectablesBuffer.AddRange(m_Selectables);
		foreach (SelectableEx item in m_SelectablesBuffer)
		{
			if ((bool)item)
			{
				item.RefreshLayer();
			}
		}
		m_SelectablesBuffer.Clear();
	}
}
