using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(444)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignWorldBossInfo : MessageObject, IMemoryPackable<PbCampaignWorldBossInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignWorldBossInfoFormatter : MemoryPackFormatter<PbCampaignWorldBossInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignWorldBossInfo value)
		{
			PbCampaignWorldBossInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignWorldBossInfo value)
		{
			PbCampaignWorldBossInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int PointId { get; set; }

	[MemoryPackOrder(1)]
	public int PlayId { get; set; }

	[MemoryPackOrder(2)]
	public long BossHP { get; set; }

	[MemoryPackOrder(3)]
	public long Times { get; set; }

	public static PbCampaignWorldBossInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignWorldBossInfo)) as PbCampaignWorldBossInfo;
		}
		return new PbCampaignWorldBossInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PointId = 0;
			PlayId = 0;
			BossHP = 0L;
			Times = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignWorldBossInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignWorldBossInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignWorldBossInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignWorldBossInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignWorldBossInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignWorldBossInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, long>(5, value.IsFromPool, value.PointId, value.PlayId, value.BossHP, value.Times);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignWorldBossInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PointId;
				value4 = value.PlayId;
				value5 = value.BossHP;
				value6 = value.Times;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, int, int, long, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignWorldBossInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PointId;
				value4 = value.PlayId;
				value5 = value.BossHP;
				value6 = value.Times;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new PbCampaignWorldBossInfo
		{
			IsFromPool = value2,
			PointId = value3,
			PlayId = value4,
			BossHP = value5,
			Times = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.PointId = value3;
		value.PlayId = value4;
		value.BossHP = value5;
		value.Times = value6;
	}
}
