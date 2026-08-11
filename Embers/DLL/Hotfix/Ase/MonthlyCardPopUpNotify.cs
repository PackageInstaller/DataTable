using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10789)]
[MemoryPackable(GenerateType.Object)]
public class MonthlyCardPopUpNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MonthlyCardPopUpNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MonthlyCardPopUpNotifyFormatter : MemoryPackFormatter<MonthlyCardPopUpNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MonthlyCardPopUpNotify value)
		{
			MonthlyCardPopUpNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MonthlyCardPopUpNotify value)
		{
			MonthlyCardPopUpNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	public static MonthlyCardPopUpNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MonthlyCardPopUpNotify)) as MonthlyCardPopUpNotify;
		}
		return new MonthlyCardPopUpNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MonthlyCardPopUpNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MonthlyCardPopUpNotify>())
		{
			MemoryPackFormatterProvider.Register(new MonthlyCardPopUpNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MonthlyCardPopUpNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MonthlyCardPopUpNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MonthlyCardPopUpNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MonthlyCardPopUpNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MonthlyCardPopUpNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new MonthlyCardPopUpNotify
		{
			IsFromPool = value2,
			RpcId = value3,
			ActorId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.ActorId = value4;
	}
}
