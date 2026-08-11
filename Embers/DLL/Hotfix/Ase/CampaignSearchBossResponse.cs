using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10928)]
[MemoryPackable(GenerateType.Object)]
public class CampaignSearchBossResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<CampaignSearchBossResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CampaignSearchBossResponseFormatter : MemoryPackFormatter<CampaignSearchBossResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CampaignSearchBossResponse value)
		{
			CampaignSearchBossResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CampaignSearchBossResponse value)
		{
			CampaignSearchBossResponse.Deserialize(ref reader, ref value);
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
	public List<PbItemChange> CostItems { get; set; } = new List<PbItemChange>();

	public static CampaignSearchBossResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CampaignSearchBossResponse)) as CampaignSearchBossResponse;
		}
		return new CampaignSearchBossResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			WorldBossInfos.Clear();
			CostItems.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CampaignSearchBossResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CampaignSearchBossResponse>())
		{
			MemoryPackFormatterProvider.Register(new CampaignSearchBossResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CampaignSearchBossResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CampaignSearchBossResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignWorldBossInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignWorldBossInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CampaignSearchBossResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignWorldBossInfo>>(value.WorldBossInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.CostItems));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CampaignSearchBossResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCampaignWorldBossInfo> value3;
		List<PbItemChange> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.WorldBossInfos;
				value4 = value.CostItems;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCampaignWorldBossInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CampaignSearchBossResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.WorldBossInfos;
				value4 = value.CostItems;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
				goto IL_015b;
			}
		}
		value = new CampaignSearchBossResponse
		{
			IsFromPool = value2,
			WorldBossInfos = value3,
			CostItems = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.WorldBossInfos = value3;
		value.CostItems = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
