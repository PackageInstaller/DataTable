using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1102)]
[MemoryPackable(GenerateType.Object)]
public class InnerModifyUnionPositionRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerModifyUnionPositionRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerModifyUnionPositionRequestFormatter : MemoryPackFormatter<InnerModifyUnionPositionRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerModifyUnionPositionRequest value)
		{
			InnerModifyUnionPositionRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerModifyUnionPositionRequest value)
		{
			InnerModifyUnionPositionRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public long TargetMemberId { get; set; }

	[MemoryPackOrder(2)]
	public int NewPosition { get; set; }

	public static InnerModifyUnionPositionRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerModifyUnionPositionRequest)) as InnerModifyUnionPositionRequest;
		}
		return new InnerModifyUnionPositionRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			TargetMemberId = 0L;
			NewPosition = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerModifyUnionPositionRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerModifyUnionPositionRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerModifyUnionPositionRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerModifyUnionPositionRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerModifyUnionPositionRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerModifyUnionPositionRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int, long>(6, value.IsFromPool, value.UnionId, value.TargetMemberId, value.NewPosition, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerModifyUnionPositionRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.TargetMemberId;
				value5 = value.NewPosition;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0148;
			}
			reader.ReadUnmanaged<bool, long, long, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerModifyUnionPositionRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.TargetMemberId;
				value5 = value.NewPosition;
				value6 = value.RpcId;
				value7 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0148;
			}
		}
		value = new InnerModifyUnionPositionRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			TargetMemberId = value4,
			NewPosition = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0148:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.TargetMemberId = value4;
		value.NewPosition = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
