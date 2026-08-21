using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10926)]
[MemoryPackable(GenerateType.Object)]
public class GetCampaignDetailInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetCampaignDetailInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetCampaignDetailInfoResponseFormatter : MemoryPackFormatter<GetCampaignDetailInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetCampaignDetailInfoResponse value)
		{
			GetCampaignDetailInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetCampaignDetailInfoResponse value)
		{
			GetCampaignDetailInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbCampaignWorldBossInfo> WorldBossInfos { get; set; } = new List<PbCampaignWorldBossInfo>();

	[MemoryPackOrder(1)]
	public List<PbCampaignBuildingInfo> BuildingInfos { get; set; } = new List<PbCampaignBuildingInfo>();

	[MemoryPackOrder(2)]
	public List<PbCampaignDailyTaskInfo> DailyTaskInfos { get; set; } = new List<PbCampaignDailyTaskInfo>();

	public static GetCampaignDetailInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetCampaignDetailInfoResponse)) as GetCampaignDetailInfoResponse;
		}
		return new GetCampaignDetailInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			WorldBossInfos.Clear();
			BuildingInfos.Clear();
			DailyTaskInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetCampaignDetailInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetCampaignDetailInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetCampaignDetailInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetCampaignDetailInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetCampaignDetailInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignWorldBossInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignWorldBossInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignBuildingInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignBuildingInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignDailyTaskInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignDailyTaskInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetCampaignDetailInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignWorldBossInfo>>(value.WorldBossInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignBuildingInfo>>(value.BuildingInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignDailyTaskInfo>>(value.DailyTaskInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetCampaignDetailInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCampaignWorldBossInfo> value3;
		List<PbCampaignBuildingInfo> value4;
		List<PbCampaignDailyTaskInfo> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.WorldBossInfos;
				value4 = value.BuildingInfos;
				value5 = value.DailyTaskInfos;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCampaignWorldBossInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbCampaignBuildingInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbCampaignDailyTaskInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetCampaignDetailInfoResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.WorldBossInfos;
				value4 = value.BuildingInfos;
				value5 = value.DailyTaskInfos;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
				goto IL_018c;
			}
		}
		value = new GetCampaignDetailInfoResponse
		{
			IsFromPool = value2,
			WorldBossInfos = value3,
			BuildingInfos = value4,
			DailyTaskInfos = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.WorldBossInfos = value3;
		value.BuildingInfos = value4;
		value.DailyTaskInfos = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
