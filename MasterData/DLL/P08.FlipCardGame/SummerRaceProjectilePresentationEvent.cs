using UnityEngine;

public readonly struct SummerRaceProjectilePresentationEvent(SummerRacePresentationPhase phase, SummerRacePresentationDeliveryKind deliveryKind, WeaponKind weaponKind, int correlationId, int slotIndex, Vector2 position, Vector2 direction, Transform sourceTransform, Transform projectileTransform, MountPoint mountPoint, WeaponModuleDefinition weaponDefinition, ICombatStatusHost target, int appliedEffects, int damageDealt)
{
	public readonly SummerRacePresentationPhase Phase = phase;

	public readonly SummerRacePresentationDeliveryKind DeliveryKind = deliveryKind;

	public readonly WeaponKind WeaponKind = weaponKind;

	public readonly int CorrelationId = correlationId;

	public readonly int SlotIndex = slotIndex;

	public readonly Vector2 Position = position;

	public readonly Vector2 Direction = direction;

	public readonly Transform SourceTransform = sourceTransform;

	public readonly Transform ProjectileTransform = projectileTransform;

	public readonly MountPoint MountPoint = mountPoint;

	public readonly WeaponModuleDefinition WeaponDefinition = weaponDefinition;

	public readonly ICombatStatusHost Target = target;

	public readonly int AppliedEffects = appliedEffects;

	public readonly int DamageDealt = damageDealt;
}
