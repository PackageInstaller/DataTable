using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10829)]
[MemoryPackable(GenerateType.Object)]
public class EmojiUnlockNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<EmojiUnlockNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class EmojiUnlockNotifyFormatter : MemoryPackFormatter<EmojiUnlockNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref EmojiUnlockNotify value)
		{
			EmojiUnlockNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref EmojiUnlockNotify value)
		{
			EmojiUnlockNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int EmojiId { get; set; }

	public static EmojiUnlockNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(EmojiUnlockNotify)) as EmojiUnlockNotify;
		}
		return new EmojiUnlockNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			EmojiId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static EmojiUnlockNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<EmojiUnlockNotify>())
		{
			MemoryPackFormatterProvider.Register(new EmojiUnlockNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<EmojiUnlockNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<EmojiUnlockNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref EmojiUnlockNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.EmojiId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref EmojiUnlockNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EmojiId;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(EmojiUnlockNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EmojiId;
				value4 = value.ActorId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new EmojiUnlockNotify
		{
			IsFromPool = value2,
			EmojiId = value3,
			ActorId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.EmojiId = value3;
		value.ActorId = value4;
	}
}
