using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10812)]
[MemoryPackable(GenerateType.Object)]
public class UnionMemberPositionChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionMemberPositionChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionMemberPositionChangeNotifyFormatter : MemoryPackFormatter<UnionMemberPositionChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionMemberPositionChangeNotify value)
		{
			UnionMemberPositionChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionMemberPositionChangeNotify value)
		{
			UnionMemberPositionChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long NewPosition { get; set; }

	public static UnionMemberPositionChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionMemberPositionChangeNotify)) as UnionMemberPositionChangeNotify;
		}
		return new UnionMemberPositionChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			NewPosition = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionMemberPositionChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionMemberPositionChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionMemberPositionChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionMemberPositionChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionMemberPositionChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionMemberPositionChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long>(3, value.IsFromPool, value.NewPosition, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionMemberPositionChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NewPosition;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00c0;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionMemberPositionChangeNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.NewPosition;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c0;
			}
		}
		value = new UnionMemberPositionChangeNotify
		{
			IsFromPool = value2,
			NewPosition = value3,
			ActorId = value4
		};
		return;
		IL_00c0:
		value.IsFromPool = value2;
		value.NewPosition = value3;
		value.ActorId = value4;
	}
}
