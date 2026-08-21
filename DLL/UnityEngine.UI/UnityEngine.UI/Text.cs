using System;
using System.Collections.Generic;

namespace UnityEngine.UI;

[RequireComponent(typeof(CanvasRenderer))]
[AddComponentMenu("UI/Legacy/Text", 100)]
public class Text : MaskableGraphic, ILayoutElement
{
	[SerializeField]
	private FontData m_FontData = FontData.defaultFontData;

	[TextArea(3, 10)]
	[SerializeField]
	protected string m_Text = string.Empty;

	private TextGenerator m_TextCache;

	private TextGenerator m_TextCacheForLayout;

	protected static Material s_DefaultText;

	[NonSerialized]
	protected bool m_DisableFontTextureRebuiltCallback;

	private readonly UIVertex[] m_TempVerts = (UIVertex[])(object)new UIVertex[4];

	public TextGenerator cachedTextGenerator
	{
		get
		{
			//IL_002a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			//IL_002f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0031: Expected O, but got Unknown
			//IL_0036: Expected O, but got Unknown
			TextGenerator obj = m_TextCache;
			if (obj == null)
			{
				TextGenerator val = ((m_Text.Length != 0) ? new TextGenerator(m_Text.Length) : new TextGenerator());
				TextGenerator val2 = val;
				m_TextCache = val;
				obj = val2;
			}
			return obj;
		}
	}

