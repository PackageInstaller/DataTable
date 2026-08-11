using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10147)]
[MemoryPackable(GenerateType.Object)]
public class S2S_UserLoginBattleGateKeyResponse : MessageObject, IResponse, IMessage, IMemoryPackable<S2S_UserLoginBattleGateKeyResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2S_UserLoginBattleGateKeyResponseFormatter : MemoryPackFormatter<S2S_UserLoginBattleGateKeyResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2S_UserLoginBattleGateKeyResponse value)
		{
			S2S_UserLoginBattleGateKeyResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2S_UserLoginBattleGateKeyResponse value)
		{
			S2S_UserLoginBattleGateKeyResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbMapConnectInfo> Users { get; set; } = new List<PbMapConnectInfo>();

	[MemoryPackOrder(1)]
	public string GateAddress { get; set; }

	public static S2S_UserLoginBattleGateKeyResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2S_UserLoginBattleGateKeyResponse)) as S2S_UserLoginBattleGateKeyResponse;
		}
		return new S2S_UserLoginBattleGateKeyResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Users.Clear();
			GateAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2S_UserLoginBattleGateKeyResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2S_UserLoginBattleGateKeyResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2S_UserLoginBattleGateKeyResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2S_UserLoginBattleGateKeyResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2S_UserLoginBattleGateKeyResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMapConnectInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMapConnectInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2S_UserLoginBattleGateKeyResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMapConnectInfo>>(value.Users));
		writer.WriteString(value.GateAddress);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2S_UserLoginBattleGateKeyResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbMapConnectInfo> value3;
		int value4;
		int value5;
		string gateAddress;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				gateAddress = value.GateAddress;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				gateAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_0159;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbMapConnectInfo>(ref reader);
			gateAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2S_UserLoginBattleGateKeyResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				gateAddress = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				gateAddress = value.GateAddress;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						gateAddress = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0159;
			}
		}
		value = new S2S_UserLoginBattleGateKeyResponse
		{
			IsFromPool = value2,
			Users = value3,
			GateAddress = gateAddress,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_0159:
		value.IsFromPool = value2;
		value.Users = value3;
		value.GateAddress = gateAddress;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
