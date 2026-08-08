using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("UI/I18NText", 10)]
public class I18NText : Text
{
	[SerializeField]
	private string i18NKey = "";

	private bool isAwaked;

	private bool isSetValue;

	[SerializeField]
	private string fontPath = "";

	public bool _specailBestFit;

	private readonly UIVertex[] m_TempVerts = new UIVertex[4];

	public override string text
	{
		get
		{
			return m_Text;
		}
		set
		{
			if (!Application.isPlaying)
			{
				base.text = value;
				return;
			}
			isSetValue = true;
			i18NKey = value;
			RefreshText();
		}
	}

	public bool specailBestFit
	{
		get
		{
			return _specailBestFit;
		}
		set
		{
			if (_specailBestFit != value)
			{
				_specailBestFit = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public void ChangeI18NKey(string key)
	{
		i18NKey = key;
	}

	public static string GetSource(Transform rootTrs, Transform targetTrs)
	{
		string text = targetTrs.name;
		Transform transform = targetTrs;
		while (transform != rootTrs)
		{
			transform = transform.parent;
			text = transform.name + "$" + text;
		}
		return text;
	}

	public string GetI18NKey()
	{
		return i18NKey;
	}

	public static Transform GetTop(Transform curTrs)
	{
		if (curTrs.parent == null || curTrs.parent.name == "Canvas (Environment)")
		{
			return curTrs;
		}
		return GetTop(curTrs.parent);
	}

	protected override void Awake()
	{
		if (Application.isPlaying)
		{
			RefreshText(isNeedRefreshFont: true, isReWrite: false);
		}
	}

	public void RefreshText(bool isNeedRefreshFont = false, bool isReWrite = true)
	{
		string i18NText = I18NRuntimeManager.Instance.GetI18NText(i18NKey);
		if (i18NText != null)
		{
			base.text = i18NText;
		}
		else if (isReWrite)
		{
			base.text = i18NKey;
		}
		if (isNeedRefreshFont)
		{
			RefreshFont();
		}
	}

	public string GetFontPath()
	{
		return fontPath;
	}

	public void RefreshFont()
	{
		if (fontPath.IsNotNullOrEmpty())
		{
			base.font = Asset.Load<Font>(fontPath, isDontDestroy: true);
		}
	}

	private void _UseFitSettings()
	{
		TextGenerationSettings generationSettings = GetGenerationSettings(base.rectTransform.rect.size);
		generationSettings.resizeTextForBestFit = false;
		if (!base.resizeTextForBestFit)
		{
			base.cachedTextGenerator.Populate(text, generationSettings);
			return;
		}
		int num = base.resizeTextMinSize;
		int length = text.Length;
		int num2 = base.resizeTextMaxSize;
		while (num2 >= num)
		{
			generationSettings.fontSize = num2;
			base.cachedTextGenerator.Populate(text, generationSettings);
			if (base.cachedTextGenerator.characterCountVisible != length)
			{
				num2--;
				continue;
			}
			break;
		}
	}

	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		if (!specailBestFit)
		{
			base.OnPopulateMesh(toFill);
		}
		else
		{
			if (null == base.font)
			{
				return;
			}
			m_DisableFontTextureRebuiltCallback = true;
			_UseFitSettings();
			IList<UIVertex> verts = base.cachedTextGenerator.verts;
			float num = 1f / base.pixelsPerUnit;
			int count = verts.Count;
			if (count <= 0)
			{
				toFill.Clear();
				return;
			}
			Vector2 vector = new Vector2(verts[0].position.x, verts[0].position.y) * num;
			vector = PixelAdjustPoint(vector) - vector;
			toFill.Clear();
			if (vector != Vector2.zero)
			{
				for (int i = 0; i < count; i++)
				{
					int num2 = i & 3;
					m_TempVerts[num2] = verts[i];
					m_TempVerts[num2].position *= num;
					m_TempVerts[num2].position.x += vector.x;
					m_TempVerts[num2].position.y += vector.y;
					if (num2 == 3)
					{
						toFill.AddUIVertexQuad(m_TempVerts);
					}
				}
			}
			else
			{
				for (int j = 0; j < count; j++)
				{
					int num3 = j & 3;
					m_TempVerts[num3] = verts[j];
					m_TempVerts[num3].position *= num;
					if (num3 == 3)
					{
						toFill.AddUIVertexQuad(m_TempVerts);
					}
				}
			}
			m_DisableFontTextureRebuiltCallback = false;
		}
	}
}
