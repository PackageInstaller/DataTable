using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1131)]
[MemoryPackable(GenerateType.Object)]
public class InnerChatCheckRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerChatCheckRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerChatCheckRequestFormatter : MemoryPackFormatter<InnerChatCheckRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerChatCheckRequest value)
		{
			InnerChatCheckRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerChatCheckRequest value)
		{
			InnerChatCheckRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public bool IsCheck { get; set; }

	public static InnerChatCheckRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerChatCheckRequest)) as InnerChatCheckRequest;
		}
		return new InnerChatCheckRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			IsCheck = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerChatCheckRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatCheckRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerChatCheckRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatCheckRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerChatCheckRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerChatCheckRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, bool, int>(4, value.IsFromPool, value.UserId, value.IsCheck, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerChatCheckRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		bool value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.IsCheck;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, long, bool, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerChatCheckRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = false;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.IsCheck;
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
						reader.ReadUnmanaged<bool>(out value4);
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
				goto IL_00ea;
			}
		}
		value = new InnerChatCheckRequest
		{
			IsFromPool = value2,
			UserId = value3,
			IsCheck = value4,
			RpcId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.IsCheck = value4;
		value.RpcId = value5;
	}
}
