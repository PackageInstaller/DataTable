using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10555)]
[MemoryPackable(GenerateType.Object)]
public class GetHomeLandInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetHomeLandInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetHomeLandInfoResponseFormatter : MemoryPackFormatter<GetHomeLandInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetHomeLandInfoResponse value)
		{
			GetHomeLandInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetHomeLandInfoResponse value)
		{
			GetHomeLandInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbBuildingInfo> Buildings { get; set; } = new List<PbBuildingInfo>();

	[MemoryPackOrder(1)]
	public int HomeLandCoin { get; set; }

	[MemoryPackOrder(4)]
	public int Level { get; set; }

	public static GetHomeLandInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetHomeLandInfoResponse)) as GetHomeLandInfoResponse;
		}
		return new GetHomeLandInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Buildings.Clear();
			HomeLandCoin = 0;
			Level = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetHomeLandInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeLandInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetHomeLandInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeLandInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetHomeLandInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBuildingInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBuildingInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetHomeLandInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBuildingInfo>>(value.Buildings));
		writer.WriteUnmanaged<int, int, int, int>(value.HomeLandCoin, value.Level, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetHomeLandInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbBuildingInfo> value3;
		int value4;
		int value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Buildings;
				value4 = value.HomeLandCoin;
				value5 = value.Level;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0181;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbBuildingInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetHomeLandInfoResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Buildings;
				value4 = value.HomeLandCoin;
				value5 = value.Level;
				value6 = value.RpcId;
				value7 = value.Error;
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
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
				goto IL_0181;
			}
		}
		value = new GetHomeLandInfoResponse
		{
			IsFromPool = value2,
			Buildings = value3,
			HomeLandCoin = value4,
			Level = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0181:
		value.IsFromPool = value2;
		value.Buildings = value3;
		value.HomeLandCoin = value4;
		value.Level = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
