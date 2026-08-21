using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10510)]
[MemoryPackable(GenerateType.Object)]
public class TeamRoomChangeSelectRoleNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<TeamRoomChangeSelectRoleNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TeamRoomChangeSelectRoleNotifyFormatter : MemoryPackFormatter<TeamRoomChangeSelectRoleNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TeamRoomChangeSelectRoleNotify value)
		{
			TeamRoomChangeSelectRoleNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TeamRoomChangeSelectRoleNotify value)
		{
			TeamRoomChangeSelectRoleNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbRoomRoleInfo NewRole { get; set; }

	public static TeamRoomChangeSelectRoleNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TeamRoomChangeSelectRoleNotify)) as TeamRoomChangeSelectRoleNotify;
		}
		return new TeamRoomChangeSelectRoleNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			NewRole = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TeamRoomChangeSelectRoleNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TeamRoomChangeSelectRoleNotify>())
		{
			MemoryPackFormatterProvider.Register(new TeamRoomChangeSelectRoleNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TeamRoomChangeSelectRoleNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TeamRoomChangeSelectRoleNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TeamRoomChangeSelectRoleNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UserId);
		writer.WritePackable<PbRoomRoleInfo>(value.NewRole);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TeamRoomChangeSelectRoleNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbRoomRoleInfo value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewRole;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TeamRoomChangeSelectRoleNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewRole;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new TeamRoomChangeSelectRoleNotify
		{
			IsFromPool = value2,
			UserId = value3,
			NewRole = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.NewRole = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
