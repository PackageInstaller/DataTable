using TMPro;
using UnityEngine;

namespace I18N;

[DisallowMultipleComponent]
public class I18NTextMeshProKeyToValue : MonoBehaviour
{
	[SerializeField]
	private string fontPath = "";

	private TextMeshPro textMeshPro;

	private void Awake()
	{
		InitTMPComponent();
		if (Application.isPlaying)
		{
			RefreshFont();
		}
	}

	public void InitTMPComponent()
	{
		if (!(textMeshPro != null))
		{
			textMeshPro = base.gameObject.GetComponent<TextMeshPro>();
		}
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
			TMP_FontAsset tMP_FontAsset = Asset.Load<TMP_FontAsset>(fontPath, isDontDestroy: true);
			if (tMP_FontAsset != null)
			{
				textMeshPro.font = tMP_FontAsset;
			}
		}
	}
}
