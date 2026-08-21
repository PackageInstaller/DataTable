using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(386)]
[MemoryPackable(GenerateType.Object)]
public class PbFloorRoleSettingInfo : MessageObject, IMemoryPackable<PbFloorRoleSettingInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFloorRoleSettingInfoFormatter : MemoryPackFormatter<PbFloorRoleSettingInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFloorRoleSettingInfo value)
		{
			PbFloorRoleSettingInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFloorRoleSettingInfo value)
		{
			PbFloorRoleSettingInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public PbFloorSettingEquipmentInfo WeaponInfo { get; set; }

	[MemoryPackOrder(2)]
	public PbFloorSettingEquipmentInfo SuitboxInfo { get; set; }

	[MemoryPackOrder(3)]
	public List<PbFloorSettingEquipmentInfo> ArmourInfos { get; set; } = new List<PbFloorSettingEquipmentInfo>();

	[MemoryPackOrder(4)]
	public int WeaponRefineLevel { get; set; }

	public static PbFloorRoleSettingInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFloorRoleSettingInfo)) as PbFloorRoleSettingInfo;
		}
		return new PbFloorRoleSettingInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RoleId = 0;
			WeaponInfo = null;
			SuitboxInfo = null;
			ArmourInfos.Clear();
			WeaponRefineLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFloorRoleSettingInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorRoleSettingInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFloorRoleSettingInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorRoleSettingInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFloorRoleSettingInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFloorSettingEquipmentInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFloorSettingEquipmentInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFloorRoleSettingInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.RoleId);
		writer.WritePackable<PbFloorSettingEquipmentInfo>(value.WeaponInfo);
		writer.WritePackable<PbFloorSettingEquipmentInfo>(value.SuitboxInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFloorSettingEquipmentInfo>>(value.ArmourInfos));
		writer.WriteUnmanaged<int>(value.WeaponRefineLevel);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFloorRoleSettingInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbFloorSettingEquipmentInfo value4;
		PbFloorSettingEquipmentInfo value5;
		List<PbFloorSettingEquipmentInfo> value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.WeaponInfo;
				value5 = value.SuitboxInfo;
				value6 = value.ArmourInfos;
				value7 = value.WeaponRefineLevel;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadPackable(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_015c;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbFloorSettingEquipmentInfo>();
			value5 = reader.ReadPackable<PbFloorSettingEquipmentInfo>();
			value6 = ListFormatter.DeserializePackable<PbFloorSettingEquipmentInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFloorRoleSettingInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.WeaponInfo;
				value5 = value.SuitboxInfo;
				value6 = value.ArmourInfos;
				value7 = value.WeaponRefineLevel;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_015c;
			}
		}
		value = new PbFloorRoleSettingInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			WeaponInfo = value4,
			SuitboxInfo = value5,
			ArmourInfos = value6,
			WeaponRefineLevel = value7
		};
		return;
		IL_015c:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.WeaponInfo = value4;
		value.SuitboxInfo = value5;
		value.ArmourInfos = value6;
		value.WeaponRefineLevel = value7;
	}
}
