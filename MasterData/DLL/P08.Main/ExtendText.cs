using UnityEngine;
using UnityEngine.UI;

public class ExtendText : MonoBehaviour
{
	[SerializeField]
	private Button _moreBtn;

	[SerializeField]
	private Text _content;

	[SerializeField]
	private RectTransform _bg;

	[SerializeField]
	private Button _bgBtn;

	[SerializeField]
	private RectTransform _maskImage;

	[SerializeField]
	private ScrollRect _scrollRect;

	private Controller _extendingController;

	private Controller _outofRangeController;

	private void Awake()
	{
		Controller[] components = GetComponents<Controller>();
		foreach (Controller controller in components)
		{
			if (controller.name == "extending")
			{
				_extendingController = controller;
			}
			else if (controller.name == "outofRange")
			{
				_outofRangeController = controller;
			}
		}
		_moreBtn.onClick.AddListener(OnClick);
		_bgBtn.onClick.AddListener(OnBgClick);
		_scrollRect.vertical = false;
		UpdateView();
	}

	private void OnBgClick()
	{
		Hide();
	}

	private void OnClick()
	{
		Show();
	}

	public void SetText(string value)
	{
		_content.text = value;
		UpdateView();
	}

	private void UpdateView()
	{
		if (IsOutOfHeight())
		{
			_outofRangeController.SetSelectedState("true");
		}
		else
		{
			_outofRangeController.SetSelectedState("false");
		}
	}

	private float GetTextHeight()
	{
		Vector2 size = _content.rectTransform.rect.size;
		TextGenerationSettings generationSettings = _content.GetGenerationSettings(size);
		float num = 1f / _content.pixelsPerUnit;
		return _content.cachedTextGenerator.GetPreferredHeight(_content.text, generationSettings) * num;
	}

	private bool IsOutOfHeight()
	{
		return GetTextHeight() > _scrollRect.viewport.rect.height;
	}

	public void Show()
	{
		_scrollRect.vertical = true;
		_extendingController.SetSelectedState("true");
	}

	public void Hide()
	{
		_scrollRect.vertical = false;
		_extendingController.SetSelectedState("false");
	}

	private void OnDestroy()
	{
		_moreBtn.onClick.RemoveAllListeners();
	}
}
