using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10519)]
[MemoryPackable(GenerateType.Object)]
public class TestClientNotificationMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<TestClientNotificationMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TestClientNotificationMessageFormatter : MemoryPackFormatter<TestClientNotificationMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TestClientNotificationMessage value)
		{
			TestClientNotificationMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TestClientNotificationMessage value)
		{
			TestClientNotificationMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public long UserId { get; set; }

	public static TestClientNotificationMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TestClientNotificationMessage)) as TestClientNotificationMessage;
		}
		return new TestClientNotificationMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TestClientNotificationMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TestClientNotificationMessage>())
		{
			MemoryPackFormatterProvider.Register(new TestClientNotificationMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TestClientNotificationMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TestClientNotificationMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TestClientNotificationMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long>(4, value.IsFromPool, value.LoginServerId, value.LoginSecretKey, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TestClientNotificationMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, int, long, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TestClientNotificationMessage), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
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
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_00eb;
			}
		}
		value = new TestClientNotificationMessage
		{
			IsFromPool = value2,
			LoginServerId = value3,
			LoginSecretKey = value4,
			UserId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.UserId = value5;
	}
}
