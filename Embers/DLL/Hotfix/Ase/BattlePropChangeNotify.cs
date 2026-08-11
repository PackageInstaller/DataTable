using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10551)]
[MemoryPackable(GenerateType.Object)]
public class BattlePropChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattlePropChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattlePropChangeNotifyFormatter : MemoryPackFormatter<BattlePropChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattlePropChangeNotify value)
		{
			BattlePropChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattlePropChangeNotify value)
		{
			BattlePropChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	[MemoryPackOrder(2)]
	public int Count { get; set; }

	public static BattlePropChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattlePropChangeNotify)) as BattlePropChangeNotify;
		}
		return new BattlePropChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			Id = 0;
			Level = 0;
			Count = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattlePropChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattlePropChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattlePropChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattlePropChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattlePropChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattlePropChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long>(5, value.IsFromPool, value.Id, value.Level, value.Count, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattlePropChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Level;
				value5 = value.Count;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0118;
			}
			reader.ReadUnmanaged<bool, int, int, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattlePropChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Level;
				value5 = value.Count;
				value6 = value.ActorId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0118;
			}
		}
		value = new BattlePropChangeNotify
		{
			IsFromPool = value2,
			Id = value3,
			Level = value4,
			Count = value5,
			ActorId = value6
		};
		return;
		IL_0118:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Level = value4;
		value.Count = value5;
		value.ActorId = value6;
	}
}
