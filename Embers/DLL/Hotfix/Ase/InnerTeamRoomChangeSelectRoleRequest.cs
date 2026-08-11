using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10508)]
[MemoryPackable(GenerateType.Object)]
public class InnerTeamRoomChangeSelectRoleRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerTeamRoomChangeSelectRoleRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerTeamRoomChangeSelectRoleRequestFormatter : MemoryPackFormatter<InnerTeamRoomChangeSelectRoleRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerTeamRoomChangeSelectRoleRequest value)
		{
			InnerTeamRoomChangeSelectRoleRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerTeamRoomChangeSelectRoleRequest value)
		{
			InnerTeamRoomChangeSelectRoleRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbRoomRoleInfo NewRole { get; set; }

	public static InnerTeamRoomChangeSelectRoleRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerTeamRoomChangeSelectRoleRequest)) as InnerTeamRoomChangeSelectRoleRequest;
		}
		return new InnerTeamRoomChangeSelectRoleRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			NewRole = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerTeamRoomChangeSelectRoleRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTeamRoomChangeSelectRoleRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerTeamRoomChangeSelectRoleRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTeamRoomChangeSelectRoleRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerTeamRoomChangeSelectRoleRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerTeamRoomChangeSelectRoleRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.UserId);
		writer.WritePackable<PbRoomRoleInfo>(value.NewRole);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerTeamRoomChangeSelectRoleRequest? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewRole;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerTeamRoomChangeSelectRoleRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewRole;
				value5 = value.RpcId;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new InnerTeamRoomChangeSelectRoleRequest
		{
			IsFromPool = value2,
			UserId = value3,
			NewRole = value4,
			RpcId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.NewRole = value4;
		value.RpcId = value5;
	}
}
