using System.Collections.Generic;
using UnityEngine;

public class SpringCurve : MonoBehaviour
{
	public int PointCount = 20;

	public float Stiffness = 0.61f;

	public float drag = 0.52f;

	public Vector3 From = Vector3.zero;

	public Vector3 To = Vector3.zero;

	public Vector3 Gravity = new Vector3(0f, -9.8f, 0f);

	private Vector3 _direction = Vector3.zero;

	private LineRenderer _lineRenderer;

	private List<Vector3> _linePoints;

	private List<Vector3> _oldLinePoints;

	private List<Vector3> _renderLinePosition;

	public float curveDistance = 1f;

	public float simStep = 3f;

	private float _percent;

	public void Initialize()
	{
		_lineRenderer = GetComponent<LineRenderer>();
		_lineRenderer.positionCount = PointCount;
		if (_linePoints == null)
		{
			_linePoints = new List<Vector3>(PointCount);
		}
		if (_oldLinePoints == null)
		{
			_oldLinePoints = new List<Vector3>(PointCount);
		}
		if (_renderLinePosition == null)
		{
			_renderLinePosition = new List<Vector3>(PointCount);
		}
		_linePoints.Clear();
		_oldLinePoints.Clear();
		_renderLinePosition.Clear();
		_linePoints.Add(From);
		_oldLinePoints.Add(From);
		_renderLinePosition.Add(From);
		_direction = (To - From) / (PointCount - 1);
		for (int i = 1; i < PointCount - 1; i++)
		{
			_linePoints.Add(From + _direction * i);
			_oldLinePoints.Add(From + _direction * i);
			_renderLinePosition.Add(From + _direction * i);
		}
		_linePoints.Add(To);
		_oldLinePoints.Add(To);
		_renderLinePosition.Add(To);
		curveDistance = (_linePoints[_linePoints.Count - 1] - _linePoints[0]).magnitude;
	}

	public void FixedUpdate()
	{
		if (null == _lineRenderer)
		{
			return;
		}
		_linePoints[0] = From;
		_linePoints[_linePoints.Count - 1] = To;
		for (int i = 1; i < _linePoints.Count - 1; i++)
		{
			Vector3 value = _linePoints[i];
			_linePoints[i] = _linePoints[i] + (_linePoints[i] - _oldLinePoints[i]) * drag + Gravity * Time.fixedDeltaTime * Time.fixedDeltaTime;
			_oldLinePoints[i] = value;
		}
		curveDistance = (_linePoints[_linePoints.Count - 1] - _linePoints[0]).magnitude;
		float num = curveDistance * Mathf.Clamp01(1f - Stiffness) / (float)(_linePoints.Count - 1);
		for (int j = 0; (float)j < simStep; j++)
		{
			for (int k = 1; k <= _linePoints.Count - 1; k++)
			{
				Vector3 vector = _linePoints[k - 1] - _linePoints[k];
				float magnitude = vector.magnitude;
				Vector3 vector2 = (magnitude - num) / magnitude * vector;
				if (k == 1)
				{
					_linePoints[k] += vector2;
					continue;
				}
				if (k == _linePoints.Count - 1)
				{
					_linePoints[k - 1] -= vector2;
					continue;
				}
				_linePoints[k - 1] -= vector2 * 0.5f;
				_linePoints[k] += vector2 * 0.5f;
			}
		}
		_percent = 0f;
		for (int l = 0; l < _lineRenderer.positionCount; l++)
		{
			_renderLinePosition[l] = _lineRenderer.GetPosition(l);
		}
	}

	private void Update()
	{
		_percent += Time.deltaTime;
		float t = _percent / Time.fixedDeltaTime;
		for (int i = 0; i < _lineRenderer.positionCount; i++)
		{
			Vector3 position = Vector3.Lerp(_renderLinePosition[i], _linePoints[i], t);
			_lineRenderer.SetPosition(i, position);
		}
	}

	public void OnDrawGizmos()
	{
		if (_linePoints != null)
		{
			for (int i = 1; i < _linePoints.Count - 1; i++)
			{
				Gizmos.DrawSphere(_linePoints[i], 0.2f);
			}
		}
	}

	public void ShowLine(bool show = true)
	{
		if (_lineRenderer != null)
		{
			_lineRenderer.enabled = show;
		}
	}
}
