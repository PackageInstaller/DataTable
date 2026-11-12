using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI.Extensions;

public class LineGraphicIndicator : BaseGraphicIndicator
{
	public UILineRenderer progressGraphic;

	protected Color _progressColor;

	protected float _thickness = 0.15f;

	protected List<Vector2> _points = new List<Vector2>();

	protected static List<Vector2[]> _pointsArrayCache = new List<Vector2[]>();

	protected Vector2[] _pointsArray;

	public override Vector2 position
	{
		get
		{
			return Vector2.zero;
		}
		set
		{
			_position = Vector2.zero;
			transform.localPosition = Vector3.zero;
		}
	}

	public override float rotation
	{
		get
		{
			return 0f;
		}
		set
		{
			_rotation = 0f;
			transform.localRotation = Quaternion.identity;
		}
	}

	public override Color progressColor
	{
		get
		{
			return _progressColor;
		}
		set
		{
			_progressColor = value;
		}
	}

	public float thickness
	{
		get
		{
			return _thickness;
		}
		set
		{
			_thickness = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	public List<Vector2> points
	{
		get
		{
			return _points;
		}
		set
		{
			if (_points != value)
			{
				_points = value;
				UpdateProgressGraphicPoints(_points);
			}
		}
	}

	protected Vector2[] ToArray(List<Vector2> pointsList)
	{
		if (_pointsArray != null && _pointsArray.Length != pointsList.Count)
		{
			lock (_pointsArrayCache)
			{
				_pointsArrayCache.Add(_pointsArray);
				_pointsArray = null;
			}
		}
		if (_pointsArray == null)
		{
			lock (_pointsArrayCache)
			{
				for (int i = 0; i < _pointsArrayCache.Count; i++)
				{
					if (_pointsArrayCache.get_Item(i).Length == pointsList.Count)
					{
						_pointsArray = _pointsArrayCache.get_Item(i);
						_pointsArrayCache.RemoveAt(i);
						break;
					}
				}
			}
		}
		if (_pointsArray == null)
		{
			_pointsArray = new Vector2[pointsList.Count];
		}
		pointsList.CopyTo(_pointsArray);
		return _pointsArray;
	}

	protected void UpdateProgressGraphicPoints(List<Vector2> pointsList)
	{
		progressGraphic.Points = null;
		progressGraphic.Points = ToArray(pointsList);
	}

	protected void OnDestroy()
	{
		if (_pointsArray != null)
		{
			lock (_pointsArrayCache)
			{
				_pointsArrayCache.Add(_pointsArray);
				_pointsArray = null;
			}
		}
	}

	public int GetPointCount()
	{
		return _points.Count;
	}

	public void AddPoint(Vector2 newPoint)
	{
		_points.Add(newPoint);
		UpdateProgressGraphicPoints(_points);
	}

	public void SetPoints(List<Vector2> newPoints)
	{
		_points.Clear();
		_points.AddRange(newPoints);
		UpdateProgressGraphicPoints(_points);
	}

	public void AddWorldPositionPoint(Vector3 newPoint)
	{
		AddPoint(new Vector2(newPoint.x, newPoint.z));
	}

	public void SetWorldPositionPoints(List<Vector3> newPoints)
	{
		_points.Clear();
		for (int i = 0; i < newPoints.Count; i++)
		{
			_points.Add(new Vector2(newPoints.get_Item(i).x, newPoints.get_Item(i).z));
		}
		UpdateProgressGraphicPoints(_points);
	}

	public void ClearPoints()
	{
		_points.Clear();
		UpdateProgressGraphicPoints(_points);
	}

	protected override void Awake()
	{
		_progressColor = progressGraphic.color;
		progressGraphic.rectTransform.pivot = new Vector2(0f, 0f);
		base.Awake();
	}

	protected override void RefreshProgressGraphic()
	{
		Color color = _progressColor;
		color.a = 0.2f + _progress * 0.6f;
		progressGraphic.color = color;
		progressGraphic.LineThickness = _thickness;
	}
}
