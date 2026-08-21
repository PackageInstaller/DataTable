using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10341)]
[MemoryPackable(GenerateType.Object)]
public class C2G_LogEventRequest : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<C2G_LogEventRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2G_LogEventRequestFormatter : MemoryPackFormatter<C2G_LogEventRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2G_LogEventRequest value)
		{
			C2G_LogEventRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2G_LogEventRequest value)
		{
			C2G_LogEventRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public int Type { get; set; }

	public static C2G_LogEventRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2G_LogEventRequest)) as C2G_LogEventRequest;
		}
		return new C2G_LogEventRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			UserId = 0L;
			Account = null;
			Type = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2G_LogEventRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LogEventRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2G_LogEventRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LogEventRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2G_LogEventRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2G_LogEventRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<int, int, long, int, long>(value.Type, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2G_LogEventRequest? value)
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
		string account;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.Type;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_017b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			reader.ReadUnmanaged<int, int, long, int, long>(out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2G_LogEventRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.Type;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value7);
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
				goto IL_017b;
			}
		}
		value = new C2G_LogEventRequest
		{
			IsFromPool = value2,
			Account = account,
			Type = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_017b:
		value.IsFromPool = value2;
		value.Account = account;
		value.Type = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
