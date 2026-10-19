using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Serialization;
using UnityEngine.Sprites;
using UnityEngine.U2D;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Image", 11)]
[RequireComponent(typeof(CanvasRenderer))]
public class Image : MaskableGraphic, ISerializationCallbackReceiver, ILayoutElement, ICanvasRaycastFilter
{
	public enum Type
	{
		Simple,
		Sliced,
		Tiled,
		Filled,
		SlicedAndFiled
	}

	public enum FillMethod
	{
		Horizontal,
		Vertical,
		Radial90,
		Radial180,
		Radial360
	}

	public enum OriginHorizontal
	{
		Left,
		Right
	}

	public enum OriginVertical
	{
		Bottom,
		Top
	}

	public enum Origin90
	{
		BottomLeft,
		TopLeft,
		TopRight,
		BottomRight
	}

	public enum Origin180
	{
		Bottom,
		Left,
		Top,
		Right
	}

	public enum Origin360
	{
		Bottom,
		Right,
		Top,
		Left
	}

	protected static Material s_ETC1DefaultUI = null;

	[SerializeField]
	private bool m_CullingWithEmpty;

	[FormerlySerializedAs("m_Frame")]
	[SerializeField]
	private Sprite m_Sprite;

	[NonSerialized]
	private Sprite m_OverrideSprite;

	[SerializeField]
	private Type m_Type;

	[SerializeField]
	private bool m_PreserveAspect;

	[SerializeField]
	private bool m_FillCenter = true;

	[SerializeField]
	private FillMethod m_FillMethod = FillMethod.Radial360;

	[SerializeField]
	[Range(0f, 1f)]
	private float m_FillAmount = 1f;

	[SerializeField]
	private bool m_FillClockwise = true;

	[SerializeField]
	private int m_FillOrigin;

	private float m_AlphaHitTestMinimumThreshold;

	[SerializeField]
	private bool m_UseRedChannelHitTest;

	[SerializeField]
	private float m_RedChannelHitTestMinimumThreshold = 0.5f;

	[SerializeField]
	private bool m_RedChannelInvert;

	[SerializeField]
	private Texture2D m_RedChannelMaskTexture;

	private bool m_Tracked;

	[SerializeField]
	private bool m_UseSpriteMesh;

	[SerializeField]
	private float m_PixelsPerUnitMultiplier = 1f;

	private float m_CachedReferencePixelsPerUnit = 100f;

	private static readonly Vector2[] s_VertScratch = new Vector2[4];

	private static readonly Vector2[] s_UVScratch = new Vector2[4];

	private static readonly Vector3[] s_Xy = new Vector3[4];

	private static readonly Vector3[] s_Uv = new Vector3[4];

	private static List<Image> m_TrackedTexturelessImages = new List<Image>();

	private static bool s_Initialized;

	public Sprite sprite
	{
		get
		{
			return m_Sprite;
		}
		set
		{
			if (m_Sprite != null)
			{
				if (m_Sprite != value)
				{
					m_SkipLayoutUpdate = m_Sprite.rect.size.Equals(value ? value.rect.size : Vector2.zero);
					m_SkipMaterialUpdate = m_Sprite.texture == (value ? value.texture : null);
					m_Sprite = value;
					ResetAlphaHitThresholdIfNeeded();
					SetAllDirty();
					TrackSprite();
				}
			}
			else if (value != null)
			{
				m_SkipLayoutUpdate = value.rect.size == Vector2.zero;
				m_SkipMaterialUpdate = value.texture == null;
				m_Sprite = value;
				ResetAlphaHitThresholdIfNeeded();
				SetAllDirty();
				TrackSprite();
			}
			void ResetAlphaHitThresholdIfNeeded()
			{
				if (!SpriteSupportsAlphaHitTest() && m_AlphaHitTestMinimumThreshold > 0f)
				{
					Debug.LogWarning("Sprite was changed for one not readable or with Crunch Compression. Resetting the AlphaHitThreshold to 0.", this);
					m_AlphaHitTestMinimumThreshold = 0f;
				}
			}
			bool SpriteSupportsAlphaHitTest()
			{
				if (m_Sprite != null && m_Sprite.texture != null && !GraphicsFormatUtility.IsCrunchFormat(m_Sprite.texture.format))
				{
					return m_Sprite.texture.isReadable;
				}
				return false;
			}
		}
	}

