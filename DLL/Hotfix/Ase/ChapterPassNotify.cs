using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10143)]
[MemoryPackable(GenerateType.Object)]
public class ChapterPassNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ChapterPassNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ChapterPassNotifyFormatter : MemoryPackFormatter<ChapterPassNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ChapterPassNotify value)
		{
			ChapterPassNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ChapterPassNotify value)
		{
			ChapterPassNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int ChapterId { get; set; }

	public static ChapterPassNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ChapterPassNotify)) as ChapterPassNotify;
		}
		return new ChapterPassNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			ChapterId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ChapterPassNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ChapterPassNotify>())
		{
			MemoryPackFormatterProvider.Register(new ChapterPassNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ChapterPassNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ChapterPassNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ChapterPassNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.ChapterId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ChapterPassNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ChapterId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ChapterPassNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ChapterId;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_00ea;
			}
		}
		value = new ChapterPassNotify
		{
			IsFromPool = value2,
			ChapterId = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.ChapterId = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
