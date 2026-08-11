using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(431)]
[MemoryPackable(GenerateType.Object)]
public class PbPositionReward : MessageObject, IMemoryPackable<PbPositionReward>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbPositionRewardFormatter : MemoryPackFormatter<PbPositionReward>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbPositionReward value)
		{
			PbPositionReward.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbPositionReward value)
		{
			PbPositionReward.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Pos { get; set; }

	[MemoryPackOrder(1)]
	public int RewardConfigId { get; set; }

	public static PbPositionReward Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbPositionReward)) as PbPositionReward;
		}
		return new PbPositionReward();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Pos = 0;
			RewardConfigId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbPositionReward()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbPositionReward>())
		{
			MemoryPackFormatterProvider.Register(new PbPositionRewardFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbPositionReward[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbPositionReward>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbPositionReward? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.Pos, value.RewardConfigId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbPositionReward? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Pos;
				value4 = value.RewardConfigId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbPositionReward), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Pos;
				value4 = value.RewardConfigId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbPositionReward
		{
			IsFromPool = value2,
			Pos = value3,
			RewardConfigId = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.Pos = value3;
		value.RewardConfigId = value4;
	}
}
