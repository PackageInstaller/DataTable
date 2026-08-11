using System;
using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace PrimitiveDetection;

public class AnnulusPrimitive : BasePrimitive
{
	private Vector3 _annulusCenter;

	private Quaternion _quaternion;

	private float _angle;

	private float _internalDiameter;

	private float _outerDiameter;

	private Vector3[,] _localEdgeVers;

	public Vector3 AnnulusCenter => _annulusCenter;

	public Quaternion Quaternion => _quaternion;

	public float Angle => _angle;

	public float InternalDiameter => _internalDiameter;

	public float OuterDiameter => _outerDiameter;

	public Vector3 LocalUnitX => Transform * Vector3.right - _annulusCenter;

	public Vector3 LocalUnitY => Transform * Vector3.up - _annulusCenter;

	public Vector3 LocalUnitZ => Transform * Vector3.forward - _annulusCenter;

	public Vector3[,] EdgeVertices { get; private set; }

	public override string ToString()
	{
		return $"AnnulusPrimitive:center:{_annulusCenter} angle:{_angle} internalDiameter:{_internalDiameter} outerDiameter:{_outerDiameter}";
	}

	public static AnnulusPrimitive Create(Vector3 annulusCenter, Quaternion quaternion, float angleDegrees, float outerRadius, float innerRadius)
	{
		AnnulusPrimitive annulusPrimitive = ReferencePool.Acquire<AnnulusPrimitive>();
		annulusPrimitive._annulusCenter = annulusCenter;
		annulusPrimitive._quaternion = quaternion;
		angleDegrees = Mathf.Clamp(angleDegrees, 0.001f, 360f);
		annulusPrimitive._angle = angleDegrees * (MathF.PI / 180f);
		annulusPrimitive._outerDiameter = Mathf.Max(0.001f, outerRadius);
		annulusPrimitive._internalDiameter = Mathf.Max(0f, Mathf.Min(annulusPrimitive._outerDiameter, innerRadius));
		annulusPrimitive.Transform.SetOrientationAndPos(annulusPrimitive._quaternion, annulusCenter);
		annulusPrimitive._localEdgeVers = new Vector3[2, 2];
		annulusPrimitive.EdgeVertices = new Vector3[2, 2];
		annulusPrimitive.GetLocalVertices();
		annulusPrimitive.PrimitiveType = PrimitiveEnum.AnnulusPrimitive;
		return annulusPrimitive;
	}

	public override void OnInit(PrimitiveInfo info, out bool result)
	{
		base.OnInit(info, out result);
		_annulusCenter = info.Center;
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
		if (info.Radius < 0f)
		{
			result = false;
		}
		_outerDiameter = ((info.Radius < 0f) ? 0.001f : info.Radius);
		if (info.InternalRadius < 0f)
		{
			result = false;
		}
		_internalDiameter = ((info.InternalRadius < 0f) ? 0.001f : info.InternalRadius);
		Transform.SetOrientationAndPos(_quaternion, _annulusCenter);
		_localEdgeVers = new Vector3[2, 2];
		EdgeVertices = new Vector3[2, 2];
		GetLocalVertices();
		base.PrimitiveType = PrimitiveEnum.AnnulusPrimitive;
	}

	public override void UpdateSelf(PrimitiveInfo info)
	{
		_annulusCenter = info.Center;
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
		_outerDiameter = ((info.Radius < 0f) ? 0.001f : info.Radius);
		_internalDiameter = ((info.InternalRadius < 0f) ? 0.001f : info.InternalRadius);
		Transform.SetOrientationAndPos(_quaternion, _annulusCenter);
		GetLocalVertices();
		base.PrimitiveType = PrimitiveEnum.AnnulusPrimitive;
		base.UpdateSelf(info);
	}

	public Vector3 Transform2Local(Vector3 point)
	{
		return Transform.TransformInverse(point);
	}

	public Vector3 Transform2World(Vector3 point)
	{
		return Transform.Transform(point);
	}

	private void GetLocalVertices()
	{
		Vector3 vector = new Vector3(_internalDiameter * Mathf.Cos(_angle / 2f), 0f, _internalDiameter * Mathf.Sin(_angle / 2f));
		Vector3 vector2 = new Vector3(_internalDiameter * Mathf.Cos(_angle / 2f), 0f, 0f - _internalDiameter * Mathf.Sin(_angle / 2f));
		_localEdgeVers[0, 0] = vector;
		_localEdgeVers[0, 1] = vector2;
		EdgeVertices[0, 0] = Transform * vector;
		EdgeVertices[0, 1] = Transform * vector2;
		Vector3 vector3 = new Vector3(_outerDiameter * Mathf.Cos(_angle / 2f), 0f, _outerDiameter * Mathf.Sin(_angle / 2f));
		Vector3 vector4 = new Vector3(_outerDiameter * Mathf.Cos(_angle / 2f), 0f, 0f - _outerDiameter * Mathf.Sin(_angle / 2f));
		_localEdgeVers[1, 0] = vector3;
		_localEdgeVers[1, 1] = vector4;
		EdgeVertices[1, 0] = Transform * vector3;
		EdgeVertices[1, 1] = Transform * vector4;
	}

	public override bool InternalCheckPrimitive()
	{
		if (_angle <= 0f || _internalDiameter <= 0f || _outerDiameter <= 0f || _internalDiameter > _outerDiameter)
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
