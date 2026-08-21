using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1104)]
[MemoryPackable(GenerateType.Object)]
public class InnerSearchUnionRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerSearchUnionRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerSearchUnionRequestFormatter : MemoryPackFormatter<InnerSearchUnionRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerSearchUnionRequest value)
		{
			InnerSearchUnionRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerSearchUnionRequest value)
		{
			InnerSearchUnionRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	public static InnerSearchUnionRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerSearchUnionRequest)) as InnerSearchUnionRequest;
		}
		return new InnerSearchUnionRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			Name = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerSearchUnionRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSearchUnionRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerSearchUnionRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSearchUnionRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerSearchUnionRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerSearchUnionRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UnionId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerSearchUnionRequest? value)
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
		string name;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0122;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerSearchUnionRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
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
		value = new InnerSearchUnionRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			Name = name,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_0122:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.Name = name;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
