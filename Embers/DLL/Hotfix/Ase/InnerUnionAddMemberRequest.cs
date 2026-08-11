using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1098)]
[MemoryPackable(GenerateType.Object)]
public class InnerUnionAddMemberRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUnionAddMemberRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUnionAddMemberRequestFormatter : MemoryPackFormatter<InnerUnionAddMemberRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUnionAddMemberRequest value)
		{
			InnerUnionAddMemberRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUnionAddMemberRequest value)
		{
			InnerUnionAddMemberRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public List<long> UserId { get; set; } = new List<long>();

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	public static InnerUnionAddMemberRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUnionAddMemberRequest)) as InnerUnionAddMemberRequest;
		}
		return new InnerUnionAddMemberRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId.Clear();
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUnionAddMemberRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUnionAddMemberRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUnionAddMemberRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUnionAddMemberRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUnionAddMemberRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUnionAddMemberRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(4, value.IsFromPool, value.UnionId, value.RpcId);
		writer.WriteValue<List<long>>(value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUnionAddMemberRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		List<long> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadValue(ref value5);
				goto IL_00f0;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<long>>();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUnionAddMemberRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f0;
			}
		}
		value = new InnerUnionAddMemberRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_00f0:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
