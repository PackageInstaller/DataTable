using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(PolygonCollider2D))]
public class PolygonRaycast : MaskableGraphic, ICanvasRaycastFilter
{
	private PolygonCollider2D _polygon;

	private PolygonCollider2D polygon
	{
		get
		{
			if (_polygon == null)
			{
				_polygon = GetComponent<PolygonCollider2D>();
			}
			return _polygon;
		}
	}

	protected PolygonRaycast()
	{
		useLegacyMeshGeneration = true;
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
	}

	public bool IsRaycastLocationValid(Vector2 screenPoint, Camera eventCamera)
	{
		RectTransformUtility.ScreenPointToWorldPointInRectangle(rectTransform, screenPoint, eventCamera, out var worldPoint);
		return polygon.OverlapPoint(worldPoint);
	}
}
