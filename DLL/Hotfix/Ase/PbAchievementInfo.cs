using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(361)]
[MemoryPackable(GenerateType.Object)]
public class PbAchievementInfo : MessageObject, IMemoryPackable<PbAchievementInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbAchievementInfoFormatter : MemoryPackFormatter<PbAchievementInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbAchievementInfo value)
		{
			PbAchievementInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbAchievementInfo value)
		{
			PbAchievementInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MedalId { get; set; }

	[MemoryPackOrder(2)]
	public int Value { get; set; }

	[MemoryPackOrder(3)]
	public int RewardRank { get; set; }

	public static PbAchievementInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbAchievementInfo)) as PbAchievementInfo;
		}
		return new PbAchievementInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MedalId = 0;
			Value = 0;
			RewardRank = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbAchievementInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbAchievementInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbAchievementInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbAchievementInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbAchievementInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbAchievementInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.MedalId, value.Value, value.RewardRank);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbAchievementInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MedalId;
				value4 = value.Value;
				value5 = value.RewardRank;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbAchievementInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MedalId;
				value4 = value.Value;
				value5 = value.RewardRank;
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
		value = new PbAchievementInfo
		{
			IsFromPool = value2,
			MedalId = value3,
			Value = value4,
			RewardRank = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.MedalId = value3;
		value.Value = value4;
		value.RewardRank = value5;
	}
}
