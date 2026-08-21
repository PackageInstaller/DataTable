using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10570)]
[MemoryPackable(GenerateType.Object)]
public class FarmGridChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<FarmGridChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class FarmGridChangeNotifyFormatter : MemoryPackFormatter<FarmGridChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref FarmGridChangeNotify value)
		{
			FarmGridChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref FarmGridChangeNotify value)
		{
			FarmGridChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int GirdId { get; set; }

	[MemoryPackOrder(1)]
	public int State { get; set; }

	public static FarmGridChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(FarmGridChangeNotify)) as FarmGridChangeNotify;
		}
		return new FarmGridChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			GirdId = 0;
			State = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static FarmGridChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<FarmGridChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new FarmGridChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<FarmGridChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<FarmGridChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref FarmGridChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.GirdId, value.State, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref FarmGridChangeNotify? value)
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
				value3 = value.GirdId;
				value4 = value.State;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(FarmGridChangeNotify), 4, memberCount);
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
				value3 = value.GirdId;
				value4 = value.State;
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
		value = new FarmGridChangeNotify
		{
			IsFromPool = value2,
			GirdId = value3,
			State = value4,
			ActorId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.GirdId = value3;
		value.State = value4;
		value.ActorId = value5;
	}
}
