using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(385)]
[MemoryPackable(GenerateType.Object)]
public class PbFloorSettingEquipmentInfo : MessageObject, IMemoryPackable<PbFloorSettingEquipmentInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFloorSettingEquipmentInfoFormatter : MemoryPackFormatter<PbFloorSettingEquipmentInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFloorSettingEquipmentInfo value)
		{
			PbFloorSettingEquipmentInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFloorSettingEquipmentInfo value)
		{
			PbFloorSettingEquipmentInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int EquipmentId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbIdValue> Attribute { get; set; } = new List<PbIdValue>();

	[MemoryPackOrder(2)]
	public List<PbIdValue> Entries { get; set; } = new List<PbIdValue>();

	public static PbFloorSettingEquipmentInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFloorSettingEquipmentInfo)) as PbFloorSettingEquipmentInfo;
		}
		return new PbFloorSettingEquipmentInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			EquipmentId = 0;
			Attribute.Clear();
			Entries.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFloorSettingEquipmentInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorSettingEquipmentInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFloorSettingEquipmentInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorSettingEquipmentInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFloorSettingEquipmentInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbIdValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFloorSettingEquipmentInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.EquipmentId);
		List<PbIdValue> source = value.Attribute;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.Entries;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFloorSettingEquipmentInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbIdValue> value4;
		List<PbIdValue> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipmentId;
				value4 = value.Attribute;
				value5 = value.Entries;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFloorSettingEquipmentInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipmentId;
				value4 = value.Attribute;
				value5 = value.Entries;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new PbFloorSettingEquipmentInfo
		{
			IsFromPool = value2,
			EquipmentId = value3,
			Attribute = value4,
			Entries = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.EquipmentId = value3;
		value.Attribute = value4;
		value.Entries = value5;
	}
}
