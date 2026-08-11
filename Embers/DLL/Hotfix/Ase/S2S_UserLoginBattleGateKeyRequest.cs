using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10146)]
[MemoryPackable(GenerateType.Object)]
public class S2S_UserLoginBattleGateKeyRequest : MessageObject, IRequest, IMessage, IMemoryPackable<S2S_UserLoginBattleGateKeyRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2S_UserLoginBattleGateKeyRequestFormatter : MemoryPackFormatter<S2S_UserLoginBattleGateKeyRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2S_UserLoginBattleGateKeyRequest value)
		{
			S2S_UserLoginBattleGateKeyRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2S_UserLoginBattleGateKeyRequest value)
		{
			S2S_UserLoginBattleGateKeyRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<long> UserIds { get; set; } = new List<long>();

	[MemoryPackOrder(1)]
	public long BattleRoomId { get; set; }

	[MemoryPackOrder(2)]
	public string BattleFieldAddress { get; set; }

	public static S2S_UserLoginBattleGateKeyRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2S_UserLoginBattleGateKeyRequest)) as S2S_UserLoginBattleGateKeyRequest;
		}
		return new S2S_UserLoginBattleGateKeyRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserIds.Clear();
			BattleRoomId = 0L;
			BattleFieldAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2S_UserLoginBattleGateKeyRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2S_UserLoginBattleGateKeyRequest>())
		{
			MemoryPackFormatterProvider.Register(new S2S_UserLoginBattleGateKeyRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2S_UserLoginBattleGateKeyRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2S_UserLoginBattleGateKeyRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2S_UserLoginBattleGateKeyRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteValue<List<long>>(value.UserIds);
		writer.WriteUnmanaged<long>(value.BattleRoomId);
		writer.WriteString(value.BattleFieldAddress);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2S_UserLoginBattleGateKeyRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<long> value3;
		long value4;
		int value5;
		long value6;
		string battleFieldAddress;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserIds;
				value4 = value.BattleRoomId;
				battleFieldAddress = value.BattleFieldAddress;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				battleFieldAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_015e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<long>(out value4);
			battleFieldAddress = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2S_UserLoginBattleGateKeyRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				battleFieldAddress = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserIds;
				value4 = value.BattleRoomId;
				battleFieldAddress = value.BattleFieldAddress;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
						if (memberCount != 3)
						{
							battleFieldAddress = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
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
				goto IL_015e;
			}
		}
		value = new S2S_UserLoginBattleGateKeyRequest
		{
			IsFromPool = value2,
			UserIds = value3,
			BattleRoomId = value4,
			BattleFieldAddress = battleFieldAddress,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_015e:
		value.IsFromPool = value2;
		value.UserIds = value3;
		value.BattleRoomId = value4;
		value.BattleFieldAddress = battleFieldAddress;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
