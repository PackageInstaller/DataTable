using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10924)]
[MemoryPackable(GenerateType.Object)]
public class GetCampaignInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetCampaignInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetCampaignInfoResponseFormatter : MemoryPackFormatter<GetCampaignInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetCampaignInfoResponse value)
		{
			GetCampaignInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetCampaignInfoResponse value)
		{
			GetCampaignInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbCampaignWorldBossInfo> FinalBossHP { get; set; } = new List<PbCampaignWorldBossInfo>();

	[MemoryPackOrder(1)]
	public List<int> MainTaskProgress { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public List<int> BranchTaskProgress { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<PbCampaignBossKillInfo> BossKillInfos { get; set; } = new List<PbCampaignBossKillInfo>();

	[MemoryPackOrder(4)]
	public List<PbCampaignBranchTaskProgress> BranchTaskProgressInfos { get; set; } = new List<PbCampaignBranchTaskProgress>();

	[MemoryPackOrder(5)]
	public long NextMainStageTime { get; set; }

	public static GetCampaignInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetCampaignInfoResponse)) as GetCampaignInfoResponse;
		}
		return new GetCampaignInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FinalBossHP.Clear();
			MainTaskProgress.Clear();
			BranchTaskProgress.Clear();
			BossKillInfos.Clear();
			BranchTaskProgressInfos.Clear();
			NextMainStageTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetCampaignInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetCampaignInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetCampaignInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetCampaignInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetCampaignInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignWorldBossInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignWorldBossInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignBossKillInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignBossKillInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignBranchTaskProgress>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignBranchTaskProgress>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetCampaignInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignWorldBossInfo>>(value.FinalBossHP));
		writer.WriteValue<List<int>>(value.MainTaskProgress);
		writer.WriteValue<List<int>>(value.BranchTaskProgress);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignBossKillInfo>>(value.BossKillInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignBranchTaskProgress>>(value.BranchTaskProgressInfos));
		writer.WriteUnmanaged<long, int, int>(value.NextMainStageTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetCampaignInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCampaignWorldBossInfo> value3;
		List<int> value4;
		List<int> value5;
		List<PbCampaignBossKillInfo> value6;
		List<PbCampaignBranchTaskProgress> value7;
		long value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FinalBossHP;
				value4 = value.MainTaskProgress;
				value5 = value.BranchTaskProgress;
				value6 = value.BossKillInfos;
				value7 = value.BranchTaskProgressInfos;
				value8 = value.NextMainStageTime;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadValue(ref value4);
				reader.ReadValue(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_021f;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCampaignWorldBossInfo>(ref reader);
			value4 = reader.ReadValue<List<int>>();
			value5 = reader.ReadValue<List<int>>();
			value6 = ListFormatter.DeserializePackable<PbCampaignBossKillInfo>(ref reader);
			value7 = ListFormatter.DeserializePackable<PbCampaignBranchTaskProgress>(ref reader);
			reader.ReadUnmanaged<long, int, int>(out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetCampaignInfoResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = 0L;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FinalBossHP;
				value4 = value.MainTaskProgress;
				value5 = value.BranchTaskProgress;
				value6 = value.BossKillInfos;
				value7 = value.BranchTaskProgressInfos;
				value8 = value.NextMainStageTime;
				value9 = value.RpcId;
				value10 = value.Error;
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
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
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
				goto IL_021f;
			}
		}
		value = new GetCampaignInfoResponse
		{
			IsFromPool = value2,
			FinalBossHP = value3,
			MainTaskProgress = value4,
			BranchTaskProgress = value5,
			BossKillInfos = value6,
			BranchTaskProgressInfos = value7,
			NextMainStageTime = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_021f:
		value.IsFromPool = value2;
		value.FinalBossHP = value3;
		value.MainTaskProgress = value4;
		value.BranchTaskProgress = value5;
		value.BossKillInfos = value6;
		value.BranchTaskProgressInfos = value7;
		value.NextMainStageTime = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
