using UnityEngine;

public readonly struct SummerRaceDefeatPresentationEvent(string effectPath, Vector2 position, Vector2 direction, Transform sourceTransform, Transform targetTransform)
{
	public readonly string EffectPath = effectPath ?? string.Empty;

	public readonly Vector2 Position = position;

	public readonly Vector2 Direction = direction;

	public readonly Transform SourceTransform = sourceTransform;

	public readonly Transform TargetTransform = targetTransform;
}
