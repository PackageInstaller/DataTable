using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(437)]
[MemoryPackable(GenerateType.Object)]
public class PbRolePresetEquipmentInfo : MessageObject, IMemoryPackable<PbRolePresetEquipmentInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRolePresetEquipmentInfoFormatter : MemoryPackFormatter<PbRolePresetEquipmentInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRolePresetEquipmentInfo value)
		{
			PbRolePresetEquipmentInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRolePresetEquipmentInfo value)
		{
			PbRolePresetEquipmentInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbPresetEquipmentSlotInfo> Slots { get; set; } = new List<PbPresetEquipmentSlotInfo>();

	public static PbRolePresetEquipmentInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRolePresetEquipmentInfo)) as PbRolePresetEquipmentInfo;
		}
		return new PbRolePresetEquipmentInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RoleId = 0;
			Slots.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRolePresetEquipmentInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRolePresetEquipmentInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRolePresetEquipmentInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRolePresetEquipmentInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRolePresetEquipmentInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbPresetEquipmentSlotInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbPresetEquipmentSlotInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRolePresetEquipmentInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.RoleId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbPresetEquipmentSlotInfo>>(value.Slots));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRolePresetEquipmentInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbPresetEquipmentSlotInfo> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Slots;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbPresetEquipmentSlotInfo>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRolePresetEquipmentInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Slots;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbRolePresetEquipmentInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			Slots = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.Slots = value4;
	}
}
