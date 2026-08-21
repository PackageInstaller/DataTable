using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(436)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyBattleInfo : MessageObject, IMemoryPackable<PbCopyBattleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyBattleInfoFormatter : MemoryPackFormatter<PbCopyBattleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyBattleInfo value)
		{
			PbCopyBattleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyBattleInfo value)
		{
			PbCopyBattleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int OwnKillCount { get; set; }

	[MemoryPackOrder(1)]
	public int SceneKillCount { get; set; }

	[MemoryPackOrder(2)]
	public long OwnTotalDamage { get; set; }

	public static PbCopyBattleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyBattleInfo)) as PbCopyBattleInfo;
		}
		return new PbCopyBattleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			OwnKillCount = 0;
			SceneKillCount = 0;
			OwnTotalDamage = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyBattleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyBattleInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyBattleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyBattleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyBattleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyBattleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.OwnKillCount, value.SceneKillCount, value.OwnTotalDamage);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyBattleInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.OwnKillCount;
				value4 = value.SceneKillCount;
				value5 = value.OwnTotalDamage;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyBattleInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.OwnKillCount;
				value4 = value.SceneKillCount;
				value5 = value.OwnTotalDamage;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new PbCopyBattleInfo
		{
			IsFromPool = value2,
			OwnKillCount = value3,
			SceneKillCount = value4,
			OwnTotalDamage = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.OwnKillCount = value3;
		value.SceneKillCount = value4;
		value.OwnTotalDamage = value5;
	}
}