	public TextGenerator cachedTextGeneratorForLayout
	{
		get
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0010: Unknown result type (might be due to invalid IL or missing references)
			//IL_0012: Expected O, but got Unknown
			//IL_0017: Expected O, but got Unknown
			TextGenerator obj = m_TextCacheForLayout;
			if (obj == null)
			{
				TextGenerator val = new TextGenerator();
				TextGenerator val2 = val;
				m_TextCacheForLayout = val;
				obj = val2;
			}
			return obj;
		}
	}

	public override Texture mainTexture
	{
		get
		{
			if ((Object)(object)font != null && font.material != null && font.material.mainTexture != null)
			{
				return font.material.mainTexture;
			}
			if (m_Material != null)
			{
				return m_Material.mainTexture;
			}
			return base.mainTexture;
		}
	}

	public Font font
	{
		get
		{
			return m_FontData.font;
		}
		set
		{
			if (!((Object)(object)m_FontData.font == (Object)(object)value))
			{
				if (base.isActiveAndEnabled)
				{
					FontUpdateTracker.UntrackText(this);
				}
				m_FontData.font = value;
				if (base.isActiveAndEnabled)
				{
					FontUpdateTracker.TrackText(this);
				}
				SetAllDirty();
			}
		}
	}

	public virtual string text
	{
		get
		{
			return m_Text;
		}
		set
		{
			if (string.IsNullOrEmpty(value))
			{
				if (!string.IsNullOrEmpty(m_Text))
				{
					m_Text = "";
					SetVerticesDirty();
				}
			}
			else if (m_Text != value)
			{
				m_Text = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public bool supportRichText
	{
		get
		{
			return m_FontData.richText;
		}
		set
		{
			if (m_FontData.richText != value)
			{
				m_FontData.richText = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public bool resizeTextForBestFit
	{
		get
		{
			return m_FontData.bestFit;
		}
		set
		{
			if (m_FontData.bestFit != value)
			{
				m_FontData.bestFit = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public int resizeTextMinSize
	{
		get
		{
			return m_FontData.minSize;
		}
		set
		{
			if (m_FontData.minSize != value)
			{
				m_FontData.minSize = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public int resizeTextMaxSize
	{
		get
		{
			return m_FontData.maxSize;
		}
		set
		{
			if (m_FontData.maxSize != value)
			{
				m_FontData.maxSize = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public TextAnchor alignment
	{
		get
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return m_FontData.alignment;
		}
		set
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0015: Unknown result type (might be due to invalid IL or missing references)
			if (m_FontData.alignment != value)
			{
				m_FontData.alignment = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public bool alignByGeometry
	{
		get
		{
			return m_FontData.alignByGeometry;
		}
		set
		{
			if (m_FontData.alignByGeometry != value)
			{
				m_FontData.alignByGeometry = value;
				SetVerticesDirty();
			}
		}
	}

	public int fontSize
	{
		get
		{
			return m_FontData.fontSize;
		}
		set
		{
			if (m_FontData.fontSize != value)
			{
				m_FontData.fontSize = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public HorizontalWrapMode horizontalOverflow
	{
		get
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return m_FontData.horizontalOverflow;
		}
		set
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0015: Unknown result type (might be due to invalid IL or missing references)
			if (m_FontData.horizontalOverflow != value)
			{
				m_FontData.horizontalOverflow = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public VerticalWrapMode verticalOverflow
	{
		get
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return m_FontData.verticalOverflow;
		}
		set
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0015: Unknown result type (might be due to invalid IL or missing references)
			if (m_FontData.verticalOverflow != value)
			{
				m_FontData.verticalOverflow = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public float lineSpacing
	{
		get
		{
			return m_FontData.lineSpacing;
		}
		set
		{
			if (m_FontData.lineSpacing != value)
			{
				m_FontData.lineSpacing = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public FontStyle fontStyle
	{
		get
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return m_FontData.fontStyle;
		}
		set
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0015: Unknown result type (might be due to invalid IL or missing references)
			if (m_FontData.fontStyle != value)
			{
				m_FontData.fontStyle = value;
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	public float pixelsPerUnit
	{
		get
		{
			Canvas val = base.canvas;
			if (!(Object)(object)val)
			{
				return 1f;
			}
			if (!(Object)(object)font || font.dynamic)
			{
				return val.scaleFactor;
			}
			if (m_FontData.fontSize <= 0 || font.fontSize <= 0)
			{
				return 1f;
			}
			return (float)font.fontSize / (float)m_FontData.fontSize;
		}
	}

	public virtual float minWidth => 0f;

	public virtual float preferredWidth
	{
		get
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			TextGenerationSettings generationSettings = GetGenerationSettings(Vector2.zero);
			return cachedTextGeneratorForLayout.GetPreferredWidth(m_Text, generationSettings) / pixelsPerUnit;
		}
	}

	public virtual float flexibleWidth => -1f;

	public virtual float minHeight => 0f;

	public virtual float preferredHeight
	{
		get
		{
			//IL_001e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0023: Unknown result type (might be due to invalid IL or missing references)
			//IL_0030: Unknown result type (might be due to invalid IL or missing references)
			TextGenerationSettings generationSettings = GetGenerationSettings(new Vector2(GetPixelAdjustedRect().size.x, 0f));
			return cachedTextGeneratorForLayout.GetPreferredHeight(m_Text, generationSettings) / pixelsPerUnit;
		}
	}

	public virtual float flexibleHeight => -1f;

	public virtual int layoutPriority => 0;

	protected Text()
	{
		base.useLegacyMeshGeneration = false;
	}

	public void FontTextureChanged()
	{
		if (!this || m_DisableFontTextureRebuiltCallback)
		{
			return;
		}
		cachedTextGenerator.Invalidate();
		if (IsActive())
		{
			if (CanvasUpdateRegistry.IsRebuildingGraphics() || CanvasUpdateRegistry.IsRebuildingLayout())
			{
				UpdateGeometry();
			}
			else
			{
				SetAllDirty();
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		cachedTextGenerator.Invalidate();
		FontUpdateTracker.TrackText(this);
	}

	protected override void OnDisable()
	{
		FontUpdateTracker.UntrackText(this);
		base.OnDisable();
	}

	protected override void UpdateGeometry()
	{
		if ((Object)(object)font != null)
		{
			base.UpdateGeometry();
		}
	}

	internal void AssignDefaultFont()
	{
		font = Resources.GetBuiltinResource<Font>("Arial.ttf");
	}

	internal void AssignDefaultFontIfNecessary()
	{
		if ((Object)(object)font == null)
		{
			font = Resources.GetBuiltinResource<Font>("Arial.ttf");
		}
	}

	public TextGenerationSettings GetGenerationSettings(Vector2 extents)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		TextGenerationSettings result = new TextGenerationSettings
		{
			generationExtents = extents
		};
		if ((Object)(object)font != null && font.dynamic)
		{
			result.fontSize = m_FontData.fontSize;
			result.resizeTextMinSize = m_FontData.minSize;
			result.resizeTextMaxSize = m_FontData.maxSize;
		}
		result.textAnchor = m_FontData.alignment;
		result.alignByGeometry = m_FontData.alignByGeometry;
		result.scaleFactor = pixelsPerUnit;
		result.color = color;
		result.font = font;
		result.pivot = base.rectTransform.pivot;
		result.richText = m_FontData.richText;
		result.lineSpacing = m_FontData.lineSpacing;
		result.fontStyle = m_FontData.fontStyle;
		result.resizeTextForBestFit = m_FontData.bestFit;
		result.updateBounds = false;
		result.horizontalOverflow = m_FontData.horizontalOverflow;
		result.verticalOverflow = m_FontData.verticalOverflow;
		return result;
	}

	public static Vector2 GetTextAnchorPivot(TextAnchor anchor)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Expected I4, but got Unknown
		return (int)anchor switch
		{
			6 => new Vector2(0f, 0f), 
			7 => new Vector2(0.5f, 0f), 
			8 => new Vector2(1f, 0f), 
			3 => new Vector2(0f, 0.5f), 
			4 => new Vector2(0.5f, 0.5f), 
			5 => new Vector2(1f, 0.5f), 
			0 => new Vector2(0f, 1f), 
			1 => new Vector2(0.5f, 1f), 
			2 => new Vector2(1f, 1f), 
			_ => Vector2.zero, 
		};
	}

	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0192: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)font == null)
		{
			return;
		}
		m_DisableFontTextureRebuiltCallback = true;
		Vector2 size = base.rectTransform.rect.size;
		TextGenerationSettings generationSettings = GetGenerationSettings(size);
		cachedTextGenerator.PopulateWithErrors(text, generationSettings, base.gameObject);
		IList<UIVertex> verts = cachedTextGenerator.verts;
		float num = 1f / pixelsPerUnit;
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

	public virtual void CalculateLayoutInputHorizontal()
	{
	}

	public virtual void CalculateLayoutInputVertical()
	{
	}
}
