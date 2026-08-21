using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10609)]
[MemoryPackable(GenerateType.Object)]
public class GetFriendFarmInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFriendFarmInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFriendFarmInfoResponseFormatter : MemoryPackFormatter<GetFriendFarmInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFriendFarmInfoResponse value)
		{
			GetFriendFarmInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFriendFarmInfoResponse value)
		{
			GetFriendFarmInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFarmGridInfo> Grids { get; set; } = new List<PbFarmGridInfo>();

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	public static GetFriendFarmInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFriendFarmInfoResponse)) as GetFriendFarmInfoResponse;
		}
		return new GetFriendFarmInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Grids.Clear();
			Level = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFriendFarmInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendFarmInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFriendFarmInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendFarmInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFriendFarmInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFarmGridInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFarmGridInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFriendFarmInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFarmGridInfo>>(value.Grids));
		writer.WriteUnmanaged<int, int, int>(value.Level, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFriendFarmInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbFarmGridInfo> value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Grids;
				value4 = value.Level;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbFarmGridInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFriendFarmInfoResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Grids;
				value4 = value.Level;
				value5 = value.RpcId;
				value6 = value.Error;
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
				goto IL_0156;
			}
		}
		value = new GetFriendFarmInfoResponse
		{
			IsFromPool = value2,
			Grids = value3,
			Level = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.Grids = value3;
		value.Level = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
