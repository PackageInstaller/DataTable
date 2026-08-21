using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(440)]
[MemoryPackable(GenerateType.Object)]
public class PbPresetEquipmentConflictInfo : MessageObject, IMemoryPackable<PbPresetEquipmentConflictInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbPresetEquipmentConflictInfoFormatter : MemoryPackFormatter<PbPresetEquipmentConflictInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentConflictInfo value)
		{
			PbPresetEquipmentConflictInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentConflictInfo value)
		{
			PbPresetEquipmentConflictInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ThingType { get; set; }

	[MemoryPackOrder(1)]
	public int Position { get; set; }

	[MemoryPackOrder(2)]
	public long EquipmentUuid { get; set; }

	[MemoryPackOrder(3)]
	public int EquippedRoleId { get; set; }

	public static PbPresetEquipmentConflictInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbPresetEquipmentConflictInfo)) as PbPresetEquipmentConflictInfo;
		}
		return new PbPresetEquipmentConflictInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ThingType = 0;
			Position = 0;
			EquipmentUuid = 0L;
			EquippedRoleId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbPresetEquipmentConflictInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentConflictInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbPresetEquipmentConflictInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentConflictInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbPresetEquipmentConflictInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentConflictInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int>(5, value.IsFromPool, value.ThingType, value.Position, value.EquipmentUuid, value.EquippedRoleId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentConflictInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.Position;
				value5 = value.EquipmentUuid;
				value6 = value.EquippedRoleId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0118;
			}
			reader.ReadUnmanaged<bool, int, int, long, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbPresetEquipmentConflictInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.Position;
				value5 = value.EquipmentUuid;
				value6 = value.EquippedRoleId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0118;
			}
		}
		value = new PbPresetEquipmentConflictInfo
		{
			IsFromPool = value2,
			ThingType = value3,
			Position = value4,
			EquipmentUuid = value5,
			EquippedRoleId = value6
		};
		return;
		IL_0118:
		value.IsFromPool = value2;
		value.ThingType = value3;
		value.Position = value4;
		value.EquipmentUuid = value5;
		value.EquippedRoleId = value6;
	}
}
