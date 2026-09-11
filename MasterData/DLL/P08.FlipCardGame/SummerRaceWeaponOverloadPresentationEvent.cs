using UnityEngine;

public readonly struct SummerRaceWeaponOverloadPresentationEvent(SummerRacePresentationPhase phase, int slotIndex, Vector2 position, Vector2 direction, Transform sourceTransform, MountPoint mountPoint, WeaponModuleDefinition weaponDefinition)
{
	public readonly SummerRacePresentationPhase Phase = phase;

	public readonly int SlotIndex = slotIndex;

	public readonly Vector2 Position = position;

	public readonly Vector2 Direction = direction;

	public readonly Transform SourceTransform = sourceTransform;

	public readonly MountPoint MountPoint = mountPoint;

	public readonly WeaponModuleDefinition WeaponDefinition = weaponDefinition;
}
