using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace PrimitiveDetection;

public class SpherePrimitive : BasePrimitive
{
	private Vector3 _sphereCenter;

	private float _radius;

	private Quaternion _sphereQuaternion;

	private Vector3 scale;

	public Vector3 SphereCenter => _sphereCenter;

	public Vector3 Scale => scale;

	public float Radius => _radius;

	public override string ToString()
	{
		return $"center:{_sphereCenter} _radius:{_radius} _sphereQuaternion:{_sphereQuaternion} scale:{scale}";
	}

	public static SpherePrimitive Create(Vector3 sphereCenter, float radius, Quaternion sphereQuaternion)
	{
		SpherePrimitive spherePrimitive = ReferencePool.Acquire<SpherePrimitive>();
		spherePrimitive._sphereCenter = sphereCenter;
		spherePrimitive._radius = radius;
		spherePrimitive._sphereQuaternion = sphereQuaternion;
		spherePrimitive.Transform.SetOrientationAndPos(spherePrimitive._sphereQuaternion, spherePrimitive._sphereCenter);
		spherePrimitive.PrimitiveType = PrimitiveEnum.SpherePrimitive;
		return spherePrimitive;
	}

	public override void OnInit(PrimitiveInfo info, out bool result)
	{
		base.OnInit(info, out result);
		_sphereCenter = info.Center;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
			result = false;
		}
		_sphereQuaternion = info.Quaternion;
		Transform.SetOrientationAndPos(_sphereQuaternion, _sphereCenter);
		base.PrimitiveType = PrimitiveEnum.SpherePrimitive;
	}

	public override void UpdateSelf(PrimitiveInfo info)
	{
		_sphereCenter = info.Center;
		_radius = info.Radius;
		if (_radius <= 0f)
		{
			_radius = 0.001f;
		}
		_sphereQuaternion = info.Quaternion;
		Transform.SetOrientationAndPos(_sphereQuaternion, _sphereCenter);
		base.PrimitiveType = PrimitiveEnum.SpherePrimitive;
		base.UpdateSelf(info);
	}

	public override bool InternalCheckPrimitive()
	{
		if (_radius <= 0f)
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
