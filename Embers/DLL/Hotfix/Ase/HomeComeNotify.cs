using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10895)]
[MemoryPackable(GenerateType.Object)]
public class HomeComeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<HomeComeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HomeComeNotifyFormatter : MemoryPackFormatter<HomeComeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HomeComeNotify value)
		{
			HomeComeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HomeComeNotify value)
		{
			HomeComeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public bool IsInReturn { get; set; }

	public static HomeComeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HomeComeNotify)) as HomeComeNotify;
		}
		return new HomeComeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			IsInReturn = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HomeComeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HomeComeNotify>())
		{
			MemoryPackFormatterProvider.Register(new HomeComeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HomeComeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HomeComeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HomeComeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, bool, int, long>(4, value.IsFromPool, value.IsInReturn, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HomeComeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.IsInReturn;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, bool, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HomeComeNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.IsInReturn;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
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
		value = new HomeComeNotify
		{
			IsFromPool = value2,
			IsInReturn = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.IsInReturn = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
