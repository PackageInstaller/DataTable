using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1119)]
[MemoryPackable(GenerateType.Object)]
public class InnerUnionChatRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUnionChatRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUnionChatRequestFormatter : MemoryPackFormatter<InnerUnionChatRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUnionChatRequest value)
		{
			InnerUnionChatRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUnionChatRequest value)
		{
			InnerUnionChatRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public PbChatUserInfo UserInfo { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	public static InnerUnionChatRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUnionChatRequest)) as InnerUnionChatRequest;
		}
		return new InnerUnionChatRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UserInfo = null;
			Content = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUnionChatRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUnionChatRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUnionChatRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUnionChatRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUnionChatRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUnionChatRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUnionChatRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbChatUserInfo value3;
		int value4;
		long value5;
		string content;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfo;
				content = value.Content;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				content = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0126;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbChatUserInfo>();
			content = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUnionChatRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				content = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfo;
				content = value.Content;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						content = reader.ReadString();
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
				goto IL_0126;
			}
		}
		value = new InnerUnionChatRequest
		{
			IsFromPool = value2,
			UserInfo = value3,
			Content = content,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_0126:
		value.IsFromPool = value2;
		value.UserInfo = value3;
		value.Content = content;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
