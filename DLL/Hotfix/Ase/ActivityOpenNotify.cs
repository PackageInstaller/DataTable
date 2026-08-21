using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10786)]
[MemoryPackable(GenerateType.Object)]
public class ActivityOpenNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ActivityOpenNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ActivityOpenNotifyFormatter : MemoryPackFormatter<ActivityOpenNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ActivityOpenNotify value)
		{
			ActivityOpenNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ActivityOpenNotify value)
		{
			ActivityOpenNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int ActivityType { get; set; }

	[MemoryPackOrder(1)]
	public bool Open { get; set; }

	[MemoryPackOrder(2)]
	public bool Unlock { get; set; }

	public static ActivityOpenNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ActivityOpenNotify)) as ActivityOpenNotify;
		}
		return new ActivityOpenNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			ActivityType = 0;
			Open = false;
			Unlock = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ActivityOpenNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ActivityOpenNotify>())
		{
			MemoryPackFormatterProvider.Register(new ActivityOpenNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ActivityOpenNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ActivityOpenNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ActivityOpenNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, bool, bool, int, long>(6, value.IsFromPool, value.ActivityType, value.Open, value.Unlock, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ActivityOpenNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		bool value4;
		bool value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.Open;
				value5 = value.Unlock;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0146;
			}
			reader.ReadUnmanaged<bool, int, bool, bool, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ActivityOpenNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = false;
				value5 = false;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.Open;
				value5 = value.Unlock;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0146;
			}
		}
		value = new ActivityOpenNotify
		{
			IsFromPool = value2,
			ActivityType = value3,
			Open = value4,
			Unlock = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0146:
		value.IsFromPool = value2;
		value.ActivityType = value3;
		value.Open = value4;
		value.Unlock = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
