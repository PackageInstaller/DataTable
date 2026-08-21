using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10614)]
[MemoryPackable(GenerateType.Object)]
public class CopyEnterLimitChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<CopyEnterLimitChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CopyEnterLimitChangeNotifyFormatter : MemoryPackFormatter<CopyEnterLimitChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CopyEnterLimitChangeNotify value)
		{
			CopyEnterLimitChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CopyEnterLimitChangeNotify value)
		{
			CopyEnterLimitChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbCopyEnterLimit NewCopyEnterLimit { get; set; }

	public static CopyEnterLimitChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CopyEnterLimitChangeNotify)) as CopyEnterLimitChangeNotify;
		}
		return new CopyEnterLimitChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			NewCopyEnterLimit = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CopyEnterLimitChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CopyEnterLimitChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new CopyEnterLimitChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CopyEnterLimitChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CopyEnterLimitChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CopyEnterLimitChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		writer.WritePackable<PbCopyEnterLimit>(value.NewCopyEnterLimit);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CopyEnterLimitChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbCopyEnterLimit value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NewCopyEnterLimit;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00ca;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbCopyEnterLimit>();
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CopyEnterLimitChangeNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.NewCopyEnterLimit;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00ca;
			}
		}
		value = new CopyEnterLimitChangeNotify
		{
			IsFromPool = value2,
			NewCopyEnterLimit = value3,
			ActorId = value4
		};
		return;
		IL_00ca:
		value.IsFromPool = value2;
		value.NewCopyEnterLimit = value3;
		value.ActorId = value4;
	}
}
