using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10018)]
[MemoryPackable(GenerateType.Object)]
public class M2C_RoomDispose : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<M2C_RoomDispose>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2C_RoomDisposeFormatter : MemoryPackFormatter<M2C_RoomDispose>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2C_RoomDispose value)
		{
			M2C_RoomDispose.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2C_RoomDispose value)
		{
			M2C_RoomDispose.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	public static M2C_RoomDispose Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2C_RoomDispose)) as M2C_RoomDispose;
		}
		return new M2C_RoomDispose();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2C_RoomDispose()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_RoomDispose>())
		{
			MemoryPackFormatterProvider.Register(new M2C_RoomDisposeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_RoomDispose[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2C_RoomDispose>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2C_RoomDispose? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(4, value.IsFromPool, value.RoomId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2C_RoomDispose? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2C_RoomDispose), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.RpcId;
				value5 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00eb;
			}
		}
		value = new M2C_RoomDispose
		{
			IsFromPool = value2,
			RoomId = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
