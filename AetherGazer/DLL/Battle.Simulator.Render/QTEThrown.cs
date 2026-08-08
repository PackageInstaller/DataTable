using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class QTEThrown : MonoBehaviour
{
	public float StageTime1 = 0.3f;

	public float StageTime2 = 0.4f;

	public Vector3 OriginRandomAngleMin = Vector3.zero;

	public Vector3 OriginRandomAngleMax = Vector3.zero;

	public float OriginSpeed = 100f;

	public Transform Target;

	private bool _running;

	private float _runtTime;

	private Vector3 _speed = Vector3.zero;

	private Vector3 _originPosition = Vector3.zero;

	private List<Vector3> _toTargets = new List<Vector3>();

	private List<Vector3> _speeds = new List<Vector3>();

	private List<Vector3> _position = new List<Vector3>();

	public void Initialize()
	{
		_runtTime = 0f;
		_running = false;
		_originPosition = base.transform.position;
		_speed = (Quaternion.Euler(Random.Range(OriginRandomAngleMin.x, OriginRandomAngleMax.x), Random.Range(OriginRandomAngleMin.y, OriginRandomAngleMax.y), 0f) * (base.transform.position - Target.position).normalized).normalized;
		_toTargets.Clear();
		_speeds.Clear();
		_position.Clear();
		_toTargets.Add((Target.position - base.transform.position).normalized);
		_speeds.Add(_speed);
		_position.Add(base.transform.position);
	}

	public void Play()
	{
		_running = true;
	}

	private void Update()
	{
		if (!_running)
		{
			return;
		}
		_runtTime += Time.deltaTime;
		float num = Vector3.Distance(Target.position, base.transform.position);
		if (_runtTime <= StageTime1)
		{
			if (num <= 3f)
			{
				Vector3 normalized = (Target.position - base.transform.position).normalized;
				_speed = Vector3.Slerp(_speed, normalized, _runtTime / StageTime1).normalized;
				_toTargets.Add(normalized);
			}
			else
			{
				Vector3 normalized2 = (Target.position - _originPosition).normalized;
				normalized2 = Vector3.Slerp(normalized2, (Target.position - base.transform.position).normalized, 0.5f).normalized;
				_speed = Vector3.Slerp(_speed, normalized2, _runtTime / StageTime1).normalized;
				_toTargets.Add(normalized2);
			}
			_speeds.Add(_speed);
			_position.Add(base.transform.position);
			base.transform.position += _speed * OriginSpeed * Time.deltaTime;
		}
		else if (_runtTime <= StageTime1 + StageTime2)
		{
			float num2 = StageTime2 - (_runtTime - StageTime1);
			float num3 = num / num2 * Time.deltaTime;
			if (num > num3)
			{
				Vector3 normalized3 = (Target.position - base.transform.position).normalized;
				_speed = Vector3.Slerp(_speed, normalized3, (_runtTime - StageTime1) / StageTime2).normalized;
				_toTargets.Add(normalized3);
				_speeds.Add(_speed);
				_position.Add(base.transform.position);
				base.transform.position += _speed * num3;
			}
		}
		else
		{
			_running = false;
		}
		if (num <= 0.25f)
		{
			base.transform.position = Target.position;
		}
	}

	private void OnDrawGizmos()
	{
		for (int i = 0; i < _position.Count; i++)
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawLine(_position[i], _position[i] + _speeds[i]);
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(_position[i], _position[i] + _toTargets[i]);
		}
	}
}
