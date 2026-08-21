using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1137)]
[MemoryPackable(GenerateType.Object)]
public class InnerChatMessageNotify : MessageObject, IRequest, IMessage, IMemoryPackable<InnerChatMessageNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerChatMessageNotifyFormatter : MemoryPackFormatter<InnerChatMessageNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerChatMessageNotify value)
		{
			InnerChatMessageNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerChatMessageNotify value)
		{
			InnerChatMessageNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int MessageOpcode { get; set; }

	[MemoryPackOrder(2)]
	public byte[] MessageBytes { get; set; }

	public static InnerChatMessageNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerChatMessageNotify)) as InnerChatMessageNotify;
		}
		return new InnerChatMessageNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			MessageOpcode = 0;
			MessageBytes = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerChatMessageNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatMessageNotify>())
		{
			MemoryPackFormatterProvider.Register(new InnerChatMessageNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatMessageNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerChatMessageNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<byte[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<byte>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerChatMessageNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.MessageOpcode);
		writer.WriteUnmanagedArray(value.MessageBytes);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerChatMessageNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		byte[] value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MessageOpcode;
				value4 = value.MessageBytes;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanagedArray(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadUnmanagedArray<byte>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerChatMessageNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MessageOpcode;
				value4 = value.MessageBytes;
				value5 = value.RpcId;
				value6 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanagedArray(ref value4);
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
				goto IL_0123;
			}
		}
		value = new InnerChatMessageNotify
		{
			IsFromPool = value2,
			MessageOpcode = value3,
			MessageBytes = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.MessageOpcode = value3;
		value.MessageBytes = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
