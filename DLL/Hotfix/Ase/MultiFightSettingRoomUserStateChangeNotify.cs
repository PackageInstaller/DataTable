using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10499)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightSettingRoomUserStateChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightSettingRoomUserStateChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightSettingRoomUserStateChangeNotifyFormatter : MemoryPackFormatter<MultiFightSettingRoomUserStateChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightSettingRoomUserStateChangeNotify value)
		{
			MultiFightSettingRoomUserStateChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightSettingRoomUserStateChangeNotify value)
		{
			MultiFightSettingRoomUserStateChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int State { get; set; }

	public static MultiFightSettingRoomUserStateChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightSettingRoomUserStateChangeNotify)) as MultiFightSettingRoomUserStateChangeNotify;
		}
		return new MultiFightSettingRoomUserStateChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			State = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightSettingRoomUserStateChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightSettingRoomUserStateChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightSettingRoomUserStateChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightSettingRoomUserStateChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightSettingRoomUserStateChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightSettingRoomUserStateChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long>(5, value.IsFromPool, value.UserId, value.State, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightSettingRoomUserStateChangeNotify? value)
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
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.State;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, int, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightSettingRoomUserStateChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.State;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new MultiFightSettingRoomUserStateChangeNotify
		{
			IsFromPool = value2,
			UserId = value3,
			State = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.State = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
