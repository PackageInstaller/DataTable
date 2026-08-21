using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10164)]
[MemoryPackable(GenerateType.Object)]
public class C2H_GetCurrencyDataRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_GetCurrencyDataRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_GetCurrencyDataRequestFormatter : MemoryPackFormatter<C2H_GetCurrencyDataRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_GetCurrencyDataRequest value)
		{
			C2H_GetCurrencyDataRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_GetCurrencyDataRequest value)
		{
			C2H_GetCurrencyDataRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	public static C2H_GetCurrencyDataRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_GetCurrencyDataRequest)) as C2H_GetCurrencyDataRequest;
		}
		return new C2H_GetCurrencyDataRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Message = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_GetCurrencyDataRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_GetCurrencyDataRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_GetCurrencyDataRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_GetCurrencyDataRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_GetCurrencyDataRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_GetCurrencyDataRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long>(6, value.IsFromPool, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_GetCurrencyDataRequest? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				message = reader.ReadString();
				goto IL_014d;
			}
			reader.ReadUnmanaged<bool, int, long, int, long>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_GetCurrencyDataRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				message = value.Message;
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
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014d;
			}
		}
		value = new C2H_GetCurrencyDataRequest
		{
			IsFromPool = value2,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6,
			Message = message
		};
		return;
		IL_014d:
		value.IsFromPool = value2;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
		value.Message = message;
	}
}
