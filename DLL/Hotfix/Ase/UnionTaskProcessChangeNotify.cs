using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10720)]
[MemoryPackable(GenerateType.Object)]
public class UnionTaskProcessChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionTaskProcessChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionTaskProcessChangeNotifyFormatter : MemoryPackFormatter<UnionTaskProcessChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionTaskProcessChangeNotify value)
		{
			UnionTaskProcessChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionTaskProcessChangeNotify value)
		{
			UnionTaskProcessChangeNotify.Deserialize(ref reader, ref value);
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

	public static UnionTaskProcessChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionTaskProcessChangeNotify)) as UnionTaskProcessChangeNotify;
		}
		return new UnionTaskProcessChangeNotify();
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

	static UnionTaskProcessChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskProcessChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionTaskProcessChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskProcessChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionTaskProcessChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionTaskProcessChangeNotify? value)
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
	public static void Deserialize(ref MemoryPackReader reader, ref UnionTaskProcessChangeNotify? value)
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionTaskProcessChangeNotify), 5, memberCount);
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
		value = new UnionTaskProcessChangeNotify
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
