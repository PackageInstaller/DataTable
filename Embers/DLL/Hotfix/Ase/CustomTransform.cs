using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class CustomTransform
{
	public CustomVector3 Position;

	public CustomQuaternion Rotation;

	public CustomVector3 Scale;

	public CustomTransform()
	{
	}

	public CustomTransform(Transform tran)
	{
		Position = new CustomVector3(tran.position);
		Rotation = new CustomQuaternion(tran.rotation);
		Scale = new CustomVector3(tran.localScale);
	}

	public void SetValueToTransform(Transform target)
	{
		target.transform.position = Position.GetValue();
		target.transform.rotation = Rotation.GetValue();
		target.transform.localScale = Scale.GetValue();
	}
}
