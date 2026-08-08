using System;
using UnityEngine;
using UnityEngine.UI;

public class LoadingUIManager
{
	private static LoadingUIManager _inst;

	private string _lastPath = "";

	private Sprite _Image;

	private Action<LoadingUIType> _loadingShowAction;

	private LoadingUIType _type;

	private GameObject _ui;

	private CanvasGroup _canvas;

	private Image _progress;

	private Text _progressText;

	private Text _progressPercentSignText;

	private Text _titleText;

	private Text _TipText;

	private Image _background;

	private GameObject _panel;

	private string ui_path = "UI/SceneLoadingPanel";

	public static LoadingUIManager inst
	{
		get
		{
			if (_inst == null)
			{
				_inst = new LoadingUIManager();
			}
			return _inst;
		}
	}

	public Sprite GetLoadingSprite(string path = null)
	{
		if (string.IsNullOrEmpty(path))
		{
			return Resources.Load<Sprite>("Texture/loadingDefault");
		}
		if (!path.Equals(_lastPath))
		{
			Sprite sprite = Asset.Load<Sprite>(path, isDontDestroy: true);
			if (!(sprite != null))
			{
				Debug.LogError("Cant find Loading UI Texture :" + path);
				return Resources.Load<Sprite>("Texture/loadingDefault");
			}
			_Image = sprite;
			_lastPath = path;
		}
		return _Image;
	}

	public void ShowLoadUI(LoadingUIType type = LoadingUIType.Default)
	{
		if (_ui == null)
		{
			_ui = Asset.InstantiateWithoutCache(ui_path, dontDestroy: true);
			_ui.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas").transform, worldPositionStays: false);
			_canvas = _ui.transform.GetComponent<CanvasGroup>();
			_panel = _ui.transform.Find("BG").gameObject;
			_progress = _ui.transform.Find("BG/Progress").GetComponent<Image>();
			_progressText = _ui.transform.Find("BG/text").GetComponent<Text>();
			_progressPercentSignText = _ui.transform.Find("BG/text/1").GetComponent<Text>();
			_titleText = _ui.transform.Find("BG/tips/tap").GetComponent<Text>();
			_TipText = _ui.transform.Find("BG/tips").GetComponent<Text>();
			_background = _ui.transform.Find("background").GetComponent<Image>();
			SetUIProgress(0f);
		}
		else
		{
			_ui.SetActive(value: true);
		}
		_type = type;
		_loadingShowAction?.Invoke(type);
	}

	public void CloseLoadUI()
	{
		if (!(_ui == null))
		{
			UnityEngine.Object.Destroy(_ui);
			if (!string.IsNullOrEmpty(_lastPath))
			{
				Asset.Unload(_lastPath, isDontDestroy: true);
				_lastPath = "";
			}
			_ui = null;
			Asset.Unload(ui_path, isDontDestroy: true);
		}
	}

	public void UpdateLoadingInfo(string title, string tip, string spriteName)
	{
		if ((bool)_titleText)
		{
			_titleText.text = title ?? "";
		}
		if ((bool)_titleText)
		{
			_TipText.text = tip ?? "";
		}
		SetBackground(spriteName);
	}

	public void SetUIText(string value)
	{
		if ((bool)_progressText)
		{
			_progressText.text = value;
		}
		if ((bool)_progressPercentSignText)
		{
			_progressPercentSignText.text = "";
		}
	}

	public void SetUIProgress(float value)
	{
		if ((bool)_progress)
		{
			_progress.fillAmount = value / 100f;
		}
		if ((bool)_progressText)
		{
			_progressText.text = $"{_progress.fillAmount * 100f:0}";
		}
		if ((bool)_progressPercentSignText)
		{
			_progressPercentSignText.text = "%";
		}
	}

	public void SetLoadingShowAction(Action<LoadingUIType> action)
	{
		_loadingShowAction = action;
	}

	public void SetBackground(string spriteName = null)
	{
		string path = null;
		if (!string.IsNullOrEmpty(spriteName))
		{
			path = "TextureConfig/Loading/" + spriteName;
		}
		if ((bool)_background)
		{
			_background.sprite = GetLoadingSprite(path);
		}
	}

	public void UpdateLoadingInfo2(string title, string tip, string spriteName)
	{
		if ((bool)_titleText)
		{
			_titleText.text = title ?? "";
		}
		if ((bool)_titleText)
		{
			_TipText.text = tip ?? "";
		}
		SetBackground2(spriteName);
	}

	public void SetBackground2(string spriteName = null)
	{
		string path = null;
		if (!string.IsNullOrEmpty(spriteName))
		{
			path = "TextureConfig/Background/" + spriteName;
		}
		if ((bool)_background)
		{
			_background.sprite = GetLoadingSprite(path);
		}
	}

	public void DontShowAnything(bool flag)
	{
		_panel.SetActive(!flag);
		_background.color = (flag ? Color.black : Color.white);
	}
}
