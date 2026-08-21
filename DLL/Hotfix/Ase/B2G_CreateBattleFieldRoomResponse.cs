using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10133)]
[MemoryPackable(GenerateType.Object)]
public class B2G_CreateBattleFieldRoomResponse : MessageObject, IResponse, IMessage, IMemoryPackable<B2G_CreateBattleFieldRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class B2G_CreateBattleFieldRoomResponseFormatter : MemoryPackFormatter<B2G_CreateBattleFieldRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref B2G_CreateBattleFieldRoomResponse value)
		{
			B2G_CreateBattleFieldRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref B2G_CreateBattleFieldRoomResponse value)
		{
			B2G_CreateBattleFieldRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int RandSeed { get; set; }

	[MemoryPackOrder(1)]
	public List<PbMapConnectInfo> MapConnectInfo { get; set; } = new List<PbMapConnectInfo>();

	[MemoryPackOrder(2)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(3)]
	public int Seed { get; set; }

	[MemoryPackOrder(4)]
	public long RoomId { get; set; }

	[MemoryPackOrder(5)]
	public string outerAddress { get; set; }

	public static B2G_CreateBattleFieldRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(B2G_CreateBattleFieldRoomResponse)) as B2G_CreateBattleFieldRoomResponse;
		}
		return new B2G_CreateBattleFieldRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RandSeed = 0;
			MapConnectInfo.Clear();
			CheckCode = 0L;
			Seed = 0;
			RoomId = 0L;
			outerAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static B2G_CreateBattleFieldRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<B2G_CreateBattleFieldRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new B2G_CreateBattleFieldRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<B2G_CreateBattleFieldRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<B2G_CreateBattleFieldRoomResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMapConnectInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMapConnectInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref B2G_CreateBattleFieldRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.RandSeed);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMapConnectInfo>>(value.MapConnectInfo));
		writer.WriteUnmanaged<long, int, long>(value.CheckCode, value.Seed, value.RoomId);
		writer.WriteString(value.outerAddress);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref B2G_CreateBattleFieldRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbMapConnectInfo> value4;
		long value5;
		int value6;
		long value7;
		int value8;
		int value9;
		string text;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RandSeed;
				value4 = value.MapConnectInfo;
				value5 = value.CheckCode;
				value6 = value.Seed;
				value7 = value.RoomId;
				text = value.outerAddress;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_0215;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbMapConnectInfo>(ref reader);
			reader.ReadUnmanaged<long, int, long>(out value5, out value6, out value7);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(B2G_CreateBattleFieldRoomResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				text = null;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RandSeed;
				value4 = value.MapConnectInfo;
				value5 = value.CheckCode;
				value6 = value.Seed;
				value7 = value.RoomId;
				text = value.outerAddress;
				value8 = value.RpcId;
				value9 = value.Error;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										text = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													message = reader.ReadString();
													_ = 10;
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
				goto IL_0215;
			}
		}
		value = new B2G_CreateBattleFieldRoomResponse
		{
			IsFromPool = value2,
			RandSeed = value3,
			MapConnectInfo = value4,
			CheckCode = value5,
			Seed = value6,
			RoomId = value7,
			outerAddress = text,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_0215:
		value.IsFromPool = value2;
		value.RandSeed = value3;
		value.MapConnectInfo = value4;
		value.CheckCode = value5;
		value.Seed = value6;
		value.RoomId = value7;
		value.outerAddress = text;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
