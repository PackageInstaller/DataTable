using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(362)]
[MemoryPackable(GenerateType.Object)]
public class PbBattleAchievementAttachInfo : MessageObject, IMemoryPackable<PbBattleAchievementAttachInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBattleAchievementAttachInfoFormatter : MemoryPackFormatter<PbBattleAchievementAttachInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBattleAchievementAttachInfo value)
		{
			PbBattleAchievementAttachInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBattleAchievementAttachInfo value)
		{
			PbBattleAchievementAttachInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MedalId { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	public static PbBattleAchievementAttachInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBattleAchievementAttachInfo)) as PbBattleAchievementAttachInfo;
		}
		return new PbBattleAchievementAttachInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MedalId = 0;
			Value = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBattleAchievementAttachInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleAchievementAttachInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBattleAchievementAttachInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleAchievementAttachInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBattleAchievementAttachInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBattleAchievementAttachInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.MedalId, value.Value);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBattleAchievementAttachInfo? value)
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
				value3 = value.MedalId;
				value4 = value.Value;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBattleAchievementAttachInfo), 3, memberCount);
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
				value3 = value.MedalId;
				value4 = value.Value;
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
		value = new PbBattleAchievementAttachInfo
		{
			IsFromPool = value2,
			MedalId = value3,
			Value = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.MedalId = value3;
		value.Value = value4;
	}
}
