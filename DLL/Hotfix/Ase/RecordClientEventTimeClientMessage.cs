using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10545)]
[MemoryPackable(GenerateType.Object)]
public class RecordClientEventTimeClientMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<RecordClientEventTimeClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RecordClientEventTimeClientMessageFormatter : MemoryPackFormatter<RecordClientEventTimeClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RecordClientEventTimeClientMessage value)
		{
			RecordClientEventTimeClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RecordClientEventTimeClientMessage value)
		{
			RecordClientEventTimeClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(89)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int EventType { get; set; }

	[MemoryPackOrder(1)]
	public long RecordTime { get; set; }

	public static RecordClientEventTimeClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RecordClientEventTimeClientMessage)) as RecordClientEventTimeClientMessage;
		}
		return new RecordClientEventTimeClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			EventType = 0;
			RecordTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RecordClientEventTimeClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RecordClientEventTimeClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new RecordClientEventTimeClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RecordClientEventTimeClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RecordClientEventTimeClientMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RecordClientEventTimeClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long, long, long>(7, value.IsFromPool, value.EventType, value.RecordTime, value.LoginServerId, value.LoginSecretKey, value.ActorId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RecordClientEventTimeClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		long value6;
		long value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EventType;
				value4 = value.RecordTime;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
				value8 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0174;
			}
			reader.ReadUnmanaged<bool, int, long, int, long, long, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RecordClientEventTimeClientMessage), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EventType;
				value4 = value.RecordTime;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
				value8 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
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
				goto IL_0174;
			}
		}
		value = new RecordClientEventTimeClientMessage
		{
			IsFromPool = value2,
			EventType = value3,
			RecordTime = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			ActorId = value7,
			UserId = value8
		};
		return;
		IL_0174:
		value.IsFromPool = value2;
		value.EventType = value3;
		value.RecordTime = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.ActorId = value7;
		value.UserId = value8;
	}
}
