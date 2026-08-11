using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace PrimitiveDetection;

public class CapsulePrimitive : BasePrimitive
{
	private Vector3 _capsuleCenter;

	private Quaternion _capsuleQuaternion;

	private float _radius;

	private float _height;

	private Vector3 _halfHeight;

	public Vector3 CenterOne;

	public Vector3 CenterTwo;

	public Vector3 CenterOneToTwo;

	public Vector3 CenterTwoToOne;

	public Vector3 CapsuleCenter => _capsuleCenter;

	public Quaternion CapsuleQuaternion => _capsuleQuaternion;

	public float Radius => _radius;

	public float Height => _height;

	public Vector3 HalfHeight => _halfHeight;

	public override string ToString()
	{
		return $"CapsulePrimitive:center:{_capsuleCenter} _radius:{_radius} _height:{_height} " + $"CenterOne:{CenterOne} CenterTwo:{CenterTwo} CenterOneToTwo:{CenterOneToTwo} CenterTwoToOne:{CenterTwoToOne}";
	}

	public static CapsulePrimitive Create(Vector3 center, Quaternion quaternion, float radius, float height)
	{
		CapsulePrimitive capsulePrimitive = ReferencePool.Acquire<CapsulePrimitive>();
		capsulePrimitive._capsuleCenter = center;
		capsulePrimitive._capsuleQuaternion = quaternion;
		capsulePrimitive._radius = radius;
		capsulePrimitive._height = height;
		capsulePrimitive._halfHeight = new Vector3(0f, 0.5f * height, 0f);
		capsulePrimitive.Transform.SetOrientationAndPos(quaternion, center);
		capsulePrimitive.CenterOne = capsulePrimitive.Transform * capsulePrimitive._halfHeight;
		capsulePrimitive.CenterTwo = capsulePrimitive.Transform * -capsulePrimitive._halfHeight;
		capsulePrimitive.CenterOneToTwo = capsulePrimitive.CenterTwo - capsulePrimitive.CenterOne;
		capsulePrimitive.CenterTwoToOne = capsulePrimitive.CenterOne - capsulePrimitive.CenterTwo;
		capsulePrimitive.PrimitiveType = PrimitiveEnum.CapsulePrimitive;
		return capsulePrimitive;
	}

	public override void OnInit(PrimitiveInfo info, out bool result)
	{
		base.OnInit(info, out result);
		_capsuleCenter = info.Center;
		_capsuleQuaternion = info.Quaternion;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
			result = false;
		}
		_height = info.Height;
		if (_height <= 0f)
		{
			_height = 0.001f;
			result = false;
		}
		_halfHeight = new Vector3(0f, 0.5f * info.Height, 0f);
		Transform.SetOrientationAndPos(info.Quaternion, info.Center);
		CenterOne = Transform * _halfHeight;
		CenterTwo = Transform * -_halfHeight;
		CenterOneToTwo = CenterTwo - CenterOne;
		CenterTwoToOne = CenterOne - CenterTwo;
		base.PrimitiveType = PrimitiveEnum.CapsulePrimitive;
	}

	public override void UpdateSelf(PrimitiveInfo info)
	{
		_capsuleCenter = info.Center;
		_capsuleQuaternion = info.Quaternion;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
		}
		_height = info.Height;
		if (_height <= 0f)
		{
			_height = 0.001f;
		}
		_halfHeight.x = 0f;
		_halfHeight.y = 0.5f * info.Height;
		_halfHeight.z = 0f;
		Transform.SetOrientationAndPos(info.Quaternion, info.Center);
		CenterOne = Transform * _halfHeight;
		CenterTwo = Transform * -_halfHeight;
		CenterOneToTwo = CenterTwo - CenterOne;
		CenterTwoToOne = CenterOne - CenterTwo;
		base.PrimitiveType = PrimitiveEnum.CapsulePrimitive;
		base.UpdateSelf(info);
	}

	public override bool InternalCheckPrimitive()
	{
		if (_height <= 0f || _radius <= 0f)
		{
			return false;
		}
		return true;
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}
}
