using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(446)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignBranchTaskProgress : MessageObject, IMemoryPackable<PbCampaignBranchTaskProgress>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignBranchTaskProgressFormatter : MemoryPackFormatter<PbCampaignBranchTaskProgress>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignBranchTaskProgress value)
		{
			PbCampaignBranchTaskProgress.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignBranchTaskProgress value)
		{
			PbCampaignBranchTaskProgress.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int PlayId { get; set; }

	[MemoryPackOrder(1)]
	public long YesterdayValue { get; set; }

	[MemoryPackOrder(2)]
	public long TotalValue { get; set; }

	public static PbCampaignBranchTaskProgress Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignBranchTaskProgress)) as PbCampaignBranchTaskProgress;
		}
		return new PbCampaignBranchTaskProgress();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PlayId = 0;
			YesterdayValue = 0L;
			TotalValue = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignBranchTaskProgress()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBranchTaskProgress>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignBranchTaskProgressFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBranchTaskProgress[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignBranchTaskProgress>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignBranchTaskProgress? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long>(4, value.IsFromPool, value.PlayId, value.YesterdayValue, value.TotalValue);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignBranchTaskProgress? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayId;
				value4 = value.YesterdayValue;
				value5 = value.TotalValue;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, int, long, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignBranchTaskProgress), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayId;
				value4 = value.YesterdayValue;
				value5 = value.TotalValue;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00eb;
			}
		}
		value = new PbCampaignBranchTaskProgress
		{
			IsFromPool = value2,
			PlayId = value3,
			YesterdayValue = value4,
			TotalValue = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.PlayId = value3;
		value.YesterdayValue = value4;
		value.TotalValue = value5;
	}
}
