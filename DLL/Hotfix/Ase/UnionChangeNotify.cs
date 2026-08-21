using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10698)]
[MemoryPackable(GenerateType.Object)]
public class UnionChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionChangeNotifyFormatter : MemoryPackFormatter<UnionChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionChangeNotify value)
		{
			UnionChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionChangeNotify value)
		{
			UnionChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public int ChangeState { get; set; }

	[MemoryPackOrder(2)]
	public int Reason { get; set; }

	public static UnionChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionChangeNotify)) as UnionChangeNotify;
		}
		return new UnionChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UnionId = 0L;
			ChangeState = 0;
			Reason = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, long>(6, value.IsFromPool, value.UnionId, value.ChangeState, value.Reason, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.ChangeState;
				value5 = value.Reason;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0147;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionChangeNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.ChangeState;
				value5 = value.Reason;
				value6 = value.RpcId;
				value7 = value.ActorId;
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
							reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0147;
			}
		}
		value = new UnionChangeNotify
		{
			IsFromPool = value2,
			UnionId = value3,
			ChangeState = value4,
			Reason = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0147:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.ChangeState = value4;
		value.Reason = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
