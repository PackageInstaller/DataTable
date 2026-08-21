using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(426)]
[MemoryPackable(GenerateType.Object)]
public class PbChatShareInfo : MessageObject, IMemoryPackable<PbChatShareInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbChatShareInfoFormatter : MemoryPackFormatter<PbChatShareInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbChatShareInfo value)
		{
			PbChatShareInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbChatShareInfo value)
		{
			PbChatShareInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public PbNormalRoleInfo ShareRoleInfo { get; set; }

	[MemoryPackOrder(1)]
	public List<PbNormalRoleInfo> ShareTroopSetting { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(2)]
	public PbShareEquipInfo ShareEquipInfo { get; set; }

	public static PbChatShareInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbChatShareInfo)) as PbChatShareInfo;
		}
		return new PbChatShareInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ShareRoleInfo = null;
			ShareTroopSetting.Clear();
			ShareEquipInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbChatShareInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatShareInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbChatShareInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatShareInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbChatShareInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbChatShareInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WritePackable<PbNormalRoleInfo>(value.ShareRoleInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.ShareTroopSetting));
		writer.WritePackable<PbShareEquipInfo>(value.ShareEquipInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbChatShareInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbNormalRoleInfo value3;
		List<PbNormalRoleInfo> value4;
		PbShareEquipInfo value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ShareRoleInfo;
				value4 = value.ShareTroopSetting;
				value5 = value.ShareEquipInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadPackable(ref value5);
				goto IL_00f9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbNormalRoleInfo>();
			value4 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			value5 = reader.ReadPackable<PbShareEquipInfo>();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbChatShareInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ShareRoleInfo;
				value4 = value.ShareTroopSetting;
				value5 = value.ShareEquipInfo;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f9;
			}
		}
		value = new PbChatShareInfo
		{
			IsFromPool = value2,
			ShareRoleInfo = value3,
			ShareTroopSetting = value4,
			ShareEquipInfo = value5
		};
		return;
		IL_00f9:
		value.IsFromPool = value2;
		value.ShareRoleInfo = value3;
		value.ShareTroopSetting = value4;
		value.ShareEquipInfo = value5;
	}
}
