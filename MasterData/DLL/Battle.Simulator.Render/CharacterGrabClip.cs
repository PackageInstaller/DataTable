using System;

[Serializable]
public class CharacterGrabClip : IComparable<CharacterGrabClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public string TargetGrabAnimationName = "fall_ground";

	public int TargetGrabPoseFrame;

	public int TargetGrabPoseCrossFadeTime;

	public string TargetGrabPoint = "gua_Buff_bottom";

	public string GrabPoint = "gua_Weapon";

	public int CompareTo(CharacterGrabClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}

	public float GetBeginNormalized()
	{
		return NormalizedBegin;
	}

	public float GetEndNormalized()
	{
		return NormalizedEnd;
	}

	public float GetLength()
	{
		return Length;
	}
}
