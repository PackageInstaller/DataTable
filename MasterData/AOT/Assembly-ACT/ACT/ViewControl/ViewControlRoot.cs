using ACT.UI;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.ViewControl;

public class ViewControlRoot : MonoBehaviour, IViewControlRootInternal, IUIFrameElement
{
	private ViewControlLayer m_CurrentFocusLayer;

	private ViewControlLayer m_PreviousFocusLayer;

	private bool m_Interactable = true;

	public ViewControlLayer CurrentFocusLayer => m_CurrentFocusLayer;

	public ViewControlLayer PreviousFocusLayer => m_PreviousFocusLayer;

	private static void SetSelectedGameObject(GameObject go)
	{
		EventSystemHelper.SetSelectedGameObject(go);
	}

	public void Initialize()
	{
		m_Interactable = true;
	}

	public void PushInStack()
	{
		m_Interactable = false;
		ClearEventSystemSelection();
	}

	public void PopUpStack()
	{
		m_Interactable = true;
		ReFocus();
	}

	public bool CanInteract()
	{
		if (m_Interactable)
		{
			return isActiveAndEnabled;
		}
		return false;
	}

	void IViewControlRootInternal.FocusLayer(ViewControlLayer layer, SelectableEx selectableEx, bool autoFindSelectable)
	{
		if ((bool)layer && layer.IsValid())
		{
			if ((bool)selectableEx && selectableEx.Layer != layer)
			{
				selectableEx = null;
			}
			if ((bool)selectableEx && !selectableEx.IsValid())
			{
				selectableEx = null;
			}
			if (m_CurrentFocusLayer != layer)
			{
				m_PreviousFocusLayer = m_CurrentFocusLayer;
				((IViewControlLayerInternal)m_CurrentFocusLayer)?.OnUnFocus();
				m_CurrentFocusLayer = layer;
				((IViewControlLayerInternal)m_CurrentFocusLayer)?.OnFocus();
			}
			m_CurrentFocusLayer = layer;
			if (!selectableEx & autoFindSelectable)
			{
				selectableEx = m_CurrentFocusLayer?.GetDefault();
			}
			SetSelectedGameObject(selectableEx?.gameObject);
		}
	}

	void IViewControlRootInternal.UnFocusLayer(ViewControlLayer layer)
	{
		if ((bool)layer && !(m_CurrentFocusLayer != layer))
		{
			m_PreviousFocusLayer = m_CurrentFocusLayer;
			m_CurrentFocusLayer = null;
			((IViewControlLayerInternal)layer).OnUnFocus();
			GameObject rawSelected = EventSystemHelper.RawSelected;
			if ((bool)rawSelected && rawSelected == layer.LastSelect?.gameObject)
			{
				SetSelectedGameObject(null);
			}
		}
	}

	public void UnInitialize()
	{
		m_Interactable = false;
		if ((bool)m_CurrentFocusLayer)
		{
			((IViewControlRootInternal)this).UnFocusLayer(m_CurrentFocusLayer);
		}
		m_CurrentFocusLayer = null;
		m_PreviousFocusLayer = null;
		ClearEventSystemSelection();
	}

	private void ClearEventSystemSelection()
	{
		if (EventSystemHelper.Available)
		{
			GameObject rawSelected = EventSystemHelper.RawSelected;
			if ((bool)rawSelected && rawSelected.transform.IsChildOf(transform))
			{
				SetSelectedGameObject(null);
			}
		}
	}

	public bool ReFocus()
	{
		if (!m_CurrentFocusLayer)
		{
			return false;
		}
		m_CurrentFocusLayer.ReFocus();
		return true;
	}

	public void SelectDefault()
	{
		SetSelectedGameObject((m_CurrentFocusLayer?.GetDefault())?.gameObject);
	}

	public void SelectLeft()
	{
		SelectByDirection(MoveDirection.Left);
	}

	public void SelectRight()
	{
		SelectByDirection(MoveDirection.Right);
	}

	public void SelectUp()
	{
		SelectByDirection(MoveDirection.Up);
	}

	public void SelectDown()
	{
		SelectByDirection(MoveDirection.Down);
	}

	private void SelectByDirection(MoveDirection direction)
	{
		if (!EventSystemHelper.Available)
		{
			SelectDefault();
			return;
		}
		if (EventSystemHelper.CurrentSelected == null)
		{
			ReFocus();
			return;
		}
		SelectableEx component = EventSystemHelper.CurrentSelected.GetComponent<SelectableEx>();
		if (!component || !component.IsValid())
		{
			SelectDefault();
			return;
		}
		if (!component.Layer)
		{
			SelectDefault();
			return;
		}
		if (component.Layer.Root != this)
		{
			SelectDefault();
			return;
		}
		GameObject gameObject = null;
		switch (direction)
		{
		case MoveDirection.Left:
			gameObject = component.FindSelectableOnLeft()?.gameObject;
			break;
		case MoveDirection.Up:
			gameObject = component.FindSelectableOnUp()?.gameObject;
			break;
		case MoveDirection.Right:
			gameObject = component.FindSelectableOnRight()?.gameObject;
			break;
		case MoveDirection.Down:
			gameObject = component.FindSelectableOnDown()?.gameObject;
			break;
		}
		if ((bool)gameObject)
		{
			SetSelectedGameObject(gameObject);
		}
	}
}
