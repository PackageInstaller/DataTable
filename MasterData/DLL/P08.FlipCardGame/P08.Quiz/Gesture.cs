using System;

namespace P08.Quiz;

[Serializable]
public sealed class Gesture
{
	internal const int k_InvalidGestureId = -1;

	public int gestureId;

	public float duration;

	internal float time;

	public bool IsPlaying { get; private set; }

	public float NormalizedTime => time / duration;

	public void Start(int nameHash, float duration)
	{
		gestureId = nameHash;
		this.duration = duration;
		IsPlaying = true;
		time = 0f;
	}

	public void Stop()
	{
		gestureId = -1;
		IsPlaying = false;
	}

	public bool Update(float dt)
	{
		time += dt;
		return NormalizedTime < 1f;
	}
}
