using UnityEngine;

public readonly struct SummerRaceCombatAudioEvent
{
	public readonly SummerRaceCombatAudioEventKind Kind;

	public readonly Transform SourceTransform;

	public readonly Vector2 Position;

	public readonly float Strength;

	private SummerRaceCombatAudioEvent(SummerRaceCombatAudioEventKind kind, Transform sourceTransform, Vector2 position, float strength)
	{
		Kind = kind;
		SourceTransform = sourceTransform;
		Position = position;
		Strength = strength;
	}

	public static SummerRaceCombatAudioEvent VehicleCollision(Transform sourceTransform, Vector2 position, float strength)
	{
		return new SummerRaceCombatAudioEvent(SummerRaceCombatAudioEventKind.VehicleCollision, sourceTransform, position, strength);
	}

	public static SummerRaceCombatAudioEvent VehicleDriveStarted(Transform sourceTransform)
	{
		Vector2 position = ((sourceTransform != null) ? ((Vector2)sourceTransform.position) : Vector2.zero);
		return new SummerRaceCombatAudioEvent(SummerRaceCombatAudioEventKind.VehicleDriveStarted, sourceTransform, position, 1f);
	}

	public static SummerRaceCombatAudioEvent VehicleDriveStopped(Transform sourceTransform)
	{
		Vector2 position = ((sourceTransform != null) ? ((Vector2)sourceTransform.position) : Vector2.zero);
		return new SummerRaceCombatAudioEvent(SummerRaceCombatAudioEventKind.VehicleDriveStopped, sourceTransform, position, 0f);
	}

	public static SummerRaceCombatAudioEvent DamageText(Transform sourceTransform, Vector2 position, float strength)
	{
		return new SummerRaceCombatAudioEvent(SummerRaceCombatAudioEventKind.DamageText, sourceTransform, position, strength);
	}
}
