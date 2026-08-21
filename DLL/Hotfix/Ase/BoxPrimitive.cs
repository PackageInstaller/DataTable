using Ase.ECS;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public class BoxPrimitive : BasePrimitive
{
	private Vector3 _boxCenter;

	private Quaternion _boxQuaternion;

	private Vector3 size;

	private Vector3 halfSize;

	public Vector3[] LocalVertices = new Vector3[8];

	public Vector3[] Vertices = new Vector3[8];

	public Vector3 boxCenter => _boxCenter;

	public Vector3 HalfSize => halfSize;

	public override string ToString()
	{
		return $"BoxPrimitive:center:{_boxCenter} angle:{_boxQuaternion} size:{size}";
	}

	public static BoxPrimitive Create(Vector3 center, Quaternion quaternion, Vector3 boxSize)
	{
		BoxPrimitive boxPrimitive = ReferencePool.Acquire<BoxPrimitive>();
		boxPrimitive._boxCenter = center;
		boxPrimitive._boxQuaternion = quaternion;
		boxPrimitive.size = boxSize;
		boxPrimitive.halfSize.x = boxSize.x / 2f;
		boxPrimitive.halfSize.y = boxSize.y / 2f;
		boxPrimitive.halfSize.z = boxSize.z / 2f;
		boxPrimitive.GetLocalVertices();
		boxPrimitive.Transform.SetOrientationAndPos(boxPrimitive._boxQuaternion, boxPrimitive._boxCenter);
		boxPrimitive.GetVertices();
		boxPrimitive.PrimitiveType = PrimitiveEnum.BoxPrimitive;
		return boxPrimitive;
	}

	public override void OnInit(PrimitiveInfo info, out bool result)
	{
		base.OnInit(info, out result);
		_boxCenter = info.Center;
		_boxQuaternion = info.Quaternion;
		if (info.BoxSize.x <= 0f || info.BoxSize.y <= 0f || info.BoxSize.z <= 0f)
		{
			result = false;
		}
		size = Vector3.Max(info.BoxSize, Vector3.zero);
		halfSize.x = size.x / 2f;
		halfSize.y = size.y / 2f;
		halfSize.z = size.z / 2f;
		LocalVertices = new Vector3[8];
		Vertices = new Vector3[8];
		GetLocalVertices();
		Transform.SetOrientationAndPos(_boxQuaternion, _boxCenter);
		GetVertices();
		base.PrimitiveType = PrimitiveEnum.BoxPrimitive;
	}

	public override void UpdateSelf(PrimitiveInfo info)
	{
		_boxCenter = info.Center;
		_boxQuaternion = info.Quaternion;
		size = Vector3.Max(info.BoxSize, Vector3.zero);
		halfSize.x = size.x / 2f;
		halfSize.y = size.y / 2f;
		halfSize.z = size.z / 2f;
		GetLocalVertices();
		Transform.SetOrientationAndPos(_boxQuaternion, _boxCenter);
		GetVertices();
		base.PrimitiveType = PrimitiveEnum.BoxPrimitive;
		base.UpdateSelf(info);
	}

	private void GetLocalVertices()
	{
		for (int i = 0; i < 8; i++)
		{
			LocalVertices[i].x = PrimitiveExtension.BoxVMul(i, 0, HalfSize.x);
			LocalVertices[i].y = PrimitiveExtension.BoxVMul(i, 1, HalfSize.y);
			LocalVertices[i].z = PrimitiveExtension.BoxVMul(i, 2, HalfSize.z);
		}
	}

	private void GetVertices()
	{
		for (int i = 0; i < LocalVertices.Length; i++)
		{
			Vertices[i] = Transform * LocalVertices[i];
		}
	}

	public override bool InternalCheckPrimitive()
	{
		if (size.x <= 0f || size.y <= 0f || size.z <= 0f)
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
	}
}
