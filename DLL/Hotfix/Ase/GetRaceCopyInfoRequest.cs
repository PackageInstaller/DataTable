using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10732)]
[MemoryPackable(GenerateType.Object)]
public class GetRaceCopyInfoRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<GetRaceCopyInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetRaceCopyInfoRequestFormatter : MemoryPackFormatter<GetRaceCopyInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetRaceCopyInfoRequest value)
		{
			GetRaceCopyInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetRaceCopyInfoRequest value)
		{
			GetRaceCopyInfoRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(9)]
	public string param1 { get; set; }

	public static GetRaceCopyInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetRaceCopyInfoRequest)) as GetRaceCopyInfoRequest;
		}
		return new GetRaceCopyInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetRaceCopyInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetRaceCopyInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new GetRaceCopyInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetRaceCopyInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetRaceCopyInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetRaceCopyInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.param1);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetRaceCopyInfoRequest? value)
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
		string text;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				text = value.param1;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0150;
			}
			reader.ReadUnmanaged<bool>(out value2);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetRaceCopyInfoRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				text = null;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				text = value.param1;
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
					text = reader.ReadString();
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
		value = new GetRaceCopyInfoRequest
		{
			IsFromPool = value2,
			param1 = text,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0150:
		value.IsFromPool = value2;
		value.param1 = text;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
