using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(PolygonCollider2D))]
public class UIPolygon : Image
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

	protected UIPolygon()
	{
		base.useLegacyMeshGeneration = true;
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
	}

	public override bool IsRaycastLocationValid(Vector2 screenPoint, Camera eventCamera)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform.GetComponent<RectTransform>(), screenPoint, eventCamera, out var localPoint);
		return ContainsPoint2(polygon.points, localPoint);
	}

	private bool ContainsPoint2(Vector2[] polyPoints, Vector2 p)
	{
		int num = 0;
		int num2 = polyPoints.Length;
		for (int i = 0; i < num2; i++)
		{
			Vector2 vector = polyPoints[i];
			Vector2 vector2 = polyPoints[(i + 1) % num2];
			if (vector.y != vector2.y && !(p.y < Mathf.Min(vector.y, vector2.y)) && !(p.y >= Mathf.Max(vector.y, vector2.y)) && (double)(p.y - vector.y) * (double)(vector2.x - vector.x) / (double)(vector2.y - vector.y) + (double)vector.x > (double)p.x)
			{
				num++;
			}
		}
		return num % 2 == 1;
	}
}
