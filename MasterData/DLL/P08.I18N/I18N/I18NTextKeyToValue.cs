using System;
using System.Collections;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

namespace I18N;

[DisallowMultipleComponent]
public class I18NTextKeyToValue : MonoBehaviour
{
	[SerializeField]
	private string m_guid = Guid.NewGuid().ToString();

	[SerializeField]
	private string i18NKey = "";

	[SerializeField]
	private string fontPath = "";

	[SerializeField]
	private bool m_needAutoTranslate = true;

	[SerializeField]
	private bool m_disableAutoSpecialBestFit;

	[SerializeField]
	private bool m_specialBestFit;

	[SerializeField]
	private int bestFitMinSize;

	[SerializeField]
	private int bestFitMaxSize;

	[SerializeField]
	private bool needApplyBestFitWhenEnable;

	private Text textComponent;

	public string originI18NKey { get; set; }

	public string guid
	{
		get
		{
			if (!m_guid.IsNotNullOrEmpty())
			{
				InitGuid();
			}
			return m_guid;
		}
	}

	public bool needAutoTranslate
	{
		get
		{
			return m_needAutoTranslate;
		}
		set
		{
			m_needAutoTranslate = value;
		}
	}

	public bool disableAutoSpecialBestFit
	{
		get
		{
			return m_disableAutoSpecialBestFit;
		}
		set
		{
			SetDisableAutoSpecialBestFit(value);
		}
	}

	public bool specialBestFit
	{
		get
		{
			return m_specialBestFit;
		}
		set
		{
			SetSpecialBestFit(value);
			if (value)
			{
				ApplyBestFit();
			}
		}
	}

	public Text textCom
	{
		get
		{
			if (textComponent == null)
			{
				InitTextComponent();
			}
			return textComponent;
		}
	}

	private void Awake()
	{
		Init();
	}

	private void Init()
	{
		InitTextComponent();
	}

	private void Start()
	{
		InitText(isNeedRefreshFont: true);
	}

	private void OnEnable()
	{
		if (needApplyBestFitWhenEnable)
		{
			textComponent.StartCoroutine(ApplyBestFitCoroutine());
		}
	}

	public void InitGuid()
	{
		m_guid = Guid.NewGuid().ToString();
	}

	public void InitText(bool isNeedRefreshFont = false)
	{
		originI18NKey = i18NKey;
		if (isNeedRefreshFont)
		{
			RefreshFont();
		}
		if (needAutoTranslate)
		{
			RefreshText(i18NKey, isReWrite: false);
		}
	}

	public void InitTextComponent()
	{
		if (!(textComponent != null))
		{
			textComponent = base.gameObject.GetComponent<Text>();
			if (textComponent == null)
			{
				textComponent = base.gameObject.AddComponent<Text>();
			}
			if (Application.isPlaying && !disableAutoSpecialBestFit && textComponent.resizeTextForBestFit)
			{
				SetSpecialBestFit(value: true);
			}
		}
	}

	public void RefreshText(string i18NKey, bool isReWrite = true)
	{
		InitTextComponent();
		if ((i18NKey == null) & isReWrite)
		{
			textComponent.text = string.Empty;
			return;
		}
		originI18NKey = i18NKey;
		this.i18NKey = i18NKey;
		bool flag = false;
		string text = I18NRuntimeManager.Instance.GetI18NText(i18NKey);
		if (text != null)
		{
			flag = true;
		}
		else if (isReWrite)
		{
			flag = true;
			text = i18NKey;
		}
		if ((text != null) & flag)
		{
			textComponent.text = text;
		}
		if (textCom.isActiveAndEnabled)
		{
			textComponent.StartCoroutine(PostProcessText());
		}
	}

	public string GetText()
	{
		InitTextComponent();
		return textComponent.text;
	}

	public void SetI18NKey(string key)
	{
		i18NKey = key;
	}

	public string GetI18NKey()
	{
		return i18NKey;
	}

	[NoToLua]
	public void SetNeedAutoTranslate(bool value)
	{
		needAutoTranslate = value;
	}

	public bool SetFontPath(string path)
	{
		string text = fontPath;
		fontPath = path;
		return !text.Equals(path);
	}

	public string GetFontPath()
	{
		return fontPath;
	}

	public void RefreshFont()
	{
		if (fontPath.IsNotNullOrEmpty())
		{
			string text = fontPath;
			if (PlayerPrefs.GetString("text_language") != "zh_cn" && text.Contains("SourceHanSerifCN"))
			{
				text = "Assets/ABResources/Fonts/SourceHanSans";
			}
			Font font = Asset.Load<Font>(text, isDontDestroy: true);
			if (font != null)
			{
				textComponent.font = font;
			}
		}
	}

	[NoToLua]
	public IEnumerator PostProcessText()
	{
		yield return null;
		if (specialBestFit)
		{
			ApllyBestFitHandler();
		}
	}

	private void ApplyBestFit()
	{
		if (!(textComponent == null) && base.isActiveAndEnabled && specialBestFit)
		{
			StartCoroutine(ApplyBestFitCoroutine());
		}
	}

	private IEnumerator ApplyBestFitCoroutine()
	{
		yield return null;
		ApllyBestFitHandler();
	}

	private void ApllyBestFitHandler()
	{
		if (textComponent == null || !base.isActiveAndEnabled || !specialBestFit)
		{
			return;
		}
		RectTransform rectTransform = textComponent.transform as RectTransform;
		TextGenerationSettings generationSettings = textComponent.GetGenerationSettings(rectTransform.rect.size);
		generationSettings.resizeTextForBestFit = false;
		string text = textComponent.text;
		int length = text.Length;
		for (int num = bestFitMaxSize; num >= bestFitMinSize; num--)
		{
			generationSettings.fontSize = num;
			textComponent.cachedTextGeneratorForLayout.Populate(text, generationSettings);
			if (textComponent.cachedTextGeneratorForLayout.characterCountVisible == length)
			{
				textComponent.fontSize = num;
				break;
			}
			if (num == bestFitMinSize)
			{
				textComponent.fontSize = bestFitMinSize;
			}
		}
	}

	[NoToLua]
	public void SetDisableAutoSpecialBestFit(bool value)
	{
		m_disableAutoSpecialBestFit = value;
		if (value)
		{
			specialBestFit = false;
		}
	}

	[NoToLua]
	public void SetSpecialBestFit(bool value)
	{
		m_specialBestFit = value;
		if (value)
		{
			InitTextComponent();
			if (textComponent.resizeTextForBestFit)
			{
				bestFitMinSize = textComponent.resizeTextMinSize;
				bestFitMaxSize = textComponent.resizeTextMaxSize;
				textComponent.resizeTextForBestFit = false;
			}
		}
	}
}
