using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(387)]
[MemoryPackable(GenerateType.Object)]
public class PbFloorCopyRoleSettingInfo : MessageObject, IMemoryPackable<PbFloorCopyRoleSettingInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFloorCopyRoleSettingInfoFormatter : MemoryPackFormatter<PbFloorCopyRoleSettingInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFloorCopyRoleSettingInfo value)
		{
			PbFloorCopyRoleSettingInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFloorCopyRoleSettingInfo value)
		{
			PbFloorCopyRoleSettingInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbFloorRoleSettingInfo> RoleSettingInfos { get; set; } = new List<PbFloorRoleSettingInfo>();

	public static PbFloorCopyRoleSettingInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFloorCopyRoleSettingInfo)) as PbFloorCopyRoleSettingInfo;
		}
		return new PbFloorCopyRoleSettingInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			RoleSettingInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFloorCopyRoleSettingInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopyRoleSettingInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFloorCopyRoleSettingInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopyRoleSettingInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFloorCopyRoleSettingInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFloorRoleSettingInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFloorRoleSettingInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFloorCopyRoleSettingInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.CopyId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFloorRoleSettingInfo>>(value.RoleSettingInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFloorCopyRoleSettingInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbFloorRoleSettingInfo> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.RoleSettingInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbFloorRoleSettingInfo>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFloorCopyRoleSettingInfo), 3, memberCount);
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
				value3 = value.CopyId;
				value4 = value.RoleSettingInfos;
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
		value = new PbFloorCopyRoleSettingInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			RoleSettingInfos = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.RoleSettingInfos = value4;
	}
}
