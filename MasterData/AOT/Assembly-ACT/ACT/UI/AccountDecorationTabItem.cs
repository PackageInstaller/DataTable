using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class AccountDecorationTabItem : MonoBehaviour
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
	private RedDotItem redDotItem;

	[SerializeField]
	private ActButton clickButton;

	public UnityEvent onClick;

	public RectTransform RectTransform => container;

	public void Set(bool status)
	{
		label.color = (status ? activeTextColor : inactiveTextColor);
	}

	public void InitRedDot(string path)
	{
		if (!(redDotItem == null) && !string.IsNullOrEmpty(path))
		{
			redDotItem.InitRedDot(path, redDotItem.redDotType);
		}
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
