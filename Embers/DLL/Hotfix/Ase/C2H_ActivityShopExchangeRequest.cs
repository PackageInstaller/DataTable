using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10836)]
[MemoryPackable(GenerateType.Object)]
public class C2H_ActivityShopExchangeRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_ActivityShopExchangeRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_ActivityShopExchangeRequestFormatter : MemoryPackFormatter<C2H_ActivityShopExchangeRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_ActivityShopExchangeRequest value)
		{
			C2H_ActivityShopExchangeRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_ActivityShopExchangeRequest value)
		{
			C2H_ActivityShopExchangeRequest.Deserialize(ref reader, ref value);
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
	public int ActivityId { get; set; }

	[MemoryPackOrder(1)]
	public int ChainId { get; set; }

	[MemoryPackOrder(2)]
	public int ExchangeId { get; set; }

	[MemoryPackOrder(3)]
	public int Value1 { get; set; }

	[MemoryPackOrder(4)]
	public int Value2 { get; set; }

	public static C2H_ActivityShopExchangeRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_ActivityShopExchangeRequest)) as C2H_ActivityShopExchangeRequest;
		}
		return new C2H_ActivityShopExchangeRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ActivityId = 0;
			ChainId = 0;
			ExchangeId = 0;
			Value1 = 0;
			Value2 = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_ActivityShopExchangeRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ActivityShopExchangeRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_ActivityShopExchangeRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ActivityShopExchangeRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_ActivityShopExchangeRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_ActivityShopExchangeRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, int, int, long, int, long>(10, value.IsFromPool, value.ActivityId, value.ChainId, value.ExchangeId, value.Value1, value.Value2, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_ActivityShopExchangeRequest? value)
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
		int value6;
		int value7;
		int value8;
		long value9;
		int value10;
		long value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityId;
				value4 = value.ChainId;
				value5 = value.ExchangeId;
				value6 = value.Value1;
				value7 = value.Value2;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_01f8;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_ActivityShopExchangeRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityId;
				value4 = value.ChainId;
				value5 = value.ExchangeId;
				value6 = value.Value1;
				value7 = value.Value2;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value11);
													_ = 10;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01f8;
			}
		}
		value = new C2H_ActivityShopExchangeRequest
		{
			IsFromPool = value2,
			ActivityId = value3,
			ChainId = value4,
			ExchangeId = value5,
			Value1 = value6,
			Value2 = value7,
			LoginServerId = value8,
			LoginSecretKey = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_01f8:
		value.IsFromPool = value2;
		value.ActivityId = value3;
		value.ChainId = value4;
		value.ExchangeId = value5;
		value.Value1 = value6;
		value.Value2 = value7;
		value.LoginServerId = value8;
		value.LoginSecretKey = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
