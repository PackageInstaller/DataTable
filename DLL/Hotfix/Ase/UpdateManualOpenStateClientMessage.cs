using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10768)]
[MemoryPackable(GenerateType.Object)]
public class UpdateManualOpenStateClientMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<UpdateManualOpenStateClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UpdateManualOpenStateClientMessageFormatter : MemoryPackFormatter<UpdateManualOpenStateClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UpdateManualOpenStateClientMessage value)
		{
			UpdateManualOpenStateClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UpdateManualOpenStateClientMessage value)
		{
			UpdateManualOpenStateClientMessage.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public List<int> Idxs { get; set; } = new List<int>();

	public static UpdateManualOpenStateClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UpdateManualOpenStateClientMessage)) as UpdateManualOpenStateClientMessage;
		}
		return new UpdateManualOpenStateClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Idxs.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UpdateManualOpenStateClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateManualOpenStateClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new UpdateManualOpenStateClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateManualOpenStateClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UpdateManualOpenStateClientMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UpdateManualOpenStateClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteValue<List<int>>(value.Idxs);
		writer.WriteUnmanaged<int, long, int, long, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UpdateManualOpenStateClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		int value4;
		long value5;
		int value6;
		long value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Idxs;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, long, int, long, long>(out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UpdateManualOpenStateClientMessage), 7, memberCount);
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
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Idxs;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
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
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
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
				goto IL_017e;
			}
		}
		value = new UpdateManualOpenStateClientMessage
		{
			IsFromPool = value2,
			Idxs = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7,
			UserId = value8
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.Idxs = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
		value.UserId = value8;
	}
}
