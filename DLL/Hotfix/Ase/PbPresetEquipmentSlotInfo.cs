using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(439)]
[MemoryPackable(GenerateType.Object)]
public class PbPresetEquipmentSlotInfo : MessageObject, IMemoryPackable<PbPresetEquipmentSlotInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbPresetEquipmentSlotInfoFormatter : MemoryPackFormatter<PbPresetEquipmentSlotInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentSlotInfo value)
		{
			PbPresetEquipmentSlotInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentSlotInfo value)
		{
			PbPresetEquipmentSlotInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int SlotId { get; set; }

	[MemoryPackOrder(1)]
	public bool IsCreated { get; set; }

	[MemoryPackOrder(2)]
	public string PresetName { get; set; }

	[MemoryPackOrder(3)]
	public List<PbPresetEquipmentItemInfo> Equipments { get; set; } = new List<PbPresetEquipmentItemInfo>();

	public static PbPresetEquipmentSlotInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbPresetEquipmentSlotInfo)) as PbPresetEquipmentSlotInfo;
		}
		return new PbPresetEquipmentSlotInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			SlotId = 0;
			IsCreated = false;
			PresetName = null;
			Equipments.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbPresetEquipmentSlotInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentSlotInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbPresetEquipmentSlotInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentSlotInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbPresetEquipmentSlotInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbPresetEquipmentItemInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbPresetEquipmentItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentSlotInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, bool>(5, value.IsFromPool, value.SlotId, value.IsCreated);
		writer.WriteString(value.PresetName);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbPresetEquipmentItemInfo>>(value.Equipments));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentSlotInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		bool value4;
		List<PbPresetEquipmentItemInfo> value5;
		string presetName;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SlotId;
				value4 = value.IsCreated;
				presetName = value.PresetName;
				value5 = value.Equipments;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				presetName = reader.ReadString();
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int, bool>(out value2, out value3, out value4);
			presetName = reader.ReadString();
			value5 = ListFormatter.DeserializePackable<PbPresetEquipmentItemInfo>(ref reader);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbPresetEquipmentSlotInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = false;
				presetName = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SlotId;
				value4 = value.IsCreated;
				presetName = value.PresetName;
				value5 = value.Equipments;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
						if (memberCount != 3)
						{
							presetName = reader.ReadString();
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0123;
			}
		}
		value = new PbPresetEquipmentSlotInfo
		{
			IsFromPool = value2,
			SlotId = value3,
			IsCreated = value4,
			PresetName = presetName,
			Equipments = value5
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.SlotId = value3;
		value.IsCreated = value4;
		value.PresetName = presetName;
		value.Equipments = value5;
	}
}
