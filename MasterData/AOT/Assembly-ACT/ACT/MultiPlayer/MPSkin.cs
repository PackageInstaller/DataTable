using System;

namespace ACT.MultiPlayer;

public struct MPSkin : IEquatable<MPSkin>
{
	public int skinId;

	public int colorId;

	public bool Equals(MPSkin other)
	{
		if (skinId == other.skinId)
		{
			return colorId == other.colorId;
		}
		return false;
	}
}
