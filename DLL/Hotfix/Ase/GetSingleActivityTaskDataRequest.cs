using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10787)]
[MemoryPackable(GenerateType.Object)]
public class GetSingleActivityTaskDataRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<GetSingleActivityTaskDataRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetSingleActivityTaskDataRequestFormatter : MemoryPackFormatter<GetSingleActivityTaskDataRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetSingleActivityTaskDataRequest value)
		{
			GetSingleActivityTaskDataRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetSingleActivityTaskDataRequest value)
		{
			GetSingleActivityTaskDataRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int ActivityType { get; set; }

	public static GetSingleActivityTaskDataRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetSingleActivityTaskDataRequest)) as GetSingleActivityTaskDataRequest;
		}
		return new GetSingleActivityTaskDataRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ActivityType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetSingleActivityTaskDataRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetSingleActivityTaskDataRequest>())
		{
			MemoryPackFormatterProvider.Register(new GetSingleActivityTaskDataRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetSingleActivityTaskDataRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetSingleActivityTaskDataRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetSingleActivityTaskDataRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, long>(6, value.IsFromPool, value.ActivityType, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetSingleActivityTaskDataRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0147;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetSingleActivityTaskDataRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0147;
			}
		}
		value = new GetSingleActivityTaskDataRequest
		{
			IsFromPool = value2,
			ActivityType = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0147:
		value.IsFromPool = value2;
		value.ActivityType = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
