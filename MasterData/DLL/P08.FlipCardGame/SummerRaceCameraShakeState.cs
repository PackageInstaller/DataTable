using UnityEngine;

public readonly struct SummerRaceCameraShakeState(float timer, float duration, float amplitude)
{
	public static SummerRaceCameraShakeState None => new SummerRaceCameraShakeState(0f, 0f, 0f);

	public float Timer { get; } = Mathf.Max(0f, timer);

	public float Duration { get; } = Mathf.Max(0f, duration);

	public float Amplitude { get; } = Mathf.Max(0f, amplitude);

	public bool IsActive
	{
		get
		{
			if (Duration > 0f && Timer < Duration)
			{
				return Amplitude > 0f;
			}
			return false;
		}
	}
}
