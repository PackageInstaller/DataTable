using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class CustomQuaternion
{
	public float x;

	public float y;

	public float z;

	public float w;

	public Quaternion GetValue()
	{
		return new Quaternion(x, y, z, w);
	}

	public Vector4 GetValuV4()
	{
		return new Vector4(x, y, z, w);
	}

	public CustomQuaternion()
	{
	}

	public CustomQuaternion(float x, float y, float z, float w)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public CustomQuaternion(Quaternion qu)
	{
		x = qu.x;
		y = qu.y;
		z = qu.z;
		w = qu.w;
	}

	public CustomQuaternion(Vector4 ve4)
	{
		x = ve4.x;
		y = ve4.y;
		z = ve4.z;
		w = ve4.w;
	}
}
