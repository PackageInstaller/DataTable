using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1069)]
[MemoryPackable(GenerateType.Object)]
public class InnerMultiFightLeaveCopyRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerMultiFightLeaveCopyRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerMultiFightLeaveCopyRequestFormatter : MemoryPackFormatter<InnerMultiFightLeaveCopyRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightLeaveCopyRequest value)
		{
			InnerMultiFightLeaveCopyRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightLeaveCopyRequest value)
		{
			InnerMultiFightLeaveCopyRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	public static InnerMultiFightLeaveCopyRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerMultiFightLeaveCopyRequest)) as InnerMultiFightLeaveCopyRequest;
		}
		return new InnerMultiFightLeaveCopyRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerMultiFightLeaveCopyRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightLeaveCopyRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerMultiFightLeaveCopyRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightLeaveCopyRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerMultiFightLeaveCopyRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightLeaveCopyRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.UserId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightLeaveCopyRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerMultiFightLeaveCopyRequest), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new InnerMultiFightLeaveCopyRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RpcId = value4;
	}
}
