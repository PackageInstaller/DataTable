namespace Ase;

public class ArmourPresetConflictData
{
	public int ThingType { get; }

	public int Position { get; }

	public long EquipmentUid { get; }

	public int EquippedRoleId { get; }

	public ArmourPresetConflictData(int thingType, int position, long equipmentUid, int equippedRoleId)
	{
		ThingType = thingType;
		Position = position;
		EquipmentUid = equipmentUid;
		EquippedRoleId = equippedRoleId;
	}
}
