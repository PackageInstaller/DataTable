using UnityEngine;

public sealed class WeaponFireContext
{
	public IWeaponOwnerContext owner;

	public int slotIndex;

	public Vector2 aimDirection;

	public Transform aimTarget;
}
