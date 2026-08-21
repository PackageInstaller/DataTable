using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10472)]
[MemoryPackable(GenerateType.Object)]
public class H2SR_MultiFightChangeModelRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2SR_MultiFightChangeModelRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2SR_MultiFightChangeModelRequestFormatter : MemoryPackFormatter<H2SR_MultiFightChangeModelRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2SR_MultiFightChangeModelRequest value)
		{
			H2SR_MultiFightChangeModelRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2SR_MultiFightChangeModelRequest value)
		{
			H2SR_MultiFightChangeModelRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public MultiFightChangeModelRequest OutReq { get; set; }

	public static H2SR_MultiFightChangeModelRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2SR_MultiFightChangeModelRequest)) as H2SR_MultiFightChangeModelRequest;
		}
		return new H2SR_MultiFightChangeModelRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			OutReq = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2SR_MultiFightChangeModelRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_MultiFightChangeModelRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2SR_MultiFightChangeModelRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_MultiFightChangeModelRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2SR_MultiFightChangeModelRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2SR_MultiFightChangeModelRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.UserId);
		writer.WritePackable<MultiFightChangeModelRequest>(value.OutReq);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2SR_MultiFightChangeModelRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		MultiFightChangeModelRequest value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.OutReq;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<MultiFightChangeModelRequest>();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2SR_MultiFightChangeModelRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.OutReq;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new H2SR_MultiFightChangeModelRequest
		{
			IsFromPool = value2,
			UserId = value3,
			OutReq = value4,
			RpcId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.OutReq = value4;
		value.RpcId = value5;
	}
}
