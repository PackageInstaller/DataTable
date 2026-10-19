using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class PopupTargetGachaViewTabItem : MonoBehaviour
{
	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private TextMeshProUGUI label;

	[SerializeField]
	private Color activeTextColor;

	[SerializeField]
	private Color inactiveTextColor;

	[SerializeField]
	private ActButton clickButton;

	public UnityEvent onClick;

	public RectTransform RectTransform => container;

	public void Set(bool status)
	{
		label.color = (status ? activeTextColor : inactiveTextColor);
	}

	private void OnEnable()
	{
		clickButton.OnClick.AddListener(OnPointerClick);
	}

	private void OnDisable()
	{
		clickButton.OnClick.RemoveListener(OnPointerClick);
	}

	private void OnPointerClick()
	{
		onClick?.Invoke();
	}
}
