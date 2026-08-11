using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(408)]
[MemoryPackable(GenerateType.Object)]
public class PbActivityRankStateData : MessageObject, IMemoryPackable<PbActivityRankStateData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbActivityRankStateDataFormatter : MemoryPackFormatter<PbActivityRankStateData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbActivityRankStateData value)
		{
			PbActivityRankStateData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbActivityRankStateData value)
		{
			PbActivityRankStateData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int CompeteValue { get; set; }

	[MemoryPackOrder(2)]
	public int RewardState { get; set; }

	[MemoryPackOrder(3)]
	public int ProgressId { get; set; }

	public static PbActivityRankStateData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbActivityRankStateData)) as PbActivityRankStateData;
		}
		return new PbActivityRankStateData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			CompeteValue = 0;
			RewardState = 0;
			ProgressId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbActivityRankStateData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityRankStateData>())
		{
			MemoryPackFormatterProvider.Register(new PbActivityRankStateDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityRankStateData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbActivityRankStateData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbActivityRankStateData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(5, value.IsFromPool, value.Id, value.CompeteValue, value.RewardState, value.ProgressId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbActivityRankStateData? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.CompeteValue;
				value5 = value.RewardState;
				value6 = value.ProgressId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0117;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbActivityRankStateData), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.CompeteValue;
				value5 = value.RewardState;
				value6 = value.ProgressId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0117;
			}
		}
		value = new PbActivityRankStateData
		{
			IsFromPool = value2,
			Id = value3,
			CompeteValue = value4,
			RewardState = value5,
			ProgressId = value6
		};
		return;
		IL_0117:
		value.IsFromPool = value2;
		value.Id = value3;
		value.CompeteValue = value4;
		value.RewardState = value5;
		value.ProgressId = value6;
	}
}
