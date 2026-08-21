using System;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[Serializable]
public class FontData : ISerializationCallbackReceiver
{
	[SerializeField]
	[FormerlySerializedAs("font")]
	private Font m_Font;

	[SerializeField]
	[FormerlySerializedAs("fontSize")]
	private int m_FontSize;

	[SerializeField]
	[FormerlySerializedAs("fontStyle")]
	private FontStyle m_FontStyle;

	[SerializeField]
	private bool m_BestFit;

	[SerializeField]
	private int m_MinSize;

	[SerializeField]
	private int m_MaxSize;

	[SerializeField]
	[FormerlySerializedAs("alignment")]
	private TextAnchor m_Alignment;

	[SerializeField]
	private bool m_AlignByGeometry;

	[SerializeField]
	[FormerlySerializedAs("richText")]
	private bool m_RichText;

	[SerializeField]
	private HorizontalWrapMode m_HorizontalOverflow;

	[SerializeField]
	private VerticalWrapMode m_VerticalOverflow;

	[SerializeField]
	private float m_LineSpacing;

	public static FontData defaultFontData
	{
		get
		{
			//IL_001a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0038: Unknown result type (might be due to invalid IL or missing references)
			//IL_003f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0046: Unknown result type (might be due to invalid IL or missing references)
			return new FontData
			{
				m_FontSize = 14,
				m_LineSpacing = 1f,
				m_FontStyle = (FontStyle)0,
				m_BestFit = false,
				m_MinSize = 10,
				m_MaxSize = 40,
				m_Alignment = (TextAnchor)0,
				m_HorizontalOverflow = (HorizontalWrapMode)0,
				m_VerticalOverflow = (VerticalWrapMode)0,
				m_RichText = true,
				m_AlignByGeometry = false
			};
		}
	}

	public Font font
	{
		get
		{
			return m_Font;
		}
		set
		{
			m_Font = value;
		}
	}

	public int fontSize
	{
		get
		{
			return m_FontSize;
		}
		set
		{
			m_FontSize = value;
		}
	}

	public FontStyle fontStyle
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return m_FontStyle;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			m_FontStyle = value;
		}
	}

	public bool bestFit
	{
		get
		{
			return m_BestFit;
		}
		set
		{
			m_BestFit = value;
		}
	}

	public int minSize
	{
		get
		{
			return m_MinSize;
		}
		set
		{
			m_MinSize = value;
		}
	}

	public int maxSize
	{
		get
		{
			return m_MaxSize;
		}
		set
		{
			m_MaxSize = value;
		}
	}

	public TextAnchor alignment
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return m_Alignment;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			m_Alignment = value;
		}
	}

	public bool alignByGeometry
	{
		get
		{
			return m_AlignByGeometry;
		}
		set
		{
			m_AlignByGeometry = value;
		}
	}

	public bool richText
	{
		get
		{
			return m_RichText;
		}
		set
		{
			m_RichText = value;
		}
	}

	public HorizontalWrapMode horizontalOverflow
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return m_HorizontalOverflow;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			m_HorizontalOverflow = value;
		}
	}

	public VerticalWrapMode verticalOverflow
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return m_VerticalOverflow;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			m_VerticalOverflow = value;
		}
	}

	public float lineSpacing
	{
		get
		{
			return m_LineSpacing;
		}
		set
		{
			m_LineSpacing = value;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		m_FontSize = Mathf.Clamp(m_FontSize, 0, 300);
		m_MinSize = Mathf.Clamp(m_MinSize, 0, m_FontSize);
		m_MaxSize = Mathf.Clamp(m_MaxSize, m_FontSize, 300);
	}
}
