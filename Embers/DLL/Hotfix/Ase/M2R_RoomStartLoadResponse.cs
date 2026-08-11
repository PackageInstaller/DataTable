using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10135)]
[MemoryPackable(GenerateType.Object)]
public class M2R_RoomStartLoadResponse : MessageObject, IResponse, IMessage, IMemoryPackable<M2R_RoomStartLoadResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2R_RoomStartLoadResponseFormatter : MemoryPackFormatter<M2R_RoomStartLoadResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2R_RoomStartLoadResponse value)
		{
			M2R_RoomStartLoadResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2R_RoomStartLoadResponse value)
		{
			M2R_RoomStartLoadResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string MapAddress { get; set; }

	[MemoryPackOrder(1)]
	public List<PbMapConnectInfo> MapConnectInfo { get; set; } = new List<PbMapConnectInfo>();

	[MemoryPackOrder(2)]
	public long RandSeed { get; set; }

	[MemoryPackOrder(3)]
	public string Address { get; set; }

	public static M2R_RoomStartLoadResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2R_RoomStartLoadResponse)) as M2R_RoomStartLoadResponse;
		}
		return new M2R_RoomStartLoadResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			MapAddress = null;
			MapConnectInfo.Clear();
			RandSeed = 0L;
			Address = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2R_RoomStartLoadResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2R_RoomStartLoadResponse>())
		{
			MemoryPackFormatterProvider.Register(new M2R_RoomStartLoadResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2R_RoomStartLoadResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2R_RoomStartLoadResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMapConnectInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMapConnectInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2R_RoomStartLoadResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteString(value.MapAddress);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMapConnectInfo>>(value.MapConnectInfo));
		writer.WriteUnmanaged<long>(value.RandSeed);
		writer.WriteString(value.Address);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2R_RoomStartLoadResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbMapConnectInfo> value3;
		long value4;
		int value5;
		int value6;
		string mapAddress;
		string address;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				mapAddress = value.MapAddress;
				value3 = value.MapConnectInfo;
				value4 = value.RandSeed;
				address = value.Address;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				mapAddress = reader.ReadString();
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				address = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_01bc;
			}
			reader.ReadUnmanaged<bool>(out value2);
			mapAddress = reader.ReadString();
			value3 = ListFormatter.DeserializePackable<PbMapConnectInfo>(ref reader);
			reader.ReadUnmanaged<long>(out value4);
			address = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2R_RoomStartLoadResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				mapAddress = null;
				value3 = null;
				value4 = 0L;
				address = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				mapAddress = value.MapAddress;
				value3 = value.MapConnectInfo;
				value4 = value.RandSeed;
				address = value.Address;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					mapAddress = reader.ReadString();
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								address = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
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
				goto IL_01bc;
			}
		}
		value = new M2R_RoomStartLoadResponse
		{
			IsFromPool = value2,
			MapAddress = mapAddress,
			MapConnectInfo = value3,
			RandSeed = value4,
			Address = address,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_01bc:
		value.IsFromPool = value2;
		value.MapAddress = mapAddress;
		value.MapConnectInfo = value3;
		value.RandSeed = value4;
		value.Address = address;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
