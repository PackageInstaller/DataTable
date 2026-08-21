using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10748)]
[MemoryPackable(GenerateType.Object)]
public class BattleReceiveEmoteNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattleReceiveEmoteNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleReceiveEmoteNotifyFormatter : MemoryPackFormatter<BattleReceiveEmoteNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleReceiveEmoteNotify value)
		{
			BattleReceiveEmoteNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleReceiveEmoteNotify value)
		{
			BattleReceiveEmoteNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long BattleActorId { get; set; }

	[MemoryPackOrder(1)]
	public int Index { get; set; }

	public static BattleReceiveEmoteNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleReceiveEmoteNotify)) as BattleReceiveEmoteNotify;
		}
		return new BattleReceiveEmoteNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			BattleActorId = 0L;
			Index = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleReceiveEmoteNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleReceiveEmoteNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattleReceiveEmoteNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleReceiveEmoteNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleReceiveEmoteNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleReceiveEmoteNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(4, value.IsFromPool, value.BattleActorId, value.Index, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleReceiveEmoteNotify? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleReceiveEmoteNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
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
				goto IL_00eb;
			}
		}
		value = new BattleReceiveEmoteNotify
		{
			IsFromPool = value2,
			BattleActorId = value3,
			Index = value4,
			ActorId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.BattleActorId = value3;
		value.Index = value4;
		value.ActorId = value5;
	}
}
