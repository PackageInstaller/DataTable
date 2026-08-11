using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10764)]
[MemoryPackable(GenerateType.Object)]
public class OpenMailAttachmentGiftPackRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<OpenMailAttachmentGiftPackRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class OpenMailAttachmentGiftPackRequestFormatter : MemoryPackFormatter<OpenMailAttachmentGiftPackRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref OpenMailAttachmentGiftPackRequest value)
		{
			OpenMailAttachmentGiftPackRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref OpenMailAttachmentGiftPackRequest value)
		{
			OpenMailAttachmentGiftPackRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbLongIntValue> Ids { get; set; } = new List<PbLongIntValue>();

	public static OpenMailAttachmentGiftPackRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(OpenMailAttachmentGiftPackRequest)) as OpenMailAttachmentGiftPackRequest;
		}
		return new OpenMailAttachmentGiftPackRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Ids.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static OpenMailAttachmentGiftPackRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<OpenMailAttachmentGiftPackRequest>())
		{
			MemoryPackFormatterProvider.Register(new OpenMailAttachmentGiftPackRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<OpenMailAttachmentGiftPackRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<OpenMailAttachmentGiftPackRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLongIntValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLongIntValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref OpenMailAttachmentGiftPackRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbLongIntValue>>(value.Ids));
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref OpenMailAttachmentGiftPackRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbLongIntValue> value3;
		int value4;
		long value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Ids;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbLongIntValue>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(OpenMailAttachmentGiftPackRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Ids;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0152;
			}
		}
		value = new OpenMailAttachmentGiftPackRequest
		{
			IsFromPool = value2,
			Ids = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.Ids = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
