using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1111)]
[MemoryPackable(GenerateType.Object)]
public class InnerQuickJoinRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerQuickJoinRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerQuickJoinRequestFormatter : MemoryPackFormatter<InnerQuickJoinRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerQuickJoinRequest value)
		{
			InnerQuickJoinRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerQuickJoinRequest value)
		{
			InnerQuickJoinRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int UserLevel { get; set; }

	public static InnerQuickJoinRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerQuickJoinRequest)) as InnerQuickJoinRequest;
		}
		return new InnerQuickJoinRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UserLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerQuickJoinRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerQuickJoinRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerQuickJoinRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerQuickJoinRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerQuickJoinRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerQuickJoinRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.UserLevel, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerQuickJoinRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserLevel;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerQuickJoinRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserLevel;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new InnerQuickJoinRequest
		{
			IsFromPool = value2,
			UserLevel = value3,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.UserLevel = value3;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
