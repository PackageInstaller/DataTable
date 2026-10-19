using System;

namespace ACT.Config;

[Serializable]
public class Vector
{
	public readonly float x;

	public readonly float y;

	public readonly float z;

	public Vector(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
}
