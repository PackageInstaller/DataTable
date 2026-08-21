using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10486)]
[MemoryPackable(GenerateType.Object)]
public class UseGoodsRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<UseGoodsRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UseGoodsRequestFormatter : MemoryPackFormatter<UseGoodsRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UseGoodsRequest value)
		{
			UseGoodsRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UseGoodsRequest value)
		{
			UseGoodsRequest.Deserialize(ref reader, ref value);
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
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Count { get; set; }

	public static UseGoodsRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UseGoodsRequest)) as UseGoodsRequest;
		}
		return new UseGoodsRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Id = 0;
			Count = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UseGoodsRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UseGoodsRequest>())
		{
			MemoryPackFormatterProvider.Register(new UseGoodsRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UseGoodsRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UseGoodsRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UseGoodsRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long, int, long>(7, value.IsFromPool, value.Id, value.Count, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UseGoodsRequest? value)
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
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Count;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0172;
			}
			reader.ReadUnmanaged<bool, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UseGoodsRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Count;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
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
								reader.ReadUnmanaged<long>(out value6);
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
				goto IL_0172;
			}
		}
		value = new UseGoodsRequest
		{
			IsFromPool = value2,
			Id = value3,
			Count = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0172:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Count = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
