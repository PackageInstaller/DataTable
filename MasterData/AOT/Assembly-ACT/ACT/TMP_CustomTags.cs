using TMPro;
using UnityEngine;

namespace ACT;

[RequireComponent(typeof(TMP_Text))]
public class TMP_CustomTags : TMP_BaseCustomTags
{
	private TMP_Text tmpComponent;

	public string TextWithoutCustomTags { get; private set; } = string.Empty;

	private void Awake()
	{
		CacheTMPOnce();
	}

	private void Update()
	{
		if (IsReady() && HasChanged(TextWithoutCustomTags))
		{
			ConvertText();
		}
	}

	private void CacheTMPOnce()
	{
		tmpComponent = GetComponent<TMP_Text>();
	}

	private void ConvertText()
	{
		string text = (TextWithoutCustomTags = ProcessText(tmpComponent.text));
		tmpComponent.text = text;
	}

	private bool IsReady()
	{
		return tmpComponent != null;
	}

	private bool HasChanged(string text)
	{
		if (string.IsNullOrEmpty(tmpComponent.text) && string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (string.IsNullOrEmpty(tmpComponent.text) != string.IsNullOrEmpty(text))
		{
			return true;
		}
		return !tmpComponent.text.Equals(text);
	}

	public void ForceUpdate()
	{
		ConvertText();
	}
}
