using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10780)]
[MemoryPackable(GenerateType.Object)]
public class ActiveTaskProcessChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ActiveTaskProcessChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ActiveTaskProcessChangeNotifyFormatter : MemoryPackFormatter<ActiveTaskProcessChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ActiveTaskProcessChangeNotify value)
		{
			ActiveTaskProcessChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ActiveTaskProcessChangeNotify value)
		{
			ActiveTaskProcessChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	public static ActiveTaskProcessChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ActiveTaskProcessChangeNotify)) as ActiveTaskProcessChangeNotify;
		}
		return new ActiveTaskProcessChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			TaskId = 0;
			Value = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ActiveTaskProcessChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ActiveTaskProcessChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new ActiveTaskProcessChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ActiveTaskProcessChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ActiveTaskProcessChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ActiveTaskProcessChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long>(5, value.IsFromPool, value.TaskId, value.Value, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ActiveTaskProcessChangeNotify? value)
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
				value3 = value.TaskId;
				value4 = value.Value;
				value5 = value.RpcId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ActiveTaskProcessChangeNotify), 5, memberCount);
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
				value3 = value.TaskId;
				value4 = value.Value;
				value5 = value.RpcId;
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
		value = new ActiveTaskProcessChangeNotify
		{
			IsFromPool = value2,
			TaskId = value3,
			Value = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0118:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.Value = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
