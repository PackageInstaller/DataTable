using System;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

[Serializable]
public class CameraDepthOfFieldClip : IComparable<CameraDepthOfFieldClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int mPriority;

	public bool mBotherOthers;

	public DepthOfFieldType mDepthOfFieldType;

	public float mDepthOfFieldNear = 5f;

	public float mDepthOfFieldFar = 10f;

	public AnimationCurve mDepthOfFieldScale = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	public int CompareTo(CameraDepthOfFieldClip other)
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
