public readonly struct WeaponRuntimeSnapshot(int slotIndex, bool isReady, float cooldownRemaining, float dynamicSpread, float overloadRemaining)
{
	public readonly int SlotIndex = slotIndex;

	public readonly bool IsReady = isReady;

	public readonly float CooldownRemaining = cooldownRemaining;

	public readonly float DynamicSpread = dynamicSpread;

	public readonly float OverloadRemaining = overloadRemaining;
}
