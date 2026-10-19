using UnityEngine;
using UnityEngine.UI;

namespace ACT.LocalLoader;

public class GameStartMessageBtnSelectMark : MonoBehaviour
{
	[SerializeField]
	private Image _markImage;

	[SerializeField]
	private Button _button;

	private bool _markVisible;

	private bool _showMark;

	private void UpdateMarkVisible()
	{
		_markImage.gameObject.SetActive(_markVisible && _showMark && GameStartMessageBtnSelector.GamepadInteractable);
	}

	public void SetMarkVisible(bool vis)
	{
		_markVisible = vis;
		UpdateMarkVisible();
	}

	public void Hide()
	{
		_showMark = false;
		UpdateMarkVisible();
	}

	public void Show()
	{
		_showMark = true;
		UpdateMarkVisible();
	}

	public void Click()
	{
		_button?.onClick.Invoke();
	}

	public bool ButtonIsActive()
	{
		return _button?.gameObject.activeSelf ?? false;
	}
}
