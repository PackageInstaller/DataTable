using System;
using ACT.UI.InputController;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(TextMeshProUGUI))]
public class ActSelectableTextColorComp : MonoBehaviour
{
	private sealed class PointerRelay : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler
	{
		private ActSelectableTextColorComp _owner;

		public void Init(ActSelectableTextColorComp owner)
		{
			_owner = owner;
		}

		public void OnPointerEnter(PointerEventData eventData)
		{
			_owner.SetPointerInside(inside: true);
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			_owner.SetPointerInside(inside: false);
		}

		public void OnPointerDown(PointerEventData eventData)
		{
			if (eventData.button == PointerEventData.InputButton.Left)
			{
				_owner.SetPointerDown(down: true);
			}
		}

		public void OnPointerUp(PointerEventData eventData)
		{
			if (eventData.button == PointerEventData.InputButton.Left)
			{
				_owner.SetPointerDown(down: false);
			}
		}

		public void OnPointerClick(PointerEventData eventData)
		{
			if (eventData.button == PointerEventData.InputButton.Left)
			{
				_owner.SelectByClick();
			}
		}
	}

	private Selectable _clickSelected;

	[SerializeField]
	private Selectable _selectable;

	[SerializeField]
	private Color _normalColor = Color.white;

	[SerializeField]
	private Color _highLightColor = Color.white;

	[SerializeField]
	private Color _pressedColor = Color.gray;

	[SerializeField]
	private Color _selectedColor = Color.white;

	[SerializeField]
	private Color _disabledColor = Color.gray;

	private TextMeshProUGUI _text;

	private PointerRelay _relay;

	private GameObject _selectedObject;

	private bool _interactable;

	private bool _pointerInside;

	private bool _pointerDown;

	private event Action _clickSelectionChanged;

	private void Awake()
	{
		_text = GetComponent<TextMeshProUGUI>();
	}

	private void OnEnable()
	{
		if (!(_selectable == null))
		{
			_relay = _selectable.gameObject.AddComponent<PointerRelay>();
			_relay.Init(this);
			_clickSelectionChanged += RefreshColor;
			_selectedObject = CurrentSelected();
			_interactable = _selectable.IsInteractable();
			RefreshColor();
		}
	}

	private void OnDisable()
	{
		_clickSelectionChanged -= RefreshColor;
		if (_relay != null)
		{
			UnityEngine.Object.Destroy(_relay);
			_relay = null;
		}
		if (_clickSelected == _selectable)
		{
			_clickSelected = null;
		}
	}

	private void LateUpdate()
	{
		if (_selectable == null)
		{
			return;
		}
		GameObject gameObject = CurrentSelected();
		bool flag = _selectable.IsInteractable();
		if (!(gameObject == _selectedObject) || flag != _interactable)
		{
			_selectedObject = gameObject;
			_interactable = flag;
			if (_clickSelected != null && gameObject != null && gameObject != _clickSelected.gameObject)
			{
				_clickSelected = null;
				_clickSelectionChanged?.Invoke();
			}
			RefreshColor();
		}
	}

	private void RefreshColor()
	{
		if (!(_text == null) && !(_selectable == null))
		{
			ActSelectableState actSelectableState = ActSelectableState.Normal;
			if (!_selectable.IsInteractable())
			{
				actSelectableState = ActSelectableState.Disabled;
			}
			else if (_pointerDown && _pointerInside)
			{
				actSelectableState = ActSelectableState.Pressed;
			}
			else if (IsSelected())
			{
				actSelectableState = ActSelectableState.Selected;
			}
			else if (_pointerInside)
			{
				actSelectableState = ActSelectableState.Highlighted;
			}
			TextMeshProUGUI text = _text;
			text.color = actSelectableState switch
			{
				ActSelectableState.Normal => _normalColor, 
				ActSelectableState.Highlighted => _highLightColor, 
				ActSelectableState.Pressed => _pressedColor, 
				ActSelectableState.Selected => _selectedColor, 
				ActSelectableState.Disabled => _disabledColor, 
				_ => _normalColor, 
			};
		}
	}

	private void SetPointerInside(bool inside)
	{
		if (!inside || _selectable.IsInteractable())
		{
			_pointerInside = inside;
			if (!inside)
			{
				_pointerDown = false;
			}
			RefreshColor();
		}
	}

	private void SetPointerDown(bool down)
	{
		if (!down || _selectable.IsInteractable())
		{
			_pointerDown = down;
			RefreshColor();
		}
	}

	private void SelectByClick()
	{
		if (!(_selectable == null) && _selectable.IsInteractable())
		{
			_clickSelected = _selectable;
			_clickSelectionChanged?.Invoke();
		}
	}

	private bool IsSelected()
	{
		if (CurrentSelected() == _selectable.gameObject)
		{
			return true;
		}
		return _clickSelected == _selectable;
	}

	private GameObject CurrentSelected()
	{
		if (!EventSystemHelper.Available)
		{
			return null;
		}
		return EventSystemHelper.CurrentSelected;
	}
}
