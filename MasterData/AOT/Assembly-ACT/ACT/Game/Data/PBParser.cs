using UnityEngine;

namespace ACT.Game.Data;

public static class PBParser
{
	public static PBVector2 ToPB(this Vector2 me)
	{
		return new PBVector2
		{
			X = me.x,
			Y = me.y
		};
	}

	public static Vector2 ToUnity(this PBVector2 me)
	{
		return new Vector2
		{
			x = me.X,
			y = me.Y
		};
	}

	public static PBVector3 ToPB(this Vector3 me)
	{
		return new PBVector3
		{
			X = me.x,
			Y = me.y,
			Z = me.z
		};
	}

	public static Vector3 ToUnity(this PBVector3 me)
	{
		return new Vector3
		{
			x = me.X,
			y = me.Y,
			z = me.Z
		};
	}
}
