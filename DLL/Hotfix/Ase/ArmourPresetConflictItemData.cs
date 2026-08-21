namespace Ase;

public class ArmourPresetConflictItemData : OptionBase
{
	private readonly ArmourData armourData;

	private readonly ArmourItemData armourItemData;

	private readonly EquipWearerItemData wearerItemData;

	public ArmourData ArmourData => armourData;

	public ArmourItemData ArmourItemData => armourItemData;

	public EquipWearerItemData WearerItemData => wearerItemData;

	public ArmourPresetConflictItemData(OptionBase parent, ArmourPresetConflictData conflictData)
	{
		base.parent = parent;
		if (conflictData != null)
		{
			armourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.GetArmourById(conflictData.EquipmentUid);
			if (armourData != null)
			{
				armourItemData = new ArmourItemData(parent, armourData, conflictData.EquippedRoleId);
			}
			wearerItemData = new EquipWearerItemData(conflictData.EquippedRoleId);
		}
	}
}
