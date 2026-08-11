using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(435)]
[MemoryPackable(GenerateType.Object)]
public class PbSuitboxCopyInfo : MessageObject, IMemoryPackable<PbSuitboxCopyInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSuitboxCopyInfoFormatter : MemoryPackFormatter<PbSuitboxCopyInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyInfo value)
		{
			PbSuitboxCopyInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyInfo value)
		{
			PbSuitboxCopyInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public int CopyType { get; set; }

	[MemoryPackOrder(3)]
	public int RewardCount { get; set; }

	[MemoryPackOrder(4)]
	public long CopyEndTime { get; set; }

	public static PbSuitboxCopyInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSuitboxCopyInfo)) as PbSuitboxCopyInfo;
		}
		return new PbSuitboxCopyInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			Score = 0;
			CopyType = 0;
			RewardCount = 0;
			CopyEndTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSuitboxCopyInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSuitboxCopyInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSuitboxCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, long>(6, value.IsFromPool, value.Type, value.Score, value.CopyType, value.RewardCount, value.CopyEndTime);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyInfo? value)
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
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Score;
				value5 = value.CopyType;
				value6 = value.RewardCount;
				value7 = value.CopyEndTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0146;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSuitboxCopyInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Score;
				value5 = value.CopyType;
				value6 = value.RewardCount;
				value7 = value.CopyEndTime;
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
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0146;
			}
		}
		value = new PbSuitboxCopyInfo
		{
			IsFromPool = value2,
			Type = value3,
			Score = value4,
			CopyType = value5,
			RewardCount = value6,
			CopyEndTime = value7
		};
		return;
		IL_0146:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Score = value4;
		value.CopyType = value5;
		value.RewardCount = value6;
		value.CopyEndTime = value7;
	}
}
