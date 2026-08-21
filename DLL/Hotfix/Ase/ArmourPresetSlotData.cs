using System.Collections.Generic;

namespace Ase;

public class ArmourPresetSlotData
{
	public const int CurrentSlotId = 0;

	public const int PresetSlotCount = 3;

	public const int DisplaySlotCount = 6;

	public const int DisplayItemCount = 7;

	public const int BarDisplayIndex = 5;

	private readonly Dictionary<int, long> equipmentUidsByPosition = new Dictionary<int, long>();

	public int RoleId { get; }

	public int SlotId { get; }

	public string PresetName { get; set; }

	public bool IsCreated { get; set; }

	public bool IsCurrent => SlotId == 0;

	public bool HasEquipment => equipmentUidsByPosition.Count > 0;

	public IReadOnlyDictionary<int, long> EquipmentUidsByPosition => equipmentUidsByPosition;

	public ArmourPresetSlotData(int roleId, int slotId, string presetName, bool isCreated)
	{
		RoleId = roleId;
		SlotId = slotId;
		PresetName = presetName;
		IsCreated = isCreated;
	}

	public static string GetDefaultName(int slotId)
	{
		if (slotId != 0)
		{
			return $"预设{slotId}";
		}
		return "当前佩戴";
	}

	public static ArmourPresetSlotData CreateCurrent(HeroModel heroModel)
	{
		ArmourPresetSlotData armourPresetSlotData = new ArmourPresetSlotData(heroModel?.Id ?? 0, 0, GetDefaultName(0), isCreated: true);
		if (heroModel?.Armours != null)
		{
			foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
			{
				if (armour.Value != null)
				{
					armourPresetSlotData.SetEquipment(armour.Key, armour.Value.Uid);
				}
			}
		}
		return armourPresetSlotData;
	}

	public ArmourData GetEquipment(int position)
	{
		if (!equipmentUidsByPosition.TryGetValue(position, out var value) || value <= 0)
		{
			return null;
		}
		return Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.GetArmourById(value);
	}

	public void SetEquipment(int position, long uid)
	{
		if (uid <= 0)
		{
			equipmentUidsByPosition.Remove(position);
			return;
		}
		equipmentUidsByPosition[position] = uid;
		IsCreated = true;
	}

	public void RemoveEquipment(int position)
	{
		equipmentUidsByPosition.Remove(position);
	}

	public void ClearEquipments()
	{
		equipmentUidsByPosition.Clear();
	}

	public bool RemoveInvalidEquipments()
	{
		IEquipmentService service = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>();
		if (service == null || equipmentUidsByPosition.Count == 0)
		{
			return false;
		}
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, long> item in equipmentUidsByPosition)
		{
			if (item.Value > 0 && service.GetArmourById(item.Value) == null)
			{
				list.Add(item.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			equipmentUidsByPosition.Remove(list[i]);
		}
		return list.Count > 0;
	}

	public void ReplaceWith(ArmourPresetSlotData slotData)
	{
		if (slotData == null)
		{
			return;
		}
		PresetName = slotData.PresetName;
		IsCreated = slotData.IsCreated;
		equipmentUidsByPosition.Clear();
		foreach (KeyValuePair<int, long> item in slotData.EquipmentUidsByPosition)
		{
			equipmentUidsByPosition[item.Key] = item.Value;
		}
	}

	public List<ArmourData> GetEquipmentsInDisplayOrder()
	{
		List<ArmourData> list = new List<ArmourData>();
		for (int i = 0; i < 6; i++)
		{
			list.Add(GetEquipment(i));
		}
		return list;
	}

	public List<EquipAttribute> GetAllAttributes()
	{
		List<EquipAttribute> list = new List<EquipAttribute>();
		foreach (ArmourData item in GetEquipmentsInDisplayOrder())
		{
			if (item?.EquipAttributeList != null)
			{
				list.AddRange(item.EquipAttributeList);
			}
		}
		return list;
	}

	public List<EntryData> GetAllEntries()
	{
		List<EntryData> list = new List<EntryData>();
		foreach (ArmourData item in GetEquipmentsInDisplayOrder())
		{
			if (item != null)
			{
				list.AddRange(from p in item.GetAllEntry()
					where p?.DrEntry != null
					select p);
			}
		}
		return list;
	}
}
