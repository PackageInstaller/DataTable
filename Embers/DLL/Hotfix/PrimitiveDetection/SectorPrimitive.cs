using System;
using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace PrimitiveDetection;

public class SectorPrimitive : BasePrimitive
{
	private Vector3 _sectorCenter;

	private Quaternion _quaternion;

	private float _angle;

	private float _radius;

	private Vector3[] _localEdgeVers = new Vector3[2];

	public Vector3 SectorCenter => _sectorCenter;

	public Quaternion Quaternion => _quaternion;

	public float Angle => _angle;

	public float Radius => _radius;

	public Vector3 LocalUnitX => Transform * Vector3.right - _sectorCenter;

	public Vector3 LocalUnitY => Transform * Vector3.up - _sectorCenter;

	public Vector3 LocalUnitZ => Transform * Vector3.forward - _sectorCenter;

	public Vector3[] EdgeVertices { get; private set; }

	public static SectorPrimitive Create(Vector3 sectorCenter, Quaternion quaternion, float angle, float radius)
	{
		SectorPrimitive sectorPrimitive = ReferencePool.Acquire<SectorPrimitive>();
		sectorPrimitive._sectorCenter = sectorCenter;
		sectorPrimitive._quaternion = quaternion;
		sectorPrimitive._angle = angle / 180f * MathF.PI;
		sectorPrimitive._radius = radius;
		sectorPrimitive.Transform.SetOrientationAndPos(sectorPrimitive._quaternion, sectorPrimitive._sectorCenter);
		sectorPrimitive._localEdgeVers = new Vector3[2];
		sectorPrimitive.EdgeVertices = new Vector3[2];
		sectorPrimitive.GetLocalVertices();
		sectorPrimitive.PrimitiveType = PrimitiveEnum.SectorPrimitive;
		return sectorPrimitive;
	}

	public override void OnInit(PrimitiveInfo info, out bool result)
	{
		base.OnInit(info, out result);
		_sectorCenter = info.Center;
		_quaternion = info.Quaternion;
		_quaternion *= Quaternion.Euler(new Vector3(0f, -90f, 0f));
		_angle = info.Angle;
		if (info.Angle <= 0f)
		{
			_angle = 0.001f;
			result = false;
		}
		if (info.Angle > 360f)
		{
			_angle = 360f;
			result = false;
		}
		_angle = _angle / 180f * MathF.PI;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
			result = false;
		}
		Transform.SetOrientationAndPos(_quaternion, _sectorCenter);
		_localEdgeVers = new Vector3[2];
		EdgeVertices = new Vector3[2];
		GetLocalVertices();
		base.PrimitiveType = PrimitiveEnum.SectorPrimitive;
	}

	public override void UpdateSelf(PrimitiveInfo info)
	{
		_sectorCenter = info.Center;
		_quaternion = info.Quaternion;
		_quaternion *= Quaternion.Euler(new Vector3(0f, -90f, 0f));
		_angle = info.Angle;
		if (info.Angle <= 0f)
		{
			_angle = 0.001f;
		}
		if (info.Angle > 360f)
		{
			_angle = 360f;
		}
		_angle = _angle / 180f * MathF.PI;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
		}
		Transform.SetOrientationAndPos(_quaternion, _sectorCenter);
		GetLocalVertices();
		base.PrimitiveType = PrimitiveEnum.SectorPrimitive;
		base.UpdateSelf(info);
	}

	private void GetLocalVertices()
	{
		Vector3 vector = new Vector3(_radius * Mathf.Cos(_angle / 2f), 0f, _radius * Mathf.Sin(_angle / 2f));
		Vector3 vector2 = new Vector3(_radius * Mathf.Cos(_angle / 2f), 0f, 0f - _radius * Mathf.Sin(_angle / 2f));
		_localEdgeVers[0] = vector;
		_localEdgeVers[1] = vector2;
		EdgeVertices[0] = Transform * vector;
		EdgeVertices[1] = Transform * vector2;
	}

	public Vector3 Transform2Local(Vector3 point)
	{
		return Transform.TransformInverse(point);
	}

	public Vector3 Transform2World(Vector3 point)
	{
		return Transform.Transform(point);
	}

	public override bool InternalCheckPrimitive()
	{
		if (_radius <= 0f || _angle <= 0f)
		{
			return false;
		}
		return true;
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		base.Clear();
		_localEdgeVers = null;
		EdgeVertices = null;
	}
}
