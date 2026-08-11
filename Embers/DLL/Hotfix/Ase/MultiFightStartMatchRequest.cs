using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10428)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightStartMatchRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightStartMatchRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightStartMatchRequestFormatter : MemoryPackFormatter<MultiFightStartMatchRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightStartMatchRequest value)
		{
			MultiFightStartMatchRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightStartMatchRequest value)
		{
			MultiFightStartMatchRequest.Deserialize(ref reader, ref value);
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
	public long UserId { get; set; }

	[MemoryPackOrder(92)]
	public int ClientFlag { get; set; }

	[MemoryPackOrder(7)]
	public string ClientVersion { get; set; }

	public static MultiFightStartMatchRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightStartMatchRequest)) as MultiFightStartMatchRequest;
		}
		return new MultiFightStartMatchRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ClientFlag = 0;
			ClientVersion = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightStartMatchRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartMatchRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightStartMatchRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartMatchRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightStartMatchRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightStartMatchRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteString(value.ClientVersion);
		writer.WriteUnmanaged<int, long, int, long, long, int>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId, value.ClientFlag);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightStartMatchRequest? value)
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
		int value8;
		string clientVersion;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				clientVersion = value.ClientVersion;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				value8 = value.ClientFlag;
				reader.ReadUnmanaged<bool>(out value2);
				clientVersion = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_01a7;
			}
			reader.ReadUnmanaged<bool>(out value2);
			clientVersion = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long, long, int>(out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightStartMatchRequest), 8, memberCount);
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
				value7 = 0L;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				clientVersion = value.ClientVersion;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				value8 = value.ClientFlag;
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
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											_ = 8;
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
				goto IL_01a7;
			}
		}
		value = new MultiFightStartMatchRequest
		{
			IsFromPool = value2,
			ClientVersion = clientVersion,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6,
			UserId = value7,
			ClientFlag = value8
		};
		return;
		IL_01a7:
		value.IsFromPool = value2;
		value.ClientVersion = clientVersion;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
		value.UserId = value7;
		value.ClientFlag = value8;
	}
}
