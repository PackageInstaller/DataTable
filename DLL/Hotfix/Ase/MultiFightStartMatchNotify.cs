using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10430)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightStartMatchNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightStartMatchNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightStartMatchNotifyFormatter : MemoryPackFormatter<MultiFightStartMatchNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightStartMatchNotify value)
		{
			MultiFightStartMatchNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightStartMatchNotify value)
		{
			MultiFightStartMatchNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int ErrorCode { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public string PunishUserName { get; set; }

	[MemoryPackOrder(3)]
	public int PunishLeftTime { get; set; }

	public static MultiFightStartMatchNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightStartMatchNotify)) as MultiFightStartMatchNotify;
		}
		return new MultiFightStartMatchNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			ErrorCode = 0;
			RoomId = 0L;
			PunishUserName = null;
			PunishLeftTime = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightStartMatchNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartMatchNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightStartMatchNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartMatchNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightStartMatchNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightStartMatchNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(7, value.IsFromPool, value.ErrorCode, value.RoomId);
		writer.WriteString(value.PunishUserName);
		writer.WriteUnmanaged<int, int, long>(value.PunishLeftTime, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightStartMatchNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		int value6;
		long value7;
		string punishUserName;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ErrorCode;
				value4 = value.RoomId;
				punishUserName = value.PunishUserName;
				value5 = value.PunishLeftTime;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				punishUserName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			punishUserName = reader.ReadString();
			reader.ReadUnmanaged<int, int, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightStartMatchNotify), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				punishUserName = null;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ErrorCode;
				value4 = value.RoomId;
				punishUserName = value.PunishUserName;
				value5 = value.PunishLeftTime;
				value6 = value.RpcId;
				value7 = value.ActorId;
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
						if (memberCount != 3)
						{
							punishUserName = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value7);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017e;
			}
		}
		value = new MultiFightStartMatchNotify
		{
			IsFromPool = value2,
			ErrorCode = value3,
			RoomId = value4,
			PunishUserName = punishUserName,
			PunishLeftTime = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.ErrorCode = value3;
		value.RoomId = value4;
		value.PunishUserName = punishUserName;
		value.PunishLeftTime = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
