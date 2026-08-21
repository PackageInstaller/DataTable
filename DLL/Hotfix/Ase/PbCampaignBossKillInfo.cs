using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(445)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignBossKillInfo : MessageObject, IMemoryPackable<PbCampaignBossKillInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignBossKillInfoFormatter : MemoryPackFormatter<PbCampaignBossKillInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignBossKillInfo value)
		{
			PbCampaignBossKillInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignBossKillInfo value)
		{
			PbCampaignBossKillInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<string> PlayerNames { get; set; } = new List<string>();

	[MemoryPackOrder(1)]
	public int CopyId { get; set; }

	[MemoryPackOrder(2)]
	public int ReportType { get; set; }

	public static PbCampaignBossKillInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignBossKillInfo)) as PbCampaignBossKillInfo;
		}
		return new PbCampaignBossKillInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PlayerNames.Clear();
			CopyId = 0;
			ReportType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignBossKillInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBossKillInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignBossKillInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBossKillInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignBossKillInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignBossKillInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteValue<List<string>>(value.PlayerNames);
		writer.WriteUnmanaged<int, int>(value.CopyId, value.ReportType);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignBossKillInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<string> value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerNames;
				value4 = value.CopyId;
				value5 = value.ReportType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<string>>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignBossKillInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerNames;
				value4 = value.CopyId;
				value5 = value.ReportType;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new PbCampaignBossKillInfo
		{
			IsFromPool = value2,
			PlayerNames = value3,
			CopyId = value4,
			ReportType = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.PlayerNames = value3;
		value.CopyId = value4;
		value.ReportType = value5;
	}
}
