using TMPro;
using UnityEngine;

namespace ACT.UI;

[RequireComponent(typeof(TextMeshProUGUI))]
public class ActBtnTextColorComp : MonoBehaviour
{
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

	private ActButton _actButton;

	private void Awake()
	{
		_text = GetComponent<TextMeshProUGUI>();
		_actButton = GetComponentInParent<ActButton>();
	}

	private void OnEnable()
	{
		if (_actButton != null)
		{
			_actButton.OnStateChanged += OnButtonStateChanged;
			OnButtonStateChanged(_actButton.CurrentState);
		}
	}

	private void OnDisable()
	{
		if (_actButton != null)
		{
			_actButton.OnStateChanged -= OnButtonStateChanged;
		}
	}

	private void OnButtonStateChanged(ActSelectableState state)
	{
		if (!(_text == null))
		{
			TextMeshProUGUI text = _text;
			text.color = state switch
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
}
