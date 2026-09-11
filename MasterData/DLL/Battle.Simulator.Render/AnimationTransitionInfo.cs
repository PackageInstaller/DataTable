using System;

[Serializable]
public struct AnimationTransitionInfo
{
	public int from;

	public int to;

	public float time;

	public bool Equals(AnimationTransitionInfo other)
	{
		if (from == other.from)
		{
			return to == other.to;
		}
		return false;
	}
}