	public Sprite overrideSprite
	{
		get
		{
			return activeSprite;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_OverrideSprite, value))
			{
				SetAllDirty();
				TrackSprite();
			}
		}
	}

	private Sprite activeSprite
	{
		get
		{
			if (!(m_OverrideSprite != null))
			{
				return sprite;
			}
			return m_OverrideSprite;
		}
	}

	public Type type
	{
		get
		{
			return m_Type;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Type, value))
			{
				SetVerticesDirty();
			}
		}
	}

	public bool preserveAspect
	{
		get
		{
			return m_PreserveAspect;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_PreserveAspect, value))
			{
				SetVerticesDirty();
			}
		}
	}

	public bool fillCenter
	{
		get
		{
			return m_FillCenter;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_FillCenter, value))
			{
				SetVerticesDirty();
			}
		}
	}

	public FillMethod fillMethod
	{
		get
		{
			return m_FillMethod;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_FillMethod, value))
			{
				SetVerticesDirty();
				m_FillOrigin = 0;
			}
		}
	}

	public float fillAmount
	{
		get
		{
			return m_FillAmount;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_FillAmount, Mathf.Clamp01(value)))
			{
				SetVerticesDirty();
			}
		}
	}

	public bool fillClockwise
	{
		get
		{
			return m_FillClockwise;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_FillClockwise, value))
			{
				SetVerticesDirty();
			}
		}
	}

	public int fillOrigin
	{
		get
		{
			return m_FillOrigin;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_FillOrigin, value))
			{
				SetVerticesDirty();
			}
		}
	}

	[Obsolete("eventAlphaThreshold has been deprecated. Use eventMinimumAlphaThreshold instead (UnityUpgradable) -> alphaHitTestMinimumThreshold")]
	public float eventAlphaThreshold
	{
		get
		{
			return 1f - alphaHitTestMinimumThreshold;
		}
		set
		{
			alphaHitTestMinimumThreshold = 1f - value;
		}
	}

	public float alphaHitTestMinimumThreshold
	{
		get
		{
			return m_AlphaHitTestMinimumThreshold;
		}
		set
		{
			if (sprite != null && (GraphicsFormatUtility.IsCrunchFormat(sprite.texture.format) || !sprite.texture.isReadable))
			{
				throw new InvalidOperationException("alphaHitTestMinimumThreshold should not be modified on a texture not readeable or not using Crunch Compression.");
			}
			m_AlphaHitTestMinimumThreshold = value;
		}
	}

	public bool useRedChannelHitTest
	{
		get
		{
			return m_UseRedChannelHitTest;
		}
		set
		{
			m_UseRedChannelHitTest = value;
		}
	}

	public float redChannelHitTestMinimumThreshold
	{
		get
		{
			return m_RedChannelHitTestMinimumThreshold;
		}
		set
		{
			m_RedChannelHitTestMinimumThreshold = Mathf.Clamp01(value);
		}
	}

	public bool redChannelInvert
	{
		get
		{
			return m_RedChannelInvert;
		}
		set
		{
			m_RedChannelInvert = value;
		}
	}

	public Texture2D redChannelMaskTexture
	{
		get
		{
			return m_RedChannelMaskTexture;
		}
		set
		{
			m_RedChannelMaskTexture = value;
		}
	}

	public bool useSpriteMesh
	{
		get
		{
			return m_UseSpriteMesh;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_UseSpriteMesh, value))
			{
				SetVerticesDirty();
			}
		}
	}

	public static Material defaultETC1GraphicMaterial
	{
		get
		{
			if (s_ETC1DefaultUI == null)
			{
				s_ETC1DefaultUI = Canvas.GetETC1SupportedCanvasMaterial();
			}
			return s_ETC1DefaultUI;
		}
	}

	public override Texture mainTexture
	{
		get
		{
			if (activeSprite == null)
			{
				if (material != null && material.mainTexture != null)
				{
					return material.mainTexture;
				}
				return Graphic.s_WhiteTexture;
			}
			return activeSprite.texture;
		}
	}

	public bool hasBorder
	{
		get
		{
			if (activeSprite != null)
			{
				return activeSprite.border.sqrMagnitude > 0f;
			}
			return false;
		}
	}

	public float pixelsPerUnitMultiplier
	{
		get
		{
			return m_PixelsPerUnitMultiplier;
		}
		set
		{
			m_PixelsPerUnitMultiplier = Mathf.Max(0.01f, value);
			SetVerticesDirty();
		}
	}

	public float pixelsPerUnit
	{
		get
		{
			float num = 100f;
			if ((bool)activeSprite)
			{
				num = activeSprite.pixelsPerUnit;
			}
			if ((bool)canvas)
			{
				m_CachedReferencePixelsPerUnit = canvas.referencePixelsPerUnit;
			}
			return num / m_CachedReferencePixelsPerUnit;
		}
	}

	protected float multipliedPixelsPerUnit => pixelsPerUnit * m_PixelsPerUnitMultiplier;

	public override Material material
	{
		get
		{
			if (m_Material != null)
			{
				return m_Material;
			}
			if ((bool)activeSprite && activeSprite.associatedAlphaSplitTexture != null)
			{
				return defaultETC1GraphicMaterial;
			}
			return defaultMaterial;
		}
		set
		{
			base.material = value;
		}
	}

	public virtual float minWidth => 0f;

	public virtual float preferredWidth
	{
		get
		{
			if (activeSprite == null)
			{
				return 0f;
			}
			if (type == Type.Sliced || type == Type.Tiled)
			{
				return DataUtility.GetMinSize(activeSprite).x / pixelsPerUnit;
			}
			return activeSprite.rect.size.x / pixelsPerUnit;
		}
	}

	public virtual float flexibleWidth => -1f;

	public virtual float minHeight => 0f;

	public virtual float preferredHeight
	{
		get
		{
			if (activeSprite == null)
			{
				return 0f;
			}
			if (type == Type.Sliced || type == Type.Tiled)
			{
				return DataUtility.GetMinSize(activeSprite).y / pixelsPerUnit;
			}
			return activeSprite.rect.size.y / pixelsPerUnit;
		}
	}

	public virtual float flexibleHeight => -1f;

	public virtual int layoutPriority => 0;

	public void DisableSpriteOptimizations()
	{
		m_SkipLayoutUpdate = false;
		m_SkipMaterialUpdate = false;
	}

	protected Image()
	{
		useLegacyMeshGeneration = false;
	}

	public virtual void OnBeforeSerialize()
	{
	}

	public virtual void OnAfterDeserialize()
	{
		if (m_FillOrigin < 0)
		{
			m_FillOrigin = 0;
		}
		else if (m_FillMethod == FillMethod.Horizontal && m_FillOrigin > 1)
		{
			m_FillOrigin = 0;
		}
		else if (m_FillMethod == FillMethod.Vertical && m_FillOrigin > 1)
		{
			m_FillOrigin = 0;
		}
		else if (m_FillOrigin > 3)
		{
			m_FillOrigin = 0;
		}
		m_FillAmount = Mathf.Clamp(m_FillAmount, 0f, 1f);
	}

	private void PreserveSpriteAspectRatio(ref Rect rect, Vector2 spriteSize)
	{
		float num = spriteSize.x / spriteSize.y;
		float num2 = rect.width / rect.height;
		if (num > num2)
		{
			float height = rect.height;
			rect.height = rect.width * (1f / num);
			rect.y += (height - rect.height) * rectTransform.pivot.y;
		}
		else
		{
			float width = rect.width;
			rect.width = rect.height * num;
			rect.x += (width - rect.width) * rectTransform.pivot.x;
		}
	}

	private Vector4 GetDrawingDimensions(bool shouldPreserveAspect)
	{
		Vector4 vector = ((activeSprite == null) ? Vector4.zero : DataUtility.GetPadding(activeSprite));
		Vector2 spriteSize = ((activeSprite == null) ? Vector2.zero : new Vector2(activeSprite.rect.width, activeSprite.rect.height));
		Rect rect = GetPixelAdjustedRect();
		int num = Mathf.RoundToInt(spriteSize.x);
		int num2 = Mathf.RoundToInt(spriteSize.y);
		Vector4 vector2 = new Vector4(vector.x / (float)num, vector.y / (float)num2, ((float)num - vector.z) / (float)num, ((float)num2 - vector.w) / (float)num2);
		if (shouldPreserveAspect && spriteSize.sqrMagnitude > 0f)
		{
			PreserveSpriteAspectRatio(ref rect, spriteSize);
		}
		return new Vector4(rect.x + rect.width * vector2.x, rect.y + rect.height * vector2.y, rect.x + rect.width * vector2.z, rect.y + rect.height * vector2.w);
	}

	public override void SetNativeSize()
	{
		if (activeSprite != null)
		{
			float x = activeSprite.rect.width / pixelsPerUnit;
			float y = activeSprite.rect.height / pixelsPerUnit;
			rectTransform.anchorMax = rectTransform.anchorMin;
			rectTransform.sizeDelta = new Vector2(x, y);
			SetAllDirty();
		}
	}

	protected override bool CanCullingEmpty()
	{
		if (m_CullingWithEmpty && new Vector3(color.r, color.g, color.b).Equals(Vector3.one))
		{
			return activeSprite == null;
		}
		return false;
	}

	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		if (activeSprite == null)
		{
			base.OnPopulateMesh(toFill);
			return;
		}
		switch (type)
		{
		case Type.Simple:
			if (!useSpriteMesh)
			{
				GenerateSimpleSprite(toFill, m_PreserveAspect);
			}
			else
			{
				GenerateSprite(toFill, m_PreserveAspect);
			}
			break;
		case Type.Sliced:
			GenerateSlicedSprite(toFill);
			break;
		case Type.Tiled:
			GenerateTiledSprite(toFill);
			break;
		case Type.Filled:
			GenerateFilledSprite(toFill, m_PreserveAspect);
			break;
		case Type.SlicedAndFiled:
			GenerateSlicedAndFilledSprite(toFill);
			break;
		}
	}

	private void TrackSprite()
	{
		if (activeSprite != null && activeSprite.texture == null)
		{
			TrackImage(this);
			m_Tracked = true;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		TrackSprite();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (m_Tracked)
		{
			UnTrackImage(this);
		}
	}

	protected override void UpdateMaterial()
	{
		base.UpdateMaterial();
		if (activeSprite == null)
		{
			canvasRenderer.SetAlphaTexture(null);
			return;
		}
		Texture2D associatedAlphaSplitTexture = activeSprite.associatedAlphaSplitTexture;
		if (associatedAlphaSplitTexture != null)
		{
			canvasRenderer.SetAlphaTexture(associatedAlphaSplitTexture);
		}
	}

	protected override void OnCanvasHierarchyChanged()
	{
		base.OnCanvasHierarchyChanged();
		if (canvas == null)
		{
			m_CachedReferencePixelsPerUnit = 100f;
		}
		else if (canvas.referencePixelsPerUnit != m_CachedReferencePixelsPerUnit)
		{
			m_CachedReferencePixelsPerUnit = canvas.referencePixelsPerUnit;
			if (type == Type.Sliced || type == Type.Tiled)
			{
				SetVerticesDirty();
				SetLayoutDirty();
			}
		}
	}

	private void GenerateSimpleSprite(VertexHelper vh, bool lPreserveAspect)
	{
		Vector4 drawingDimensions = GetDrawingDimensions(lPreserveAspect);
		Vector4 vector = ((activeSprite != null) ? DataUtility.GetOuterUV(activeSprite) : Vector4.zero);
		Color color = this.color;
		vh.Clear();
		vh.AddVert(new Vector3(drawingDimensions.x, drawingDimensions.y), color, new Vector2(vector.x, vector.y));
		vh.AddVert(new Vector3(drawingDimensions.x, drawingDimensions.w), color, new Vector2(vector.x, vector.w));
		vh.AddVert(new Vector3(drawingDimensions.z, drawingDimensions.w), color, new Vector2(vector.z, vector.w));
		vh.AddVert(new Vector3(drawingDimensions.z, drawingDimensions.y), color, new Vector2(vector.z, vector.y));
		vh.AddTriangle(0, 1, 2);
		vh.AddTriangle(2, 3, 0);
	}

	private void GenerateSprite(VertexHelper vh, bool lPreserveAspect)
	{
		Vector2 vector = new Vector2(activeSprite.rect.width, activeSprite.rect.height);
		Vector2 vector2 = activeSprite.pivot / vector;
		Vector2 pivot = rectTransform.pivot;
		Rect rect = GetPixelAdjustedRect();
		if (lPreserveAspect & (vector.sqrMagnitude > 0f))
		{
			PreserveSpriteAspectRatio(ref rect, vector);
		}
		Vector2 vector3 = new Vector2(rect.width, rect.height);
		Vector3 size = activeSprite.bounds.size;
		Vector2 vector4 = (pivot - vector2) * vector3;
		Color color = this.color;
		vh.Clear();
		Vector2[] vertices = activeSprite.vertices;
		Vector2[] uv = activeSprite.uv;
		for (int i = 0; i < vertices.Length; i++)
		{
			vh.AddVert(new Vector3(vertices[i].x / size.x * vector3.x - vector4.x, vertices[i].y / size.y * vector3.y - vector4.y), color, new Vector2(uv[i].x, uv[i].y));
		}
		ushort[] triangles = activeSprite.triangles;
		for (int j = 0; j < triangles.Length; j += 3)
		{
			vh.AddTriangle(triangles[j], triangles[j + 1], triangles[j + 2]);
		}
	}

	private void GenerateSlicedSprite(VertexHelper toFill)
	{
		if (!hasBorder)
		{
			GenerateSimpleSprite(toFill, lPreserveAspect: false);
			return;
		}
		Vector4 vector;
		Vector4 vector2;
		Vector4 vector3;
		Vector4 vector4;
		if (activeSprite != null)
		{
			vector = DataUtility.GetOuterUV(activeSprite);
			vector2 = DataUtility.GetInnerUV(activeSprite);
			vector3 = DataUtility.GetPadding(activeSprite);
			vector4 = activeSprite.border;
		}
		else
		{
			vector = Vector4.zero;
			vector2 = Vector4.zero;
			vector3 = Vector4.zero;
			vector4 = Vector4.zero;
		}
		Rect pixelAdjustedRect = GetPixelAdjustedRect();
		Vector4 adjustedBorders = GetAdjustedBorders(vector4 / multipliedPixelsPerUnit, pixelAdjustedRect);
		vector3 /= multipliedPixelsPerUnit;
		s_VertScratch[0] = new Vector2(vector3.x, vector3.y);
		s_VertScratch[3] = new Vector2(pixelAdjustedRect.width - vector3.z, pixelAdjustedRect.height - vector3.w);
		s_VertScratch[1].x = adjustedBorders.x;
		s_VertScratch[1].y = adjustedBorders.y;
		s_VertScratch[2].x = pixelAdjustedRect.width - adjustedBorders.z;
		s_VertScratch[2].y = pixelAdjustedRect.height - adjustedBorders.w;
		for (int i = 0; i < 4; i++)
		{
			s_VertScratch[i].x += pixelAdjustedRect.x;
			s_VertScratch[i].y += pixelAdjustedRect.y;
		}
		s_UVScratch[0] = new Vector2(vector.x, vector.y);
		s_UVScratch[1] = new Vector2(vector2.x, vector2.y);
		s_UVScratch[2] = new Vector2(vector2.z, vector2.w);
		s_UVScratch[3] = new Vector2(vector.z, vector.w);
		toFill.Clear();
		for (int j = 0; j < 3; j++)
		{
			int num = j + 1;
			for (int k = 0; k < 3; k++)
			{
				if (m_FillCenter || j != 1 || k != 1)
				{
					int num2 = k + 1;
					if (!(s_VertScratch[num].x - s_VertScratch[j].x <= 0f) && !(s_VertScratch[num2].y - s_VertScratch[k].y <= 0f))
					{
						AddQuad(toFill, new Vector2(s_VertScratch[j].x, s_VertScratch[k].y), new Vector2(s_VertScratch[num].x, s_VertScratch[num2].y), color, new Vector2(s_UVScratch[j].x, s_UVScratch[k].y), new Vector2(s_UVScratch[num].x, s_UVScratch[num2].y));
					}
				}
			}
		}
	}

	private void GenerateTiledSprite(VertexHelper toFill)
	{
		Vector4 vector;
		Vector4 vector2;
		Vector2 vector4;
		Vector4 vector3;
		if (activeSprite != null)
		{
			vector = DataUtility.GetOuterUV(activeSprite);
			vector2 = DataUtility.GetInnerUV(activeSprite);
			vector3 = activeSprite.border;
			vector4 = activeSprite.rect.size;
		}
		else
		{
			vector = Vector4.zero;
			vector2 = Vector4.zero;
			vector3 = Vector4.zero;
			vector4 = Vector2.one * 100f;
		}
		Rect pixelAdjustedRect = GetPixelAdjustedRect();
		float num = (vector4.x - vector3.x - vector3.z) / multipliedPixelsPerUnit;
		float num2 = (vector4.y - vector3.y - vector3.w) / multipliedPixelsPerUnit;
		vector3 = GetAdjustedBorders(vector3 / multipliedPixelsPerUnit, pixelAdjustedRect);
		Vector2 vector5 = new Vector2(vector2.x, vector2.y);
		Vector2 vector6 = new Vector2(vector2.z, vector2.w);
		float x = vector3.x;
		float num3 = pixelAdjustedRect.width - vector3.z;
		float y = vector3.y;
		float num4 = pixelAdjustedRect.height - vector3.w;
		toFill.Clear();
		Vector2 uvMax = vector6;
		if (num <= 0f)
		{
			num = num3 - x;
		}
		if (num2 <= 0f)
		{
			num2 = num4 - y;
		}
		if (activeSprite != null && (hasBorder || activeSprite.packed || (activeSprite.texture != null && activeSprite.texture.wrapMode != TextureWrapMode.Repeat)))
		{
			long num5 = 0L;
			long num6 = 0L;
			if (m_FillCenter)
			{
				num5 = (long)Math.Ceiling((num3 - x) / num);
				num6 = (long)Math.Ceiling((num4 - y) / num2);
				double num7 = 0.0;
				num7 = ((!hasBorder) ? ((double)(num5 * num6) * 4.0) : (((double)num5 + 2.0) * ((double)num6 + 2.0) * 4.0));
				if (num7 > 65000.0)
				{
					Debug.LogError("Too many sprite tiles on Image \"" + name + "\". The tile size will be increased. To remove the limit on the number of tiles, set the Wrap mode to Repeat in the Image Import Settings", this);
					double num8 = ((!hasBorder) ? ((double)num5 / (double)num6) : (((double)num5 + 2.0) / ((double)num6 + 2.0)));
					double num9 = Math.Sqrt(16250.0 / num8);
					double num10 = num9 * num8;
					if (hasBorder)
					{
						num9 -= 2.0;
						num10 -= 2.0;
					}
					num5 = (long)Math.Floor(num9);
					num6 = (long)Math.Floor(num10);
					num = (num3 - x) / (float)num5;
					num2 = (num4 - y) / (float)num6;
				}
			}
			else if (hasBorder)
			{
				num5 = (long)Math.Ceiling((num3 - x) / num);
				num6 = (long)Math.Ceiling((num4 - y) / num2);
				if (((double)(num6 + num5) + 2.0) * 2.0 * 4.0 > 65000.0)
				{
					Debug.LogError("Too many sprite tiles on Image \"" + name + "\". The tile size will be increased. To remove the limit on the number of tiles, set the Wrap mode to Repeat in the Image Import Settings", this);
					double num11 = (double)num5 / (double)num6;
					double num12 = (16250.0 - 4.0) / (2.0 * (1.0 + num11));
					double d = num12 * num11;
					num5 = (long)Math.Floor(num12);
					num6 = (long)Math.Floor(d);
					num = (num3 - x) / (float)num5;
					num2 = (num4 - y) / (float)num6;
				}
			}
			else
			{
				num6 = (num5 = 0L);
			}
			if (m_FillCenter)
			{
				for (long num13 = 0L; num13 < num6; num13++)
				{
					float num14 = y + (float)num13 * num2;
					float num15 = y + (float)(num13 + 1) * num2;
					if (num15 > num4)
					{
						uvMax.y = vector5.y + (vector6.y - vector5.y) * (num4 - num14) / (num15 - num14);
						num15 = num4;
					}
					uvMax.x = vector6.x;
					for (long num16 = 0L; num16 < num5; num16++)
					{
						float num17 = x + (float)num16 * num;
						float num18 = x + (float)(num16 + 1) * num;
						if (num18 > num3)
						{
							uvMax.x = vector5.x + (vector6.x - vector5.x) * (num3 - num17) / (num18 - num17);
							num18 = num3;
						}
						AddQuad(toFill, new Vector2(num17, num14) + pixelAdjustedRect.position, new Vector2(num18, num15) + pixelAdjustedRect.position, color, vector5, uvMax);
					}
				}
			}
			if (!hasBorder)
			{
				return;
			}
			uvMax = vector6;
			for (long num19 = 0L; num19 < num6; num19++)
			{
				float num20 = y + (float)num19 * num2;
				float num21 = y + (float)(num19 + 1) * num2;
				if (num21 > num4)
				{
					uvMax.y = vector5.y + (vector6.y - vector5.y) * (num4 - num20) / (num21 - num20);
					num21 = num4;
				}
				AddQuad(toFill, new Vector2(0f, num20) + pixelAdjustedRect.position, new Vector2(x, num21) + pixelAdjustedRect.position, color, new Vector2(vector.x, vector5.y), new Vector2(vector5.x, uvMax.y));
				AddQuad(toFill, new Vector2(num3, num20) + pixelAdjustedRect.position, new Vector2(pixelAdjustedRect.width, num21) + pixelAdjustedRect.position, color, new Vector2(vector6.x, vector5.y), new Vector2(vector.z, uvMax.y));
			}
			uvMax = vector6;
			for (long num22 = 0L; num22 < num5; num22++)
			{
				float num23 = x + (float)num22 * num;
				float num24 = x + (float)(num22 + 1) * num;
				if (num24 > num3)
				{
					uvMax.x = vector5.x + (vector6.x - vector5.x) * (num3 - num23) / (num24 - num23);
					num24 = num3;
				}
				AddQuad(toFill, new Vector2(num23, 0f) + pixelAdjustedRect.position, new Vector2(num24, y) + pixelAdjustedRect.position, color, new Vector2(vector5.x, vector.y), new Vector2(uvMax.x, vector5.y));
				AddQuad(toFill, new Vector2(num23, num4) + pixelAdjustedRect.position, new Vector2(num24, pixelAdjustedRect.height) + pixelAdjustedRect.position, color, new Vector2(vector5.x, vector6.y), new Vector2(uvMax.x, vector.w));
			}
			AddQuad(toFill, new Vector2(0f, 0f) + pixelAdjustedRect.position, new Vector2(x, y) + pixelAdjustedRect.position, color, new Vector2(vector.x, vector.y), new Vector2(vector5.x, vector5.y));
			AddQuad(toFill, new Vector2(num3, 0f) + pixelAdjustedRect.position, new Vector2(pixelAdjustedRect.width, y) + pixelAdjustedRect.position, color, new Vector2(vector6.x, vector.y), new Vector2(vector.z, vector5.y));
			AddQuad(toFill, new Vector2(0f, num4) + pixelAdjustedRect.position, new Vector2(x, pixelAdjustedRect.height) + pixelAdjustedRect.position, color, new Vector2(vector.x, vector6.y), new Vector2(vector5.x, vector.w));
			AddQuad(toFill, new Vector2(num3, num4) + pixelAdjustedRect.position, new Vector2(pixelAdjustedRect.width, pixelAdjustedRect.height) + pixelAdjustedRect.position, color, new Vector2(vector6.x, vector6.y), new Vector2(vector.z, vector.w));
		}
		else
		{
			Vector2 b = new Vector2((num3 - x) / num, (num4 - y) / num2);
			if (m_FillCenter)
			{
				AddQuad(toFill, new Vector2(x, y) + pixelAdjustedRect.position, new Vector2(num3, num4) + pixelAdjustedRect.position, color, Vector2.Scale(vector5, b), Vector2.Scale(vector6, b));
			}
		}
	}

	private static void AddQuad(VertexHelper vertexHelper, Vector3[] quadPositions, Color32 color, Vector3[] quadUVs)
	{
		int currentVertCount = vertexHelper.currentVertCount;
		for (int i = 0; i < 4; i++)
		{
			vertexHelper.AddVert(quadPositions[i], color, quadUVs[i]);
		}
		vertexHelper.AddTriangle(currentVertCount, currentVertCount + 1, currentVertCount + 2);
		vertexHelper.AddTriangle(currentVertCount + 2, currentVertCount + 3, currentVertCount);
	}

	private static void AddQuad(VertexHelper vertexHelper, Vector2 posMin, Vector2 posMax, Color32 color, Vector2 uvMin, Vector2 uvMax)
	{
		int currentVertCount = vertexHelper.currentVertCount;
		vertexHelper.AddVert(new Vector3(posMin.x, posMin.y, 0f), color, new Vector2(uvMin.x, uvMin.y));
		vertexHelper.AddVert(new Vector3(posMin.x, posMax.y, 0f), color, new Vector2(uvMin.x, uvMax.y));
		vertexHelper.AddVert(new Vector3(posMax.x, posMax.y, 0f), color, new Vector2(uvMax.x, uvMax.y));
		vertexHelper.AddVert(new Vector3(posMax.x, posMin.y, 0f), color, new Vector2(uvMax.x, uvMin.y));
		vertexHelper.AddTriangle(currentVertCount, currentVertCount + 1, currentVertCount + 2);
		vertexHelper.AddTriangle(currentVertCount + 2, currentVertCount + 3, currentVertCount);
	}

	private Vector4 GetAdjustedBorders(Vector4 border, Rect adjustedRect)
	{
		Rect rect = rectTransform.rect;
		for (int i = 0; i <= 1; i++)
		{
			if (rect.size[i] != 0f)
			{
				float num = adjustedRect.size[i] / rect.size[i];
				border[i] *= num;
				border[i + 2] *= num;
			}
			float num2 = border[i] + border[i + 2];
			if (adjustedRect.size[i] < num2 && num2 != 0f)
			{
				float num = adjustedRect.size[i] / num2;
				border[i] *= num;
				border[i + 2] *= num;
			}
		}
		return border;
	}

	private void GenerateFilledSprite(VertexHelper toFill, bool preserveAspect)
	{
		toFill.Clear();
		if (m_FillAmount < 0.001f)
		{
			return;
		}
		Vector4 drawingDimensions = GetDrawingDimensions(preserveAspect);
		Vector4 vector = ((activeSprite != null) ? DataUtility.GetOuterUV(activeSprite) : Vector4.zero);
		UIVertex simpleVert = UIVertex.simpleVert;
		simpleVert.color = color;
		float num = vector.x;
		float num2 = vector.y;
		float num3 = vector.z;
		float num4 = vector.w;
		if (m_FillMethod == FillMethod.Horizontal || m_FillMethod == FillMethod.Vertical)
		{
			if (fillMethod == FillMethod.Horizontal)
			{
				float num5 = (num3 - num) * m_FillAmount;
				if (m_FillOrigin == 1)
				{
					drawingDimensions.x = drawingDimensions.z - (drawingDimensions.z - drawingDimensions.x) * m_FillAmount;
					num = num3 - num5;
				}
				else
				{
					drawingDimensions.z = drawingDimensions.x + (drawingDimensions.z - drawingDimensions.x) * m_FillAmount;
					num3 = num + num5;
				}
			}
			else if (fillMethod == FillMethod.Vertical)
			{
				float num6 = (num4 - num2) * m_FillAmount;
				if (m_FillOrigin == 1)
				{
					drawingDimensions.y = drawingDimensions.w - (drawingDimensions.w - drawingDimensions.y) * m_FillAmount;
					num2 = num4 - num6;
				}
				else
				{
					drawingDimensions.w = drawingDimensions.y + (drawingDimensions.w - drawingDimensions.y) * m_FillAmount;
					num4 = num2 + num6;
				}
			}
		}
		s_Xy[0] = new Vector2(drawingDimensions.x, drawingDimensions.y);
		s_Xy[1] = new Vector2(drawingDimensions.x, drawingDimensions.w);
		s_Xy[2] = new Vector2(drawingDimensions.z, drawingDimensions.w);
		s_Xy[3] = new Vector2(drawingDimensions.z, drawingDimensions.y);
		s_Uv[0] = new Vector2(num, num2);
		s_Uv[1] = new Vector2(num, num4);
		s_Uv[2] = new Vector2(num3, num4);
		s_Uv[3] = new Vector2(num3, num2);
		if (m_FillAmount < 1f && m_FillMethod != FillMethod.Horizontal && m_FillMethod != FillMethod.Vertical)
		{
			if (fillMethod == FillMethod.Radial90)
			{
				if (RadialCut(s_Xy, s_Uv, m_FillAmount, m_FillClockwise, m_FillOrigin))
				{
					AddQuad(toFill, s_Xy, color, s_Uv);
				}
			}
			else if (fillMethod == FillMethod.Radial180)
			{
				for (int i = 0; i < 2; i++)
				{
					int num7 = ((m_FillOrigin > 1) ? 1 : 0);
					float t;
					float t2;
					float t3;
					float t4;
					if (m_FillOrigin == 0 || m_FillOrigin == 2)
					{
						t = 0f;
						t2 = 1f;
						if (i == num7)
						{
							t3 = 0f;
							t4 = 0.5f;
						}
						else
						{
							t3 = 0.5f;
							t4 = 1f;
						}
					}
					else
					{
						t3 = 0f;
						t4 = 1f;
						if (i == num7)
						{
							t = 0.5f;
							t2 = 1f;
						}
						else
						{
							t = 0f;
							t2 = 0.5f;
						}
					}
					s_Xy[0].x = Mathf.Lerp(drawingDimensions.x, drawingDimensions.z, t3);
					s_Xy[1].x = s_Xy[0].x;
					s_Xy[2].x = Mathf.Lerp(drawingDimensions.x, drawingDimensions.z, t4);
					s_Xy[3].x = s_Xy[2].x;
					s_Xy[0].y = Mathf.Lerp(drawingDimensions.y, drawingDimensions.w, t);
					s_Xy[1].y = Mathf.Lerp(drawingDimensions.y, drawingDimensions.w, t2);
					s_Xy[2].y = s_Xy[1].y;
					s_Xy[3].y = s_Xy[0].y;
					s_Uv[0].x = Mathf.Lerp(num, num3, t3);
					s_Uv[1].x = s_Uv[0].x;
					s_Uv[2].x = Mathf.Lerp(num, num3, t4);
					s_Uv[3].x = s_Uv[2].x;
					s_Uv[0].y = Mathf.Lerp(num2, num4, t);
					s_Uv[1].y = Mathf.Lerp(num2, num4, t2);
					s_Uv[2].y = s_Uv[1].y;
					s_Uv[3].y = s_Uv[0].y;
					float value = (m_FillClockwise ? (fillAmount * 2f - (float)i) : (m_FillAmount * 2f - (float)(1 - i)));
					if (RadialCut(s_Xy, s_Uv, Mathf.Clamp01(value), m_FillClockwise, (i + m_FillOrigin + 3) % 4))
					{
						AddQuad(toFill, s_Xy, color, s_Uv);
					}
				}
			}
			else
			{
				if (fillMethod != FillMethod.Radial360)
				{
					return;
				}
				for (int j = 0; j < 4; j++)
				{
					float t5;
					float t6;
					if (j < 2)
					{
						t5 = 0f;
						t6 = 0.5f;
					}
					else
					{
						t5 = 0.5f;
						t6 = 1f;
					}
					float t7;
					float t8;
					if (j == 0 || j == 3)
					{
						t7 = 0f;
						t8 = 0.5f;
					}
					else
					{
						t7 = 0.5f;
						t8 = 1f;
					}
					s_Xy[0].x = Mathf.Lerp(drawingDimensions.x, drawingDimensions.z, t5);
					s_Xy[1].x = s_Xy[0].x;
					s_Xy[2].x = Mathf.Lerp(drawingDimensions.x, drawingDimensions.z, t6);
					s_Xy[3].x = s_Xy[2].x;
					s_Xy[0].y = Mathf.Lerp(drawingDimensions.y, drawingDimensions.w, t7);
					s_Xy[1].y = Mathf.Lerp(drawingDimensions.y, drawingDimensions.w, t8);
					s_Xy[2].y = s_Xy[1].y;
					s_Xy[3].y = s_Xy[0].y;
					s_Uv[0].x = Mathf.Lerp(num, num3, t5);
					s_Uv[1].x = s_Uv[0].x;
					s_Uv[2].x = Mathf.Lerp(num, num3, t6);
					s_Uv[3].x = s_Uv[2].x;
					s_Uv[0].y = Mathf.Lerp(num2, num4, t7);
					s_Uv[1].y = Mathf.Lerp(num2, num4, t8);
					s_Uv[2].y = s_Uv[1].y;
					s_Uv[3].y = s_Uv[0].y;
					float value2 = (m_FillClockwise ? (m_FillAmount * 4f - (float)((j + m_FillOrigin) % 4)) : (m_FillAmount * 4f - (float)(3 - (j + m_FillOrigin) % 4)));
					if (RadialCut(s_Xy, s_Uv, Mathf.Clamp01(value2), m_FillClockwise, (j + 2) % 4))
					{
						AddQuad(toFill, s_Xy, color, s_Uv);
					}
				}
			}
		}
		else
		{
			AddQuad(toFill, s_Xy, color, s_Uv);
		}
	}

	private static bool RadialCut(Vector3[] xy, Vector3[] uv, float fill, bool invert, int corner)
	{
		if (fill < 0.001f)
		{
			return false;
		}
		if ((corner & 1) == 1)
		{
			invert = !invert;
		}
		if (!invert && fill > 0.999f)
		{
			return true;
		}
		float num = Mathf.Clamp01(fill);
		if (invert)
		{
			num = 1f - num;
		}
		num *= MathF.PI / 2f;
		float cos = Mathf.Cos(num);
		float sin = Mathf.Sin(num);
		RadialCut(xy, cos, sin, invert, corner);
		RadialCut(uv, cos, sin, invert, corner);
		return true;
	}

	private static void RadialCut(Vector3[] xy, float cos, float sin, bool invert, int corner)
	{
		int num = (corner + 1) % 4;
		int num2 = (corner + 2) % 4;
		int num3 = (corner + 3) % 4;
		if ((corner & 1) == 1)
		{
			if (sin > cos)
			{
				cos /= sin;
				sin = 1f;
				if (invert)
				{
					xy[num].x = Mathf.Lerp(xy[corner].x, xy[num2].x, cos);
					xy[num2].x = xy[num].x;
				}
			}
			else if (cos > sin)
			{
				sin /= cos;
				cos = 1f;
				if (!invert)
				{
					xy[num2].y = Mathf.Lerp(xy[corner].y, xy[num2].y, sin);
					xy[num3].y = xy[num2].y;
				}
			}
			else
			{
				cos = 1f;
				sin = 1f;
			}
			if (!invert)
			{
				xy[num3].x = Mathf.Lerp(xy[corner].x, xy[num2].x, cos);
			}
			else
			{
				xy[num].y = Mathf.Lerp(xy[corner].y, xy[num2].y, sin);
			}
			return;
		}
		if (cos > sin)
		{
			sin /= cos;
			cos = 1f;
			if (!invert)
			{
				xy[num].y = Mathf.Lerp(xy[corner].y, xy[num2].y, sin);
				xy[num2].y = xy[num].y;
			}
		}
		else if (sin > cos)
		{
			cos /= sin;
			sin = 1f;
			if (invert)
			{
				xy[num2].x = Mathf.Lerp(xy[corner].x, xy[num2].x, cos);
				xy[num3].x = xy[num2].x;
			}
		}
		else
		{
			cos = 1f;
			sin = 1f;
		}
		if (invert)
		{
			xy[num3].y = Mathf.Lerp(xy[corner].y, xy[num2].y, sin);
		}
		else
		{
			xy[num].x = Mathf.Lerp(xy[corner].x, xy[num2].x, cos);
		}
	}

	public virtual void CalculateLayoutInputHorizontal()
	{
	}

	public virtual void CalculateLayoutInputVertical()
	{
	}

	public virtual bool IsRaycastLocationValid(Vector2 screenPoint, Camera eventCamera)
	{
		if (m_UseRedChannelHitTest)
		{
			return IsRedChannelHitTestValid(screenPoint, eventCamera);
		}
		if (alphaHitTestMinimumThreshold <= 0f)
		{
			return true;
		}
		if (alphaHitTestMinimumThreshold > 1f)
		{
			return false;
		}
		if (activeSprite == null)
		{
			return true;
		}
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, eventCamera, out var localPoint))
		{
			return false;
		}
		Rect rect = GetPixelAdjustedRect();
		if (m_PreserveAspect)
		{
			PreserveSpriteAspectRatio(ref rect, new Vector2(activeSprite.texture.width, activeSprite.texture.height));
		}
		localPoint.x += rectTransform.pivot.x * rect.width;
		localPoint.y += rectTransform.pivot.y * rect.height;
		localPoint = MapCoordinate(localPoint, rect);
		float u = localPoint.x / (float)activeSprite.texture.width;
		float v = localPoint.y / (float)activeSprite.texture.height;
		try
		{
			return activeSprite.texture.GetPixelBilinear(u, v).a >= alphaHitTestMinimumThreshold;
		}
		catch (UnityException ex)
		{
			Debug.LogError("Using alphaHitTestMinimumThreshold greater than 0 on Image whose sprite texture cannot be read. " + ex.Message + " Also make sure to disable sprite packing for this sprite.", this);
			return true;
		}
	}

	private bool IsRedChannelHitTestValid(Vector2 screenPoint, Camera eventCamera)
	{
		Texture2D texture = m_RedChannelMaskTexture;
		if (texture == null)
		{
			if (activeSprite == null || activeSprite.texture == null)
			{
				return true;
			}
			texture = activeSprite.texture;
		}
		if (!texture.isReadable)
		{
			Debug.LogWarning("[Image] R通道射线检测需要纹理开启Read/Write Enabled: " + texture.name, this);
			return true;
		}
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, eventCamera, out var localPoint))
		{
			return false;
		}
		Rect rect = GetPixelAdjustedRect();
		if (m_PreserveAspect && activeSprite != null)
		{
			PreserveSpriteAspectRatio(ref rect, new Vector2(activeSprite.texture.width, activeSprite.texture.height));
		}
		localPoint.x += rectTransform.pivot.x * rect.width;
		localPoint.y += rectTransform.pivot.y * rect.height;
		float value;
		float value2;
		if (m_RedChannelMaskTexture != null)
		{
			value = localPoint.x / rect.width;
			value2 = localPoint.y / rect.height;
		}
		else
		{
			if (!(activeSprite != null))
			{
				return true;
			}
			localPoint = MapCoordinate(localPoint, rect);
			value = localPoint.x / (float)texture.width;
			value2 = localPoint.y / (float)texture.height;
		}
		value = Mathf.Clamp01(value);
		value2 = Mathf.Clamp01(value2);
		try
		{
			float r = texture.GetPixelBilinear(value, value2).r;
			if (m_RedChannelInvert)
			{
				return r < m_RedChannelHitTestMinimumThreshold;
			}
			return r >= m_RedChannelHitTestMinimumThreshold;
		}
		catch (UnityException ex)
		{
			Debug.LogError("[Image] R通道射线检测失败，纹理可能不可读: " + ex.Message, this);
			return true;
		}
	}

	private Vector2 MapCoordinate(Vector2 local, Rect rect)
	{
		Rect rect2 = activeSprite.rect;
		if (type == Type.Simple || type == Type.Filled)
		{
			return new Vector2(rect2.position.x + local.x * rect2.width / rect.width, rect2.position.y + local.y * rect2.height / rect.height);
		}
		Vector4 border = activeSprite.border;
		Vector4 adjustedBorders = GetAdjustedBorders(border / pixelsPerUnit, rect);
		for (int i = 0; i < 2; i++)
		{
			if (!(local[i] <= adjustedBorders[i]))
			{
				if (rect.size[i] - local[i] <= adjustedBorders[i + 2])
				{
					local[i] -= rect.size[i] - rect2.size[i];
				}
				else if (type == Type.Sliced)
				{
					float t = Mathf.InverseLerp(adjustedBorders[i], rect.size[i] - adjustedBorders[i + 2], local[i]);
					local[i] = Mathf.Lerp(border[i], rect2.size[i] - border[i + 2], t);
				}
				else
				{
					local[i] -= adjustedBorders[i];
					local[i] = Mathf.Repeat(local[i], rect2.size[i] - border[i] - border[i + 2]);
					local[i] += border[i];
				}
			}
		}
		return local + rect2.position;
	}

	private static void RebuildImage(SpriteAtlas spriteAtlas)
	{
		for (int num = m_TrackedTexturelessImages.Count - 1; num >= 0; num--)
		{
			Image image = m_TrackedTexturelessImages[num];
			if (null != image.activeSprite && spriteAtlas.CanBindTo(image.activeSprite))
			{
				image.SetAllDirty();
				m_TrackedTexturelessImages.RemoveAt(num);
			}
		}
	}

	private static void TrackImage(Image g)
	{
		if (!s_Initialized)
		{
			SpriteAtlasManager.atlasRegistered += RebuildImage;
			s_Initialized = true;
		}
		m_TrackedTexturelessImages.Add(g);
	}

	private static void UnTrackImage(Image g)
	{
		m_TrackedTexturelessImages.Remove(g);
	}

	protected override void OnDidApplyAnimationProperties()
	{
		SetMaterialDirty();
		SetVerticesDirty();
		SetRaycastDirty();
	}

	private void GenerateSlicedAndFilledSprite(VertexHelper toFill)
	{
		if (!hasBorder)
		{
			GenerateFilledSprite(toFill, preserveAspect: false);
			return;
		}
		Vector4 vector;
		Vector4 vector2;
		Vector4 vector3;
		Vector4 vector4;
		if (activeSprite != null)
		{
			vector = DataUtility.GetOuterUV(activeSprite);
			vector2 = DataUtility.GetInnerUV(activeSprite);
			vector3 = DataUtility.GetPadding(activeSprite);
			vector4 = activeSprite.border;
		}
		else
		{
			vector = Vector4.zero;
			vector2 = Vector4.zero;
			vector3 = Vector4.zero;
			vector4 = Vector4.zero;
		}
		Rect pixelAdjustedRect = GetPixelAdjustedRect();
		Vector4 adjustedBorders = GetAdjustedBorders(vector4 / multipliedPixelsPerUnit, pixelAdjustedRect);
		vector3 /= multipliedPixelsPerUnit;
		s_VertScratch[0] = new Vector2(vector3.x, vector3.y);
		s_VertScratch[3] = new Vector2(pixelAdjustedRect.width - vector3.z, pixelAdjustedRect.height - vector3.w);
		s_VertScratch[1].x = adjustedBorders.x;
		s_VertScratch[1].y = adjustedBorders.y;
		s_VertScratch[2].x = pixelAdjustedRect.width - adjustedBorders.z;
		s_VertScratch[2].y = pixelAdjustedRect.height - adjustedBorders.w;
		for (int i = 0; i < 4; i++)
		{
			s_VertScratch[i].x += pixelAdjustedRect.x;
			s_VertScratch[i].y += pixelAdjustedRect.y;
		}
		s_UVScratch[0] = new Vector2(vector.x, vector.y);
		s_UVScratch[1] = new Vector2(vector2.x, vector2.y);
		s_UVScratch[2] = new Vector2(vector2.z, vector2.w);
		s_UVScratch[3] = new Vector2(vector.z, vector.w);
		toFill.Clear();
		if (m_FillMethod == FillMethod.Radial90 || m_FillMethod == FillMethod.Radial180 || m_FillMethod == FillMethod.Radial360)
		{
			for (int j = 0; j < 3; j++)
			{
				int num = j + 1;
				for (int k = 0; k < 3; k++)
				{
					if (m_FillCenter || j != 1 || k != 1)
					{
						int num2 = k + 1;
						Vector2 vector5 = new Vector2(s_VertScratch[j].x, s_VertScratch[k].y);
						Vector2 vector6 = new Vector2(s_VertScratch[num].x, s_VertScratch[num2].y);
						Vector2 vector7 = new Vector2(Mathf.Lerp(s_UVScratch[j].x, s_UVScratch[num].x, 0f), Mathf.Lerp(s_UVScratch[k].y, s_UVScratch[num2].y, 0f));
						Vector2 vector8 = new Vector2(Mathf.Lerp(s_UVScratch[j].x, s_UVScratch[num].x, 1f), Mathf.Lerp(s_UVScratch[k].y, s_UVScratch[num2].y, 1f));
						Vector3[] array = new Vector3[4]
						{
							new Vector3(vector5.x, vector5.y, 0f),
							new Vector3(vector5.x, vector6.y, 0f),
							new Vector3(vector6.x, vector6.y, 0f),
							new Vector3(vector6.x, vector5.y, 0f)
						};
						Vector3[] array2 = new Vector3[4]
						{
							new Vector3(vector7.x, vector7.y, 0f),
							new Vector3(vector7.x, vector8.y, 0f),
							new Vector3(vector8.x, vector8.y, 0f),
							new Vector3(vector8.x, vector7.y, 0f)
						};
						if (RadialCut(array, array2, fillAmount, m_FillClockwise, m_FillOrigin))
						{
							AddQuad(toFill, array, color, array2);
						}
					}
				}
			}
		}
		else if (m_FillMethod == FillMethod.Horizontal)
		{
			float num3 = fillAmount;
			float x = s_VertScratch[0].x;
			float x2 = s_VertScratch[3].x;
			if (m_FillOrigin == 1)
			{
				float num4 = x2 - (x2 - x) * num3;
				for (int l = 0; l < 4; l++)
				{
					if (s_VertScratch[l].x < num4)
					{
						s_VertScratch[l].x = num4;
					}
				}
				float t = Mathf.Clamp01(num3);
				s_UVScratch[0].x = Mathf.Lerp(s_UVScratch[3].x, s_UVScratch[0].x, t);
				s_UVScratch[1].x = Mathf.Lerp(s_UVScratch[2].x, s_UVScratch[1].x, t);
			}
			else
			{
				float num5 = x + (x2 - x) * num3;
				for (int m = 0; m < 4; m++)
				{
					if (s_VertScratch[m].x > num5)
					{
						s_VertScratch[m].x = num5;
					}
				}
				float t2 = Mathf.Clamp01(num3);
				s_UVScratch[3].x = Mathf.Lerp(s_UVScratch[0].x, s_UVScratch[3].x, t2);
				s_UVScratch[2].x = Mathf.Lerp(s_UVScratch[1].x, s_UVScratch[2].x, t2);
			}
			for (int n = 0; n < 3; n++)
			{
				int num6 = n + 1;
				for (int num7 = 0; num7 < 3; num7++)
				{
					if (m_FillCenter || n != 1 || num7 != 1)
					{
						int num8 = num7 + 1;
						AddQuad(posMin: new Vector2(s_VertScratch[n].x, s_VertScratch[num7].y), posMax: new Vector2(s_VertScratch[num6].x, s_VertScratch[num8].y), uvMin: new Vector2(s_UVScratch[n].x, s_UVScratch[num7].y), uvMax: new Vector2(s_UVScratch[num6].x, s_UVScratch[num8].y), vertexHelper: toFill, color: color);
					}
				}
			}
		}
		else
		{
			if (m_FillMethod != FillMethod.Vertical)
			{
				return;
			}
			float num9 = fillAmount;
			float y = s_VertScratch[0].y;
			float y2 = s_VertScratch[3].y;
			if (m_FillOrigin == 1)
			{
				float num10 = y2 - (y2 - y) * num9;
				for (int num11 = 0; num11 < 4; num11++)
				{
					if (s_VertScratch[num11].y < num10)
					{
						s_VertScratch[num11].y = num10;
					}
				}
				float t3 = Mathf.Clamp01(num9);
				s_UVScratch[0].y = Mathf.Lerp(s_UVScratch[3].y, s_UVScratch[0].y, t3);
				s_UVScratch[1].y = Mathf.Lerp(s_UVScratch[2].y, s_UVScratch[1].y, t3);
			}
			else
			{
				float num12 = y + (y2 - y) * num9;
				for (int num13 = 0; num13 < 4; num13++)
				{
					if (s_VertScratch[num13].y > num12)
					{
						s_VertScratch[num13].y = num12;
					}
				}
				float t4 = Mathf.Clamp01(num9);
				s_UVScratch[3].y = Mathf.Lerp(s_UVScratch[0].y, s_UVScratch[3].y, t4);
				s_UVScratch[2].y = Mathf.Lerp(s_UVScratch[1].y, s_UVScratch[2].y, t4);
			}
			for (int num14 = 0; num14 < 3; num14++)
			{
				int num15 = num14 + 1;
				for (int num16 = 0; num16 < 3; num16++)
				{
					if (m_FillCenter || num14 != 1 || num16 != 1)
					{
						int num17 = num16 + 1;
						AddQuad(posMin: new Vector2(s_VertScratch[num14].x, s_VertScratch[num16].y), posMax: new Vector2(s_VertScratch[num15].x, s_VertScratch[num17].y), uvMin: new Vector2(s_UVScratch[num14].x, s_UVScratch[num16].y), uvMax: new Vector2(s_UVScratch[num15].x, s_UVScratch[num17].y), vertexHelper: toFill, color: color);
					}
				}
			}
		}
	}
}
