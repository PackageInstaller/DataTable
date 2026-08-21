using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10765)]
[MemoryPackable(GenerateType.Object)]
public class OpenMailAttachmentGiftPackResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<OpenMailAttachmentGiftPackResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class OpenMailAttachmentGiftPackResponseFormatter : MemoryPackFormatter<OpenMailAttachmentGiftPackResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref OpenMailAttachmentGiftPackResponse value)
		{
			OpenMailAttachmentGiftPackResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref OpenMailAttachmentGiftPackResponse value)
		{
			OpenMailAttachmentGiftPackResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(1)]
	public List<long> OpenedLids { get; set; } = new List<long>();

	public static OpenMailAttachmentGiftPackResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(OpenMailAttachmentGiftPackResponse)) as OpenMailAttachmentGiftPackResponse;
		}
		return new OpenMailAttachmentGiftPackResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			OpenedLids.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static OpenMailAttachmentGiftPackResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<OpenMailAttachmentGiftPackResponse>())
		{
			MemoryPackFormatterProvider.Register(new OpenMailAttachmentGiftPackResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<OpenMailAttachmentGiftPackResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<OpenMailAttachmentGiftPackResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref OpenMailAttachmentGiftPackResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteValue<List<long>>(value.OpenedLids);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref OpenMailAttachmentGiftPackResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		List<long> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.OpenedLids;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			value4 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(OpenMailAttachmentGiftPackResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.OpenedLids;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_015b;
			}
		}
		value = new OpenMailAttachmentGiftPackResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			OpenedLids = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.OpenedLids = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
