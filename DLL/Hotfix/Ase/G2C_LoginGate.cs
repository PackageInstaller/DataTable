using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10002)]
[MemoryPackable(GenerateType.Object)]
public class G2C_LoginGate : MessageObject, IResponse, IMessage, IMemoryPackable<G2C_LoginGate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_LoginGateFormatter : MemoryPackFormatter<G2C_LoginGate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_LoginGate value)
		{
			G2C_LoginGate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_LoginGate value)
		{
			G2C_LoginGate.Deserialize(ref reader, ref value);
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

	public static G2C_LoginGate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_LoginGate)) as G2C_LoginGate;
		}
		return new G2C_LoginGate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_LoginGate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginGate>())
		{
			MemoryPackFormatterProvider.Register(new G2C_LoginGateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginGate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_LoginGate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_LoginGate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(5, value.IsFromPool, value.UserId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_LoginGate? value)
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
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_011e;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_LoginGate), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.Error;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011e;
			}
		}
		value = new G2C_LoginGate
		{
			IsFromPool = value2,
			UserId = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011e:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
