using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10474)]
[MemoryPackable(GenerateType.Object)]
public class H2MR_InnerKickUserRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2MR_InnerKickUserRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2MR_InnerKickUserRequestFormatter : MemoryPackFormatter<H2MR_InnerKickUserRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerKickUserRequest value)
		{
			H2MR_InnerKickUserRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerKickUserRequest value)
		{
			H2MR_InnerKickUserRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int ServerType { get; set; }

	[MemoryPackOrder(1)]
	public long TargetUserId { get; set; }

	public static H2MR_InnerKickUserRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2MR_InnerKickUserRequest)) as H2MR_InnerKickUserRequest;
		}
		return new H2MR_InnerKickUserRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ServerType = 0;
			TargetUserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2MR_InnerKickUserRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerKickUserRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2MR_InnerKickUserRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerKickUserRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2MR_InnerKickUserRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerKickUserRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long, long>(6, value.IsFromPool, value.ServerType, value.TargetUserId, value.RpcId, value.ActorId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerKickUserRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		long value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ServerType;
				value4 = value.TargetUserId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0148;
			}
			reader.ReadUnmanaged<bool, int, long, int, long, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2MR_InnerKickUserRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ServerType;
				value4 = value.TargetUserId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
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
				goto IL_0148;
			}
		}
		value = new H2MR_InnerKickUserRequest
		{
			IsFromPool = value2,
			ServerType = value3,
			TargetUserId = value4,
			RpcId = value5,
			ActorId = value6,
			UserId = value7
		};
		return;
		IL_0148:
		value.IsFromPool = value2;
		value.ServerType = value3;
		value.TargetUserId = value4;
		value.RpcId = value5;
		value.ActorId = value6;
		value.UserId = value7;
	}
}
