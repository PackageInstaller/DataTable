using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1086)]
[MemoryPackable(GenerateType.Object)]
public class InnerCreateUnionRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerCreateUnionRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerCreateUnionRequestFormatter : MemoryPackFormatter<InnerCreateUnionRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerCreateUnionRequest value)
		{
			InnerCreateUnionRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerCreateUnionRequest value)
		{
			InnerCreateUnionRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public CreateUnionRequest outRequest { get; set; }

	[MemoryPackOrder(1)]
	public PbUnionLeaderInfo LeaderInfo { get; set; }

	public static InnerCreateUnionRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerCreateUnionRequest)) as InnerCreateUnionRequest;
		}
		return new InnerCreateUnionRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			outRequest = null;
			LeaderInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerCreateUnionRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCreateUnionRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerCreateUnionRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCreateUnionRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerCreateUnionRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerCreateUnionRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<CreateUnionRequest>(value.outRequest);
		writer.WritePackable<PbUnionLeaderInfo>(value.LeaderInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerCreateUnionRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		CreateUnionRequest value3;
		PbUnionLeaderInfo value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.outRequest;
				value4 = value.LeaderInfo;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<CreateUnionRequest>();
			value4 = reader.ReadPackable<PbUnionLeaderInfo>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerCreateUnionRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.outRequest;
				value4 = value.LeaderInfo;
				value5 = value.RpcId;
				value6 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012b;
			}
		}
		value = new InnerCreateUnionRequest
		{
			IsFromPool = value2,
			outRequest = value3,
			LeaderInfo = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.outRequest = value3;
		value.LeaderInfo = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
