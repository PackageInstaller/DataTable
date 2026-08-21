using System;
using System.Linq;
using UnityEngine;

namespace Assets.MoveableLineRenderer.Scripts;

internal sealed class MoveableLineRenderer : MonoBehaviour
{
	public GameObject LineRendererPrefab;

	public float MinVertexDistance = 1f;

	public float LifeTime = 0.3f;

	public float Scale = 1f;

	public float Speed = 1f;

	public float Height = 1f;

	public float Gravity;

	private LineRenderer _lineRenderer;

	private Point[] _points;

	private int _pointsCount;

	private void Start()
	{
		if (_lineRenderer == null)
		{
			_lineRenderer = UnityEngine.Object.Instantiate(LineRendererPrefab).GetComponent<LineRenderer>();
			_lineRenderer.positionCount = 0;
			_lineRenderer.enabled = true;
			_lineRenderer.transform.parent = base.transform;
		}
		_points = new Point[100];
	}

	private void Update()
	{
		RemoveOutdatedPoints();
		if (_pointsCount == 0)
		{
			_points[_pointsCount++] = new Point(base.transform.position);
			_points[_pointsCount++] = new Point(base.transform.position);
		}
		bool flag = false;
		float sqrMagnitude = (_points[0].Position - base.transform.position).sqrMagnitude;
		if (sqrMagnitude > MinVertexDistance * MinVertexDistance && sqrMagnitude > MinVertexDistance * MinVertexDistance)
		{
			flag = true;
		}
		if (flag)
		{
			if (_pointsCount == _points.Length)
			{
				Array.Resize(ref _points, _points.Length + 50);
			}
			InsertPoint();
		}
		ApplyTurbulence();
		_lineRenderer.positionCount = _pointsCount;
		_lineRenderer.SetPositions((from t in _points
			where t != null
			select t.Position).ToArray());
	}

	private void OnDisable()
	{
		if (_lineRenderer != null)
		{
			_lineRenderer.positionCount = 0;
		}
		_points = new Point[100];
		_pointsCount = 0;
	}

	private void InsertPoint()
	{
		for (int num = _pointsCount; num > 0; num--)
		{
			_points[num] = _points[num - 1];
		}
		_points[0] = new Point(base.transform.position);
		_pointsCount++;
	}

	private void RemoveOutdatedPoints()
	{
		if (_pointsCount == 0)
		{
			return;
		}
		for (int num = _pointsCount - 1; num >= 0; num--)
		{
			Point point = _points[num];
			if (point == null || point.TimeAlive >= LifeTime)
			{
				_points[num] = null;
				_pointsCount--;
			}
		}
	}

	private void ApplyTurbulence()
	{
		for (int num = _pointsCount - 1; num >= 0; num--)
		{
			if (_points[num] != null)
			{
				float num2 = Time.timeSinceLevelLoad * Speed;
				Vector3 position = _points[num].Position;
				float x = position.x * Scale + num2;
				float num3 = position.y * Scale + num2;
				float y = position.z * Scale + num2;
				_points[num].Position.x += (Mathf.PerlinNoise(num3, y) - 0.5f) * Height;
				_points[num].Position.y += (Mathf.PerlinNoise(x, y) - 0.5f) * Height - Gravity;
				_points[num].Position.z += (Mathf.PerlinNoise(x, num3) - 0.5f) * Height;
			}
		}
	}
}
