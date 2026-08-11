using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10840)]
[MemoryPackable(GenerateType.Object)]
public class C2SCheckVersionRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2SCheckVersionRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2SCheckVersionRequestFormatter : MemoryPackFormatter<C2SCheckVersionRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2SCheckVersionRequest value)
		{
			C2SCheckVersionRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2SCheckVersionRequest value)
		{
			C2SCheckVersionRequest.Deserialize(ref reader, ref value);
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
	public string ClientVersion { get; set; }

	public static C2SCheckVersionRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2SCheckVersionRequest)) as C2SCheckVersionRequest;
		}
		return new C2SCheckVersionRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ClientVersion = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2SCheckVersionRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2SCheckVersionRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2SCheckVersionRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2SCheckVersionRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2SCheckVersionRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2SCheckVersionRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.ClientVersion);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2SCheckVersionRequest? value)
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
		string clientVersion;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				clientVersion = value.ClientVersion;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				clientVersion = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0150;
			}
			reader.ReadUnmanaged<bool>(out value2);
			clientVersion = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2SCheckVersionRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				clientVersion = null;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				clientVersion = value.ClientVersion;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					clientVersion = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0150;
			}
		}
		value = new C2SCheckVersionRequest
		{
			IsFromPool = value2,
			ClientVersion = clientVersion,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0150:
		value.IsFromPool = value2;
		value.ClientVersion = clientVersion;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
