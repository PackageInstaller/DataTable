using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1127)]
[MemoryPackable(GenerateType.Object)]
public class InnerGoldFingerRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerGoldFingerRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGoldFingerRequestFormatter : MemoryPackFormatter<InnerGoldFingerRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGoldFingerRequest value)
		{
			InnerGoldFingerRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGoldFingerRequest value)
		{
			InnerGoldFingerRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long TargetUserId { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	public static InnerGoldFingerRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGoldFingerRequest)) as InnerGoldFingerRequest;
		}
		return new InnerGoldFingerRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			TargetUserId = 0L;
			Content = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGoldFingerRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGoldFingerRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerGoldFingerRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGoldFingerRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGoldFingerRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGoldFingerRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.TargetUserId);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGoldFingerRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string content;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				content = value.Content;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				content = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			content = reader.ReadString();
			reader.ReadUnmanaged<int>(out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGoldFingerRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				content = null;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				content = value.Content;
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
						content = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new InnerGoldFingerRequest
		{
			IsFromPool = value2,
			TargetUserId = value3,
			Content = content,
			RpcId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.TargetUserId = value3;
		value.Content = content;
		value.RpcId = value4;
	}
}
