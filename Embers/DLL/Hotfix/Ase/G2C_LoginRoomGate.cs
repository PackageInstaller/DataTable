using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10051)]
[MemoryPackable(GenerateType.Object)]
public class G2C_LoginRoomGate : MessageObject, IResponse, IMessage, IMemoryPackable<G2C_LoginRoomGate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_LoginRoomGateFormatter : MemoryPackFormatter<G2C_LoginRoomGate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_LoginRoomGate value)
		{
			G2C_LoginRoomGate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_LoginRoomGate value)
		{
			G2C_LoginRoomGate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long PlayerId { get; set; }

	public static G2C_LoginRoomGate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_LoginRoomGate)) as G2C_LoginRoomGate;
		}
		return new G2C_LoginRoomGate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			PlayerId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_LoginRoomGate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginRoomGate>())
		{
			MemoryPackFormatterProvider.Register(new G2C_LoginRoomGateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginRoomGate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_LoginRoomGate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_LoginRoomGate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int>(6, value.IsFromPool, value.UserId, value.PlayerId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_LoginRoomGate? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.PlayerId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014d;
			}
			reader.ReadUnmanaged<bool, long, long, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_LoginRoomGate), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.PlayerId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014d;
			}
		}
		value = new G2C_LoginRoomGate
		{
			IsFromPool = value2,
			UserId = value3,
			PlayerId = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014d:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.PlayerId = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
