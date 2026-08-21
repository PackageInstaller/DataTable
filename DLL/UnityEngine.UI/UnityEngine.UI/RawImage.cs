using UnityEngine.Serialization;

namespace UnityEngine.UI;

[RequireComponent(typeof(CanvasRenderer))]
[AddComponentMenu("UI/Raw Image", 12)]
public class RawImage : MaskableGraphic
{
	[SerializeField]
	[FormerlySerializedAs("m_Tex")]
	private Texture m_Texture;

	[SerializeField]
	private Rect m_UVRect = new Rect(0f, 0f, 1f, 1f);

	public override Texture mainTexture
	{
		get
		{
			if (m_Texture == null)
			{
				if (material != null && material.mainTexture != null)
				{
					return material.mainTexture;
				}
				return Graphic.s_WhiteTexture;
			}
			return m_Texture;
		}
	}

	public Texture texture
	{
		get
		{
			return m_Texture;
		}
		set
		{
			if (!(m_Texture == value))
			{
				m_Texture = value;
				SetVerticesDirty();
				SetMaterialDirty();
			}
		}
	}

	public Rect uvRect
	{
		get
		{
			return m_UVRect;
		}
		set
		{
			if (!(m_UVRect == value))
			{
				m_UVRect = value;
				SetVerticesDirty();
			}
		}
	}

	protected RawImage()
	{
		base.useLegacyMeshGeneration = false;
	}

	public override void SetNativeSize()
	{
		Texture texture = mainTexture;
		if (texture != null)
		{
			int num = Mathf.RoundToInt((float)texture.width * uvRect.width);
			int num2 = Mathf.RoundToInt((float)texture.height * uvRect.height);
			base.rectTransform.anchorMax = base.rectTransform.anchorMin;
			base.rectTransform.sizeDelta = new Vector2(num, num2);
		}
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		Texture texture = mainTexture;
		vh.Clear();
		if (texture != null)
		{
			Rect pixelAdjustedRect = GetPixelAdjustedRect();
			Vector4 vector = new Vector4(pixelAdjustedRect.x, pixelAdjustedRect.y, pixelAdjustedRect.x + pixelAdjustedRect.width, pixelAdjustedRect.y + pixelAdjustedRect.height);
			float num = (float)texture.width * texture.texelSize.x;
			float num2 = (float)texture.height * texture.texelSize.y;
			Color color = this.color;
			vh.AddVert(new Vector3(vector.x, vector.y), color, new Vector2(m_UVRect.xMin * num, m_UVRect.yMin * num2));
			vh.AddVert(new Vector3(vector.x, vector.w), color, new Vector2(m_UVRect.xMin * num, m_UVRect.yMax * num2));
			vh.AddVert(new Vector3(vector.z, vector.w), color, new Vector2(m_UVRect.xMax * num, m_UVRect.yMax * num2));
			vh.AddVert(new Vector3(vector.z, vector.y), color, new Vector2(m_UVRect.xMax * num, m_UVRect.yMin * num2));
			vh.AddTriangle(0, 1, 2);
			vh.AddTriangle(2, 3, 0);
		}
	}

	protected override void OnDidApplyAnimationProperties()
	{
		SetMaterialDirty();
		SetVerticesDirty();
		SetRaycastDirty();
	}
}
