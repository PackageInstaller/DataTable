using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10161)]
[MemoryPackable(GenerateType.Object)]
public class S2C_Global_LoadSuccess : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_Global_LoadSuccess>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_Global_LoadSuccessFormatter : MemoryPackFormatter<S2C_Global_LoadSuccess>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_Global_LoadSuccess value)
		{
			S2C_Global_LoadSuccess.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_Global_LoadSuccess value)
		{
			S2C_Global_LoadSuccess.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int SeatId { get; set; }

	public static S2C_Global_LoadSuccess Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_Global_LoadSuccess)) as S2C_Global_LoadSuccess;
		}
		return new S2C_Global_LoadSuccess();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ActorId = 0L;
			SeatId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_Global_LoadSuccess()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_LoadSuccess>())
		{
			MemoryPackFormatterProvider.Register(new S2C_Global_LoadSuccessFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_LoadSuccess[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_Global_LoadSuccess>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_Global_LoadSuccess? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(6, value.IsFromPool, value.SeatId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_Global_LoadSuccess? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_Global_LoadSuccess), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				message = null;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
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
								message = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new S2C_Global_LoadSuccess
		{
			IsFromPool = value2,
			SeatId = value3,
			RpcId = value4,
			Error = value5,
			Message = message,
			ActorId = value6
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.SeatId = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
		value.ActorId = value6;
	}
}
