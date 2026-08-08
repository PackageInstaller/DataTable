using System;

[Serializable]
public class AudioPlayActionClip : IComparable<AudioPlayActionClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public string CueSheet;

	public string CueName;

	public string AwbName;

	public bool IsVoice;

	public int StartTimeInMs;

	public int[] RandomRoleVoiceIDs;

	public int[] RandomWeight;

	public int[] RandomStartTimeInMs;

	public int RandomTotalWitght;

	public int PercentOfPlay;

	public CriCueInfo[] CriCueInfoArr;

	public int CompareTo(AudioPlayActionClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}

	public float GetBeginNormalized()
	{
		return NormalizedBegin;
	}

	public float GetLength()
	{
		return Length;
	}

	public float GetEndNormalized()
	{
		return NormalizedEnd;
	}
}
