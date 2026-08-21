using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1141)]
[MemoryPackable(GenerateType.Object)]
public class InnerUseRedeemCodeRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUseRedeemCodeRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUseRedeemCodeRequestFormatter : MemoryPackFormatter<InnerUseRedeemCodeRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUseRedeemCodeRequest value)
		{
			InnerUseRedeemCodeRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUseRedeemCodeRequest value)
		{
			InnerUseRedeemCodeRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public string Code { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	public static InnerUseRedeemCodeRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUseRedeemCodeRequest)) as InnerUseRedeemCodeRequest;
		}
		return new InnerUseRedeemCodeRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Code = null;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUseRedeemCodeRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUseRedeemCodeRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUseRedeemCodeRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUseRedeemCodeRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUseRedeemCodeRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUseRedeemCodeRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.Code);
		writer.WriteUnmanaged<long, int, long>(value.UserId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUseRedeemCodeRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		string code;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				code = value.Code;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				code = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0122;
			}
			reader.ReadUnmanaged<bool>(out value2);
			code = reader.ReadString();
			reader.ReadUnmanaged<long, int, long>(out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUseRedeemCodeRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				code = null;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				code = value.Code;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					code = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0122;
			}
		}
		value = new InnerUseRedeemCodeRequest
		{
			IsFromPool = value2,
			Code = code,
			UserId = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_0122:
		value.IsFromPool = value2;
		value.Code = code;
		value.UserId = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
