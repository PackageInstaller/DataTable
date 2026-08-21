using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(447)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignDailyTaskInfo : MessageObject, IMemoryPackable<PbCampaignDailyTaskInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignDailyTaskInfoFormatter : MemoryPackFormatter<PbCampaignDailyTaskInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignDailyTaskInfo value)
		{
			PbCampaignDailyTaskInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignDailyTaskInfo value)
		{
			PbCampaignDailyTaskInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int PointId { get; set; }

	[MemoryPackOrder(1)]
	public int PlayId { get; set; }

	[MemoryPackOrder(2)]
	public bool IsCompleted { get; set; }

	public static PbCampaignDailyTaskInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignDailyTaskInfo)) as PbCampaignDailyTaskInfo;
		}
		return new PbCampaignDailyTaskInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PointId = 0;
			PlayId = 0;
			IsCompleted = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignDailyTaskInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignDailyTaskInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignDailyTaskInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignDailyTaskInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignDailyTaskInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignDailyTaskInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, bool>(4, value.IsFromPool, value.PointId, value.PlayId, value.IsCompleted);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignDailyTaskInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		bool value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PointId;
				value4 = value.PlayId;
				value5 = value.IsCompleted;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, bool>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignDailyTaskInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PointId;
				value4 = value.PlayId;
				value5 = value.IsCompleted;
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
							reader.ReadUnmanaged<bool>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbCampaignDailyTaskInfo
		{
			IsFromPool = value2,
			PointId = value3,
			PlayId = value4,
			IsCompleted = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.PointId = value3;
		value.PlayId = value4;
		value.IsCompleted = value5;
	}
}
