using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10542)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightUserLeaveHalfwayNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightUserLeaveHalfwayNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightUserLeaveHalfwayNotifyFormatter : MemoryPackFormatter<MultiFightUserLeaveHalfwayNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightUserLeaveHalfwayNotify value)
		{
			MultiFightUserLeaveHalfwayNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightUserLeaveHalfwayNotify value)
		{
			MultiFightUserLeaveHalfwayNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	public static MultiFightUserLeaveHalfwayNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightUserLeaveHalfwayNotify)) as MultiFightUserLeaveHalfwayNotify;
		}
		return new MultiFightUserLeaveHalfwayNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			UserId = 0L;
			Name = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightUserLeaveHalfwayNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightUserLeaveHalfwayNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightUserLeaveHalfwayNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightUserLeaveHalfwayNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightUserLeaveHalfwayNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightUserLeaveHalfwayNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightUserLeaveHalfwayNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		string name;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightUserLeaveHalfwayNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new MultiFightUserLeaveHalfwayNotify
		{
			IsFromPool = value2,
			UserId = value3,
			Name = name,
			ActorId = value4
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Name = name;
		value.ActorId = value4;
	}
}
