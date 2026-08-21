using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(388)]
[MemoryPackable(GenerateType.Object)]
public class PbFloorCopySettleInfo : MessageObject, IMemoryPackable<PbFloorCopySettleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFloorCopySettleInfoFormatter : MemoryPackFormatter<PbFloorCopySettleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFloorCopySettleInfo value)
		{
			PbFloorCopySettleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFloorCopySettleInfo value)
		{
			PbFloorCopySettleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int MaxStar { get; set; }

	[MemoryPackOrder(2)]
	public int CurrentSettingStar { get; set; }

	[MemoryPackOrder(3)]
	public List<PbFloorRoleSettingInfo> RoleSettingInfos { get; set; } = new List<PbFloorRoleSettingInfo>();

	public static PbFloorCopySettleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFloorCopySettleInfo)) as PbFloorCopySettleInfo;
		}
		return new PbFloorCopySettleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			MaxStar = 0;
			CurrentSettingStar = 0;
			RoleSettingInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFloorCopySettleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopySettleInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFloorCopySettleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopySettleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFloorCopySettleInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFloorRoleSettingInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFloorRoleSettingInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFloorCopySettleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(5, value.IsFromPool, value.CopyId, value.MaxStar, value.CurrentSettingStar);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFloorRoleSettingInfo>>(value.RoleSettingInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFloorCopySettleInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		List<PbFloorRoleSettingInfo> value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.MaxStar;
				value5 = value.CurrentSettingStar;
				value6 = value.RoleSettingInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				goto IL_011d;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbFloorRoleSettingInfo>(ref reader);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFloorCopySettleInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.MaxStar;
				value5 = value.CurrentSettingStar;
				value6 = value.RoleSettingInfos;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011d;
			}
		}
		value = new PbFloorCopySettleInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			MaxStar = value4,
			CurrentSettingStar = value5,
			RoleSettingInfos = value6
		};
		return;
		IL_011d:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.MaxStar = value4;
		value.CurrentSettingStar = value5;
		value.RoleSettingInfos = value6;
	}
}
