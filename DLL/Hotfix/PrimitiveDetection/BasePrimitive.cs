using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace PrimitiveDetection;

public abstract class BasePrimitive : IReference
{
	public Matrix4 Transform = Matrix4.NewIdentity();

	public PrimitiveEnum PrimitiveType { get; protected set; }

	public PrimitiveShowInfo ShowInfo { get; protected set; }

	public BasePrimitive()
	{
	}

	public virtual void PrimitiveDebug(PrimitiveLogData data)
	{
	}

	public virtual void OnDrawGizmos()
	{
	}

	public virtual void OnInit(PrimitiveInfo info, out bool result)
	{
		ShowInfo = info.showInfo;
		result = true;
	}

	public virtual void UpdateSelf(PrimitiveInfo info)
	{
	}

	public abstract bool InternalCheckPrimitive();

	public abstract void OnDispose();

	public Vector3 GetAxis(int index)
	{
		return Transform.GetAxisVector(index);
	}

	public virtual void Clear()
	{
		Transform.Clear();
		PrimitiveType = PrimitiveEnum.NONE;
	}
}
