using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10706)]
[MemoryPackable(GenerateType.Object)]
public class GetFloorCopyStarInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFloorCopyStarInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFloorCopyStarInfoResponseFormatter : MemoryPackFormatter<GetFloorCopyStarInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFloorCopyStarInfoResponse value)
		{
			GetFloorCopyStarInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFloorCopyStarInfoResponse value)
		{
			GetFloorCopyStarInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFloorCopyStarInfo> CopyStarInfos { get; set; } = new List<PbFloorCopyStarInfo>();

	[MemoryPackOrder(1)]
	public int Zone { get; set; }

	public static GetFloorCopyStarInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFloorCopyStarInfoResponse)) as GetFloorCopyStarInfoResponse;
		}
		return new GetFloorCopyStarInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			CopyStarInfos.Clear();
			Zone = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFloorCopyStarInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFloorCopyStarInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFloorCopyStarInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFloorCopyStarInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFloorCopyStarInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFloorCopyStarInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFloorCopyStarInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFloorCopyStarInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFloorCopyStarInfo>>(value.CopyStarInfos));
		writer.WriteUnmanaged<int, int, int>(value.Zone, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFloorCopyStarInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbFloorCopyStarInfo> value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyStarInfos;
				value4 = value.Zone;
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
			value3 = ListFormatter.DeserializePackable<PbFloorCopyStarInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFloorCopyStarInfoResponse), 6, memberCount);
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
				value3 = value.CopyStarInfos;
				value4 = value.Zone;
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
		value = new GetFloorCopyStarInfoResponse
		{
			IsFromPool = value2,
			CopyStarInfos = value3,
			Zone = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.CopyStarInfos = value3;
		value.Zone = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
