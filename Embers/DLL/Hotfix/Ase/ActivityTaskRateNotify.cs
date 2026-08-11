using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10174)]
[MemoryPackable(GenerateType.Object)]
public class ActivityTaskRateNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ActivityTaskRateNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ActivityTaskRateNotifyFormatter : MemoryPackFormatter<ActivityTaskRateNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ActivityTaskRateNotify value)
		{
			ActivityTaskRateNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ActivityTaskRateNotify value)
		{
			ActivityTaskRateNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int TaskType { get; set; }

	[MemoryPackOrder(2)]
	public int DoneValue { get; set; }

	[MemoryPackOrder(3)]
	public bool IsCompleted { get; set; }

	[MemoryPackOrder(4)]
	public int ActivityType { get; set; }

	public static ActivityTaskRateNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ActivityTaskRateNotify)) as ActivityTaskRateNotify;
		}
		return new ActivityTaskRateNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Id = 0;
			TaskType = 0;
			DoneValue = 0;
			IsCompleted = false;
			ActivityType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ActivityTaskRateNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ActivityTaskRateNotify>())
		{
			MemoryPackFormatterProvider.Register(new ActivityTaskRateNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ActivityTaskRateNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ActivityTaskRateNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ActivityTaskRateNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, bool, int, int, long>(8, value.IsFromPool, value.Id, value.TaskType, value.DoneValue, value.IsCompleted, value.ActivityType, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ActivityTaskRateNotify? value)
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
		bool value6;
		int value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.TaskType;
				value5 = value.DoneValue;
				value6 = value.IsCompleted;
				value7 = value.ActivityType;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019c;
			}
			reader.ReadUnmanaged<bool, int, int, int, bool, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ActivityTaskRateNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = false;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.TaskType;
				value5 = value.DoneValue;
				value6 = value.IsCompleted;
				value7 = value.ActivityType;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_019c;
			}
		}
		value = new ActivityTaskRateNotify
		{
			IsFromPool = value2,
			Id = value3,
			TaskType = value4,
			DoneValue = value5,
			IsCompleted = value6,
			ActivityType = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_019c:
		value.IsFromPool = value2;
		value.Id = value3;
		value.TaskType = value4;
		value.DoneValue = value5;
		value.IsCompleted = value6;
		value.ActivityType = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
