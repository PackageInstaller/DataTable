using UnityEngine;
using UnityEngine.UI;

public class AdventureBlobIndicator : Graphic
{
	protected RectTransform _rectTransform;

	[Space]
	[SerializeField]
	protected Sprite _blobSprite;

	protected UIVertex _uiVert;

	public Sprite blobSprite
	{
		get
		{
			return _blobSprite;
		}
		set
		{
			if (_blobSprite != null)
			{
				if (_blobSprite != value)
				{
					m_SkipMaterialUpdate = _blobSprite.texture == (value ? value.texture : null);
					_blobSprite = value;
					SetMaterialDirty();
					SetVerticesDirty();
				}
			}
			else if (value != null)
			{
				m_SkipMaterialUpdate = value.texture == null;
				_blobSprite = value;
				SetMaterialDirty();
				SetVerticesDirty();
			}
		}
	}

	public override Texture mainTexture
	{
		get
		{
			if (_blobSprite == null)
			{
				if (material != null && material.mainTexture != null)
				{
					return material.mainTexture;
				}
				return Graphic.s_WhiteTexture;
			}
			return _blobSprite.texture;
		}
	}

	public override Material material
	{
		get
		{
			if (m_Material != null)
			{
				return m_Material;
			}
			if ((bool)_blobSprite && _blobSprite.associatedAlphaSplitTexture != null)
			{
				return Image.defaultETC1GraphicMaterial;
			}
			return defaultMaterial;
		}
		set
		{
			base.material = value;
		}
	}

	protected override void Start()
	{
		_rectTransform = GetComponent<RectTransform>();
	}

	protected AdventureBlobIndicator()
	{
		useLegacyMeshGeneration = false;
	}

	protected int DrawBlobPolygon(VertexHelper vh, Vector3 blobCenterPos, float blobRot, Vector2 blobSize, Color blobColor, Vector4 blobUV, int vertOffset)
	{
		Vector2 vector = new Vector2(blobCenterPos.x - blobSize.x * 0.5f, blobCenterPos.y - blobSize.y * 0.5f);
		Vector2 vector2 = new Vector2(blobCenterPos.x + blobSize.x * 0.5f, blobCenterPos.y + blobSize.y * 0.5f);
		Vector3 vector3 = new Vector3(vector.x, vector.y, blobCenterPos.z);
		Vector3 vector4 = new Vector3(vector.x, vector2.y, blobCenterPos.z);
		Vector3 vector5 = new Vector3(vector2.x, vector2.y, blobCenterPos.z);
		Vector3 vector6 = new Vector3(vector2.x, vector.y, blobCenterPos.z);
		if (blobRot != 0f)
		{
			Vector3 vector7 = new Vector3(blobCenterPos.x, blobCenterPos.y, blobCenterPos.z);
			vector3 -= vector7;
			vector4 -= vector7;
			vector5 -= vector7;
			vector6 -= vector7;
			Quaternion quaternion = Quaternion.AngleAxis(blobRot, new Vector3(0f, 0f, -1f));
			vector3 = quaternion * vector3;
			vector4 = quaternion * vector4;
			vector5 = quaternion * vector5;
			vector6 = quaternion * vector6;
			vector3 += vector7;
			vector4 += vector7;
			vector5 += vector7;
			vector6 += vector7;
		}
		_uiVert.position = vector3;
		_uiVert.color = blobColor;
		_uiVert.uv0 = new Vector2(blobUV.x, blobUV.y);
		vh.AddVert(_uiVert);
		_uiVert.position = vector4;
		_uiVert.color = blobColor;
		_uiVert.uv0 = new Vector2(blobUV.x, blobUV.w);
		vh.AddVert(_uiVert);
		_uiVert.position = vector5;
		_uiVert.color = blobColor;
		_uiVert.uv0 = new Vector2(blobUV.z, blobUV.w);
		vh.AddVert(_uiVert);
		_uiVert.position = vector6;
		_uiVert.color = blobColor;
		_uiVert.uv0 = new Vector2(blobUV.z, blobUV.y);
		vh.AddVert(_uiVert);
		vh.AddTriangle(vertOffset, vertOffset + 1, vertOffset + 2);
		vh.AddTriangle(vertOffset + 2, vertOffset + 3, vertOffset);
		return 4;
	}
}
