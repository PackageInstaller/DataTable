using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1143)]
[MemoryPackable(GenerateType.Object)]
public class InnerSendMailToClusterUserRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerSendMailToClusterUserRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerSendMailToClusterUserRequestFormatter : MemoryPackFormatter<InnerSendMailToClusterUserRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerSendMailToClusterUserRequest value)
		{
			InnerSendMailToClusterUserRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerSendMailToClusterUserRequest value)
		{
			InnerSendMailToClusterUserRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Attachment { get; set; }

	[MemoryPackOrder(2)]
	public string Title { get; set; }

	[MemoryPackOrder(3)]
	public string Content { get; set; }

	public static InnerSendMailToClusterUserRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerSendMailToClusterUserRequest)) as InnerSendMailToClusterUserRequest;
		}
		return new InnerSendMailToClusterUserRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Attachment = null;
			Title = null;
			Content = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerSendMailToClusterUserRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSendMailToClusterUserRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerSendMailToClusterUserRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSendMailToClusterUserRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerSendMailToClusterUserRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerSendMailToClusterUserRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(7, value.IsFromPool, value.UserId);
		writer.WriteString(value.Attachment);
		writer.WriteString(value.Title);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerSendMailToClusterUserRequest? value)
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
		string attachment;
		string title;
		string content;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				attachment = value.Attachment;
				title = value.Title;
				content = value.Content;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				attachment = reader.ReadString();
				title = reader.ReadString();
				content = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0187;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			attachment = reader.ReadString();
			title = reader.ReadString();
			content = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerSendMailToClusterUserRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				attachment = null;
				title = null;
				content = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				attachment = value.Attachment;
				title = value.Title;
				content = value.Content;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						attachment = reader.ReadString();
						if (memberCount != 3)
						{
							title = reader.ReadString();
							if (memberCount != 4)
							{
								content = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value4);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value5);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0187;
			}
		}
		value = new InnerSendMailToClusterUserRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Attachment = attachment,
			Title = title,
			Content = content,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_0187:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Attachment = attachment;
		value.Title = title;
		value.Content = content;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
