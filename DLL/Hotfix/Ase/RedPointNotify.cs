using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10865)]
[MemoryPackable(GenerateType.Object)]
public class RedPointNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<RedPointNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RedPointNotifyFormatter : MemoryPackFormatter<RedPointNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RedPointNotify value)
		{
			RedPointNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RedPointNotify value)
		{
			RedPointNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(1)]
	public List<int> RedPoint { get; set; } = new List<int>();

	public static RedPointNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RedPointNotify)) as RedPointNotify;
		}
		return new RedPointNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			RedPoint.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RedPointNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RedPointNotify>())
		{
			MemoryPackFormatterProvider.Register(new RedPointNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RedPointNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RedPointNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RedPointNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		writer.WriteValue<List<int>>(value.RedPoint);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RedPointNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RedPoint;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00ca;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RedPointNotify), 3, memberCount);
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
				value3 = value.RedPoint;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
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
		value = new RedPointNotify
		{
			IsFromPool = value2,
			RedPoint = value3,
			ActorId = value4
		};
		return;
		IL_00ca:
		value.IsFromPool = value2;
		value.RedPoint = value3;
		value.ActorId = value4;
	}
}
