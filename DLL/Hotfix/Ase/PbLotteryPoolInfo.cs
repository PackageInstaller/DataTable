using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(324)]
[MemoryPackable(GenerateType.Object)]
public class PbLotteryPoolInfo : MessageObject, IMemoryPackable<PbLotteryPoolInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbLotteryPoolInfoFormatter : MemoryPackFormatter<PbLotteryPoolInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbLotteryPoolInfo value)
		{
			PbLotteryPoolInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbLotteryPoolInfo value)
		{
			PbLotteryPoolInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int DrawCount { get; set; }

	[MemoryPackOrder(2)]
	public long Countdown { get; set; }

	[MemoryPackOrder(3)]
	public int SlectUpId { get; set; }

	[MemoryPackOrder(5)]
	public int UpTriggerCount { get; set; }

	[MemoryPackOrder(6)]
	public int PoolDrawCount { get; set; }

	public static PbLotteryPoolInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbLotteryPoolInfo)) as PbLotteryPoolInfo;
		}
		return new PbLotteryPoolInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			DrawCount = 0;
			Countdown = 0L;
			SlectUpId = 0;
			UpTriggerCount = 0;
			PoolDrawCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbLotteryPoolInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryPoolInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbLotteryPoolInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryPoolInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbLotteryPoolInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbLotteryPoolInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, int, int>(7, value.IsFromPool, value.Id, value.DrawCount, value.Countdown, value.SlectUpId, value.UpTriggerCount, value.PoolDrawCount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbLotteryPoolInfo? value)
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
		int value6;
		int value7;
		int value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.DrawCount;
				value5 = value.Countdown;
				value6 = value.SlectUpId;
				value7 = value.UpTriggerCount;
				value8 = value.PoolDrawCount;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_0171;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbLotteryPoolInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.DrawCount;
				value5 = value.Countdown;
				value6 = value.SlectUpId;
				value7 = value.UpTriggerCount;
				value8 = value.PoolDrawCount;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0171;
			}
		}
		value = new PbLotteryPoolInfo
		{
			IsFromPool = value2,
			Id = value3,
			DrawCount = value4,
			Countdown = value5,
			SlectUpId = value6,
			UpTriggerCount = value7,
			PoolDrawCount = value8
		};
		return;
		IL_0171:
		value.IsFromPool = value2;
		value.Id = value3;
		value.DrawCount = value4;
		value.Countdown = value5;
		value.SlectUpId = value6;
		value.UpTriggerCount = value7;
		value.PoolDrawCount = value8;
	}
}
