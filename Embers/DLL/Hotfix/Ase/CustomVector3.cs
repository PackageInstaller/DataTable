using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class CustomVector3
{
	public float x;

	public float y;

	public float z;

	public Vector3 GetValue()
	{
		return new Vector3(x, y, z);
	}

	public CustomVector3()
	{
	}

	public CustomVector3(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public CustomVector3(Vector3 v3)
	{
		x = v3.x;
		y = v3.y;
		z = v3.z;
	}

	public CustomVector3(Vector2 v2)
	{
		x = v2.x;
		y = v2.y;
		z = 0f;
	}
}
