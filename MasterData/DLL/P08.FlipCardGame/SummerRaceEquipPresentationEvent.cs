using UnityEngine;

public readonly struct SummerRaceEquipPresentationEvent(SummerRacePresentationPhase phase, SummerRacePresentationDeliveryKind deliveryKind, EquipKind equipKind, int slotIndex, Vector2 position, Vector2 direction, string rejectReason, float activeDuration, float strength, float radius, Vector2 sourcePoint, Vector2 targetPoint, Transform targetTransform, float reachDistance, int targetCount, Transform sourceTransform, MountPoint mountPoint, UtilityModuleDefinition equipDefinition)
{
	public readonly SummerRacePresentationPhase Phase = phase;

	public readonly SummerRacePresentationDeliveryKind DeliveryKind = deliveryKind;

	public readonly EquipKind EquipKind = equipKind;

	public readonly int SlotIndex = slotIndex;

	public readonly Vector2 Position = position;

	public readonly Vector2 Direction = direction;

	public readonly string RejectReason = rejectReason ?? string.Empty;

	public readonly float ActiveDuration = activeDuration;

	public readonly float Strength = strength;

	public readonly float Radius = radius;

	public readonly Vector2 SourcePoint = sourcePoint;

	public readonly Vector2 TargetPoint = targetPoint;

	public readonly Transform TargetTransform = targetTransform;

	public readonly float ReachDistance = reachDistance;

	public readonly int TargetCount = targetCount;

	public readonly Transform SourceTransform = sourceTransform;

	public readonly MountPoint MountPoint = mountPoint;

	public readonly UtilityModuleDefinition EquipDefinition = equipDefinition;
}
