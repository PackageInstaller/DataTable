using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10024)]
[MemoryPackable(GenerateType.Object)]
public class S2C_Global_StartLoad : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_Global_StartLoad>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_Global_StartLoadFormatter : MemoryPackFormatter<S2C_Global_StartLoad>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_Global_StartLoad value)
		{
			S2C_Global_StartLoad.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_Global_StartLoad value)
		{
			S2C_Global_StartLoad.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(94)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Seed { get; set; }

	[MemoryPackOrder(1)]
	public long Key { get; set; }

	[MemoryPackOrder(2)]
	public string Address { get; set; }

	[MemoryPackOrder(3)]
	public List<PbBattleFiledUserInfo> RoomPlayerInfo { get; set; } = new List<PbBattleFiledUserInfo>();

	[MemoryPackOrder(4)]
	public long RoomId { get; set; }

	[MemoryPackOrder(5)]
	public int KcpConnectId { get; set; }

	public static S2C_Global_StartLoad Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_Global_StartLoad)) as S2C_Global_StartLoad;
		}
		return new S2C_Global_StartLoad();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Error = 0;
			Message = null;
			Seed = 0;
			Key = 0L;
			Address = null;
			RoomPlayerInfo.Clear();
			RoomId = 0L;
			KcpConnectId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_Global_StartLoad()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_StartLoad>())
		{
			MemoryPackFormatterProvider.Register(new S2C_Global_StartLoadFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_StartLoad[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_Global_StartLoad>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleFiledUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleFiledUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_Global_StartLoad? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(11, value.IsFromPool, value.Seed, value.Key);
		writer.WriteString(value.Address);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleFiledUserInfo>>(value.RoomPlayerInfo));
		writer.WriteUnmanaged<long, int, int, int, long>(value.RoomId, value.KcpConnectId, value.RpcId, value.Error, value.ActorId);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_Global_StartLoad? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		List<PbBattleFiledUserInfo> value5;
		long value6;
		int value7;
		int value8;
		int value9;
		long value10;
		string address;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Seed;
				value4 = value.Key;
				address = value.Address;
				value5 = value.RoomPlayerInfo;
				value6 = value.RoomId;
				value7 = value.KcpConnectId;
				value8 = value.RpcId;
				value9 = value.Error;
				value10 = value.ActorId;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				address = reader.ReadString();
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				message = reader.ReadString();
				goto IL_0240;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			address = reader.ReadString();
			value5 = ListFormatter.DeserializePackable<PbBattleFiledUserInfo>(ref reader);
			reader.ReadUnmanaged<long, int, int, int, long>(out value6, out value7, out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_Global_StartLoad), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				address = null;
				value5 = null;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Seed;
				value4 = value.Key;
				address = value.Address;
				value5 = value.RoomPlayerInfo;
				value6 = value.RoomId;
				value7 = value.KcpConnectId;
				value8 = value.RpcId;
				value9 = value.Error;
				value10 = value.ActorId;
				message = value.Message;
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
							address = reader.ReadString();
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value10);
													if (memberCount != 10)
													{
														message = reader.ReadString();
														_ = 11;
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0240;
			}
		}
		value = new S2C_Global_StartLoad
		{
			IsFromPool = value2,
			Seed = value3,
			Key = value4,
			Address = address,
			RoomPlayerInfo = value5,
			RoomId = value6,
			KcpConnectId = value7,
			RpcId = value8,
			Error = value9,
			ActorId = value10,
			Message = message
		};
		return;
		IL_0240:
		value.IsFromPool = value2;
		value.Seed = value3;
		value.Key = value4;
		value.Address = address;
		value.RoomPlayerInfo = value5;
		value.RoomId = value6;
		value.KcpConnectId = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.ActorId = value10;
		value.Message = message;
	}
}
