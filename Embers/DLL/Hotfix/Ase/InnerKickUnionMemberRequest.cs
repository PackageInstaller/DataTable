using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1096)]
[MemoryPackable(GenerateType.Object)]
public class InnerKickUnionMemberRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerKickUnionMemberRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerKickUnionMemberRequestFormatter : MemoryPackFormatter<InnerKickUnionMemberRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerKickUnionMemberRequest value)
		{
			InnerKickUnionMemberRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerKickUnionMemberRequest value)
		{
			InnerKickUnionMemberRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long TargetUserId { get; set; }

	[MemoryPackOrder(1)]
	public long UnionId { get; set; }

	public static InnerKickUnionMemberRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerKickUnionMemberRequest)) as InnerKickUnionMemberRequest;
		}
		return new InnerKickUnionMemberRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			TargetUserId = 0L;
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerKickUnionMemberRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerKickUnionMemberRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerKickUnionMemberRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerKickUnionMemberRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerKickUnionMemberRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerKickUnionMemberRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, long>(5, value.IsFromPool, value.TargetUserId, value.UnionId, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerKickUnionMemberRequest? value)
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
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				value4 = value.UnionId;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, long, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerKickUnionMemberRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				value4 = value.UnionId;
				value5 = value.RpcId;
				value6 = value.UserId;
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
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011a;
			}
		}
		value = new InnerKickUnionMemberRequest
		{
			IsFromPool = value2,
			TargetUserId = value3,
			UnionId = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.TargetUserId = value3;
		value.UnionId = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
