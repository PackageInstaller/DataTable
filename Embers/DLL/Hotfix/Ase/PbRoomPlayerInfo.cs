using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(207)]
[MemoryPackable(GenerateType.Object)]
public class PbRoomPlayerInfo : MessageObject, IMemoryPackable<PbRoomPlayerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRoomPlayerInfoFormatter : MemoryPackFormatter<PbRoomPlayerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRoomPlayerInfo value)
		{
			PbRoomPlayerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRoomPlayerInfo value)
		{
			PbRoomPlayerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(92)]
	public int SeatId { get; set; }

	[MemoryPackOrder(91)]
	public List<PbRoomRoleInfo> Roles { get; set; } = new List<PbRoomRoleInfo>();

	public static PbRoomPlayerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRoomPlayerInfo)) as PbRoomPlayerInfo;
		}
		return new PbRoomPlayerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			SeatId = 0;
			Roles.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRoomPlayerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomPlayerInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRoomPlayerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomPlayerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRoomPlayerInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRoomPlayerInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int>(value.SeatId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRoomPlayerInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbRoomRoleInfo> value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Roles;
				value4 = value.SeatId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00c9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbRoomRoleInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRoomPlayerInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Roles;
				value4 = value.SeatId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c9;
			}
		}
		value = new PbRoomPlayerInfo
		{
			IsFromPool = value2,
			Roles = value3,
			SeatId = value4
		};
		return;
		IL_00c9:
		value.IsFromPool = value2;
		value.Roles = value3;
		value.SeatId = value4;
	}
}
