using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

public class ScreenRect : IReference
{
	private Rect _rect;

	private List<Line> _lineList;

	public Rect Rect => _rect;

	public void InitRect(float width, float height, float gazeScopeX, float gazeScopeY)
	{
		_rect = new Rect(new Vector2((width - width * gazeScopeX) / 2f, (height - height * gazeScopeY) / 2f), new Vector2(width * gazeScopeX, height * gazeScopeY));
		Line item = new Line(new Vector3(_rect.xMin, _rect.yMin, 0f), new Vector3(_rect.xMin, _rect.yMax, 0f));
		Line item2 = new Line(new Vector3(_rect.xMin, _rect.yMax, 0f), new Vector3(_rect.xMax, _rect.yMax, 0f));
		Line item3 = new Line(new Vector3(_rect.xMax, _rect.yMax, 0f), new Vector3(_rect.xMax, _rect.yMin, 0f));
		Line item4 = new Line(new Vector3(_rect.xMax, _rect.yMin, 0f), new Vector3(_rect.xMin, _rect.yMin, 0f));
		_lineList = CollectionPool<List<Line>, Line>.Get();
		_lineList.Add(item);
		_lineList.Add(item2);
		_lineList.Add(item3);
		_lineList.Add(item4);
	}

	public void UpdateData(float width, float height, float gazeScopeX, float gazeScopeY)
	{
		_rect = new Rect(new Vector2((width - width * gazeScopeX) / 2f, (height - height * gazeScopeY) / 2f), new Vector2(width * gazeScopeX, height * gazeScopeY));
		Line item = new Line(new Vector3(_rect.xMin, _rect.yMin, 0f), new Vector3(_rect.xMin, _rect.yMax, 0f));
		Line item2 = new Line(new Vector3(_rect.xMin, _rect.yMax, 0f), new Vector3(_rect.xMax, _rect.yMax, 0f));
		Line item3 = new Line(new Vector3(_rect.xMax, _rect.yMax, 0f), new Vector3(_rect.xMax, _rect.yMin, 0f));
		Line item4 = new Line(new Vector3(_rect.xMax, _rect.yMin, 0f), new Vector3(_rect.xMin, _rect.yMin, 0f));
		_lineList.Clear();
		_lineList.Add(item);
		_lineList.Add(item2);
		_lineList.Add(item3);
		_lineList.Add(item4);
	}

	public bool RectLineIsSegments(Line line, out Vector2 intersectionPoint)
	{
		intersectionPoint = Vector2.zero;
		for (int i = 0; i < _lineList.Count; i++)
		{
			Line line2 = _lineList[i];
			if (Intersect.IsSegmentsIntersect(line2.StartPoint, line2.EndPoint, line.StartPoint, line.EndPoint))
			{
				intersectionPoint = Intersect.GetIntersectionPoint(line2.StartPoint, line2.EndPoint, line.StartPoint, line.EndPoint);
				return true;
			}
		}
		return false;
	}

	public bool RectLineIsSegments(Line line, out List<Vector2> intersectionPoint)
	{
		intersectionPoint = CollectionPool<List<Vector2>, Vector2>.Get();
		for (int i = 0; i < _lineList.Count; i++)
		{
			Line line2 = _lineList[i];
			if (Intersect.IsSegmentsIntersect(line2.StartPoint, line2.EndPoint, line.StartPoint, line.EndPoint))
			{
				intersectionPoint.Add(Intersect.GetIntersectionPoint(line2.StartPoint, line2.EndPoint, line.StartPoint, line.EndPoint));
			}
		}
		return intersectionPoint.Count > 0;
	}

	public bool IsContainsSphere(BoundingSphere sphere)
	{
		bool num = sphere.position.x - sphere.radius >= Rect.xMin;
		bool flag = sphere.position.x + sphere.radius <= Rect.xMax;
		bool flag2 = sphere.position.y - sphere.radius >= Rect.yMin;
		bool flag3 = sphere.position.y + sphere.radius <= Rect.yMax;
		return num & flag & flag2 & flag3;
	}

	public void Clear()
	{
		_lineList.Clear();
		CollectionPool<List<Line>, Line>.Release(_lineList);
	}
}
