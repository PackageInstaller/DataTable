using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10469)]
[MemoryPackable(GenerateType.Object)]
public class H2SR_InnerEnterSettingRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2SR_InnerEnterSettingRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2SR_InnerEnterSettingRoomRequestFormatter : MemoryPackFormatter<H2SR_InnerEnterSettingRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2SR_InnerEnterSettingRoomRequest value)
		{
			H2SR_InnerEnterSettingRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2SR_InnerEnterSettingRoomRequest value)
		{
			H2SR_InnerEnterSettingRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public PbRoomRoleInfo Role { get; set; }

	[MemoryPackOrder(3)]
	public List<PbRoomRoleInfo> ReserveRoles { get; set; } = new List<PbRoomRoleInfo>();

	public static H2SR_InnerEnterSettingRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2SR_InnerEnterSettingRoomRequest)) as H2SR_InnerEnterSettingRoomRequest;
		}
		return new H2SR_InnerEnterSettingRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			RoomId = 0L;
			Role = null;
			ReserveRoles.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2SR_InnerEnterSettingRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_InnerEnterSettingRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2SR_InnerEnterSettingRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_InnerEnterSettingRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2SR_InnerEnterSettingRoomRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2SR_InnerEnterSettingRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(7, value.IsFromPool, value.UserId, value.RoomId);
		writer.WritePackable<PbRoomRoleInfo>(value.Role);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomRoleInfo>>(value.ReserveRoles));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2SR_InnerEnterSettingRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		PbRoomRoleInfo value5;
		List<PbRoomRoleInfo> value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.Role;
				value6 = value.ReserveRoles;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0185;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbRoomRoleInfo>();
			value6 = ListFormatter.DeserializePackable<PbRoomRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2SR_InnerEnterSettingRoomRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.Role;
				value6 = value.ReserveRoles;
				value7 = value.RpcId;
				value8 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0185;
			}
		}
		value = new H2SR_InnerEnterSettingRoomRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			Role = value5,
			ReserveRoles = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0185:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.Role = value5;
		value.ReserveRoles = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
