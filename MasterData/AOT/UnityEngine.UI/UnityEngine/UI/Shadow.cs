using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Effects/Shadow", 80)]
public class Shadow : BaseMeshEffect
{
	[SerializeField]
	private Color m_EffectColor = new Color(0f, 0f, 0f, 0.5f);

	[SerializeField]
	private Vector2 m_EffectDistance = new Vector2(1f, -1f);

	[SerializeField]
	private bool m_UseGraphicAlpha = true;

	private const float kMaxEffectDistance = 600f;

	public Color effectColor
	{
		get
		{
			return m_EffectColor;
		}
		set
		{
			m_EffectColor = value;
			if (graphic != null)
			{
				graphic.SetVerticesDirty();
			}
		}
	}

	public Vector2 effectDistance
	{
		get
		{
			return m_EffectDistance;
		}
		set
		{
			if (value.x > 600f)
			{
				value.x = 600f;
			}
			if (value.x < -600f)
			{
				value.x = -600f;
			}
			if (value.y > 600f)
			{
				value.y = 600f;
			}
			if (value.y < -600f)
			{
				value.y = -600f;
			}
			if (!(m_EffectDistance == value))
			{
				m_EffectDistance = value;
				if (graphic != null)
				{
					graphic.SetVerticesDirty();
				}
			}
		}
	}

	public bool useGraphicAlpha
	{
		get
		{
			return m_UseGraphicAlpha;
		}
		set
		{
			m_UseGraphicAlpha = value;
			if (graphic != null)
			{
				graphic.SetVerticesDirty();
			}
		}
	}

	protected Shadow()
	{
	}

	protected void ApplyShadowZeroAlloc(List<UIVertex> verts, Color32 color, int start, int end, float x, float y)
	{
		int num = verts.Count + end - start;
		if (verts.Capacity < num)
		{
			verts.Capacity = num;
		}
		for (int i = start; i < end; i++)
		{
			UIVertex uIVertex = verts[i];
			verts.Add(uIVertex);
			Vector3 position = uIVertex.position;
			position.x += x;
			position.y += y;
			uIVertex.position = position;
			Color32 color2 = color;
			if (m_UseGraphicAlpha)
			{
				color2.a = (byte)(color2.a * verts[i].color.a / 255);
			}
			uIVertex.color = color2;
			verts[i] = uIVertex;
		}
	}

	protected void ApplyShadow(List<UIVertex> verts, Color32 color, int start, int end, float x, float y)
	{
		ApplyShadowZeroAlloc(verts, color, start, end, x, y);
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		if (IsActive())
		{
			List<UIVertex> list = CollectionPool<List<UIVertex>, UIVertex>.Get();
			vh.GetUIVertexStream(list);
			ApplyShadow(list, effectColor, 0, list.Count, effectDistance.x, effectDistance.y);
			vh.Clear();
			vh.AddUIVertexTriangleStream(list);
			CollectionPool<List<UIVertex>, UIVertex>.Release(list);
		}
	}
}
