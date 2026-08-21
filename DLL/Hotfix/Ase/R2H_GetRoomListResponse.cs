using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10038)]
[MemoryPackable(GenerateType.Object)]
public class R2H_GetRoomListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<R2H_GetRoomListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class R2H_GetRoomListResponseFormatter : MemoryPackFormatter<R2H_GetRoomListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref R2H_GetRoomListResponse value)
		{
			R2H_GetRoomListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref R2H_GetRoomListResponse value)
		{
			R2H_GetRoomListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbSingleRoomInfo> Rooms { get; set; } = new List<PbSingleRoomInfo>();

	public static R2H_GetRoomListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(R2H_GetRoomListResponse)) as R2H_GetRoomListResponse;
		}
		return new R2H_GetRoomListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rooms.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static R2H_GetRoomListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<R2H_GetRoomListResponse>())
		{
			MemoryPackFormatterProvider.Register(new R2H_GetRoomListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<R2H_GetRoomListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<R2H_GetRoomListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSingleRoomInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSingleRoomInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref R2H_GetRoomListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSingleRoomInfo>>(value.Rooms));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref R2H_GetRoomListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbSingleRoomInfo> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rooms;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbSingleRoomInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(R2H_GetRoomListResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rooms;
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
				goto IL_012b;
			}
		}
		value = new R2H_GetRoomListResponse
		{
			IsFromPool = value2,
			Rooms = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.Rooms = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
