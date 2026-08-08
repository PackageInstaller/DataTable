using System;

[Serializable]
public struct ThrownCollisionCheckClip : IComparable<ThrownCollisionCheckClip>
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public string LinkMainEffectPath;

	public string LinkOtherEffectPath;

	public int CompareTo(ThrownCollisionCheckClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}
}
