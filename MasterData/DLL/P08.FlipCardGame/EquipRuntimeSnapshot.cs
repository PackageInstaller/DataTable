public readonly struct EquipRuntimeSnapshot(int slotIndex, bool isReady, float cooldownRemaining, float activeRemaining, float cooldownDuration, float activeDuration, float energyCost, string label)
{
	public readonly int SlotIndex = slotIndex;

	public readonly bool IsReady = isReady;

	public readonly float CooldownRemaining = cooldownRemaining;

	public readonly float ActiveRemaining = activeRemaining;

	public readonly float CooldownDuration = cooldownDuration;

	public readonly float ActiveDuration = activeDuration;

	public readonly float EnergyCost = energyCost;

	public readonly string Label = label ?? string.Empty;
}
