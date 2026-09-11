using UnityEngine;

namespace PigeonCoopToolkit.Effects.Trails;

[AddComponentMenu("Pigeon Coop Toolkit/Effects/Trail")]
public class Trail : TrailRenderer_Base
{
	public float MinVertexDistance = 0.1f;

	public int MaxNumberOfPoints = 50;

	private Vector3 _lastPosition;

	private float _distanceMoved;

	protected override void Start()
	{
		base.Start();
		_lastPosition = _t.position;
	}

	protected override void Update()
	{
		if (_emit)
		{
			_distanceMoved += Vector3.Distance(_t.position, _lastPosition);
			if (_distanceMoved != 0f && _distanceMoved >= MinVertexDistance)
			{
				AddPoint<PCTrailPoint>(_t.position);
				_distanceMoved = 0f;
			}
			_lastPosition = _t.position;
		}
		base.Update();
	}

	protected override void OnStartEmit()
	{
		_lastPosition = _t.position;
		_distanceMoved = 0f;
	}

	protected override void Reset()
	{
		base.Reset();
		MinVertexDistance = 0.1f;
	}

	protected override void OnTranslate(Vector3 t)
	{
		_lastPosition += t;
	}

	protected override int GetMaxNumberOfPoints()
	{
		return MaxNumberOfPoints;
	}
}
