using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10056)]
[MemoryPackable(GenerateType.Object)]
public class UpdateSettingRoomRoleInfoNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UpdateSettingRoomRoleInfoNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UpdateSettingRoomRoleInfoNotifyFormatter : MemoryPackFormatter<UpdateSettingRoomRoleInfoNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UpdateSettingRoomRoleInfoNotify value)
		{
			UpdateSettingRoomRoleInfoNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UpdateSettingRoomRoleInfoNotify value)
		{
			UpdateSettingRoomRoleInfoNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int SeatId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public PbRoomRoleInfo RoleInfo { get; set; }

	public static UpdateSettingRoomRoleInfoNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UpdateSettingRoomRoleInfoNotify)) as UpdateSettingRoomRoleInfoNotify;
		}
		return new UpdateSettingRoomRoleInfoNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			SeatId = 0;
			UserId = 0L;
			RoleInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UpdateSettingRoomRoleInfoNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateSettingRoomRoleInfoNotify>())
		{
			MemoryPackFormatterProvider.Register(new UpdateSettingRoomRoleInfoNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateSettingRoomRoleInfoNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UpdateSettingRoomRoleInfoNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UpdateSettingRoomRoleInfoNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(6, value.IsFromPool, value.SeatId, value.UserId);
		writer.WritePackable<PbRoomRoleInfo>(value.RoleInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UpdateSettingRoomRoleInfoNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		PbRoomRoleInfo value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.UserId;
				value5 = value.RoleInfo;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0153;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UpdateSettingRoomRoleInfoNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.UserId;
				value5 = value.RoleInfo;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0153;
			}
		}
		value = new UpdateSettingRoomRoleInfoNotify
		{
			IsFromPool = value2,
			SeatId = value3,
			UserId = value4,
			RoleInfo = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0153:
		value.IsFromPool = value2;
		value.SeatId = value3;
		value.UserId = value4;
		value.RoleInfo = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
