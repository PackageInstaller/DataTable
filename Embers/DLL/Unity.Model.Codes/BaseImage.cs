using System;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class BaseImage : MaskableGraphic, ISerializationCallbackReceiver, ILayoutElement, ICanvasRaycastFilter
{
	[FormerlySerializedAs("m_Frame")]
	[SerializeField]
	private Sprite m_Sprite;

	[NonSerialized]
	private Sprite m_OverrideSprite;

	public Sprite sprite
	{
		get
		{
			return m_Sprite;
		}
		set
		{
			if (SetPropertyUtilityExt.SetClass(ref m_Sprite, value))
			{
				SetAllDirty();
			}
		}
	}

	public Sprite overrideSprite
	{
		get
		{
			if (!(m_OverrideSprite == null))
			{
				return m_OverrideSprite;
			}
			return sprite;
		}
		set
		{
			if (SetPropertyUtilityExt.SetClass(ref m_OverrideSprite, value))
			{
				SetAllDirty();
			}
		}
	}

	public override Texture mainTexture
	{
		get
		{
			if (!(overrideSprite == null))
			{
				return overrideSprite.texture;
			}
			return Graphic.s_WhiteTexture;
		}
	}

	public float pixelsPerUnit
	{
		get
		{
			float num = 100f;
			if ((bool)sprite)
			{
				num = sprite.pixelsPerUnit;
			}
			float num2 = 100f;
			if ((bool)(UnityEngine.Object)(object)base.canvas)
			{
				num2 = base.canvas.referencePixelsPerUnit;
			}
			return num / num2;
		}
	}

	public virtual float minWidth => 0f;

	public virtual float preferredWidth
	{
		get
		{
			if (overrideSprite == null)
			{
				return 0f;
			}
			return overrideSprite.rect.size.x / pixelsPerUnit;
		}
	}

	public virtual float flexibleWidth => -1f;

	public virtual float minHeight => 0f;

	public virtual float preferredHeight
	{
		get
		{
			if (overrideSprite == null)
			{
				return 0f;
			}
			return overrideSprite.rect.size.y / pixelsPerUnit;
		}
	}

	public virtual float flexibleHeight => -1f;

	public virtual int layoutPriority => 0;

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		base.OnPopulateMesh(vh);
	}

	public void OnAfterDeserialize()
	{
	}

	public void OnBeforeSerialize()
	{
	}

	public virtual void CalculateLayoutInputHorizontal()
	{
	}

	public virtual void CalculateLayoutInputVertical()
	{
	}

	public virtual bool IsRaycastLocationValid(Vector2 screenPoint, Camera eventCamera)
	{
		return true;
	}
}
