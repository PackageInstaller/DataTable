using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1023)]
[MemoryPackable(GenerateType.Object)]
public class G2H_CreateUnit : MessageObject, IRequest, IMessage, IMemoryPackable<G2H_CreateUnit>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2H_CreateUnitFormatter : MemoryPackFormatter<G2H_CreateUnit>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2H_CreateUnit value)
		{
			G2H_CreateUnit.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2H_CreateUnit value)
		{
			G2H_CreateUnit.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public long GateSessionId { get; set; }

	[MemoryPackOrder(2)]
	public int Relogin { get; set; }

	[MemoryPackOrder(3)]
	public string ClientAddress { get; set; }

	[MemoryPackOrder(4)]
	public string GateAddress { get; set; }

	public static G2H_CreateUnit Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2H_CreateUnit)) as G2H_CreateUnit;
		}
		return new G2H_CreateUnit();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Account = null;
			GateSessionId = 0L;
			Relogin = 0;
			ClientAddress = null;
			GateAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2H_CreateUnit()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_CreateUnit>())
		{
			MemoryPackFormatterProvider.Register(new G2H_CreateUnitFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_CreateUnit[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2H_CreateUnit>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2H_CreateUnit? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<long, int>(value.GateSessionId, value.Relogin);
		writer.WriteString(value.ClientAddress);
		writer.WriteString(value.GateAddress);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2H_CreateUnit? value)
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
		string account;
		string clientAddress;
		string gateAddress;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.GateSessionId;
				value4 = value.Relogin;
				clientAddress = value.ClientAddress;
				gateAddress = value.GateAddress;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				clientAddress = reader.ReadString();
				gateAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value3, out value4);
			clientAddress = reader.ReadString();
			gateAddress = reader.ReadString();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2H_CreateUnit), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				value3 = 0L;
				value4 = 0;
				clientAddress = null;
				gateAddress = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.GateSessionId;
				value4 = value.Relogin;
				clientAddress = value.ClientAddress;
				gateAddress = value.GateAddress;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								clientAddress = reader.ReadString();
								if (memberCount != 5)
								{
									gateAddress = reader.ReadString();
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value5);
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
				goto IL_018c;
			}
		}
		value = new G2H_CreateUnit
		{
			IsFromPool = value2,
			Account = account,
			GateSessionId = value3,
			Relogin = value4,
			ClientAddress = clientAddress,
			GateAddress = gateAddress,
			RpcId = value5
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.Account = account;
		value.GateSessionId = value3;
		value.Relogin = value4;
		value.ClientAddress = clientAddress;
		value.GateAddress = gateAddress;
		value.RpcId = value5;
	}
}
