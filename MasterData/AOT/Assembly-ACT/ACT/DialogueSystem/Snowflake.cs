using System;
using System.Threading;

namespace ACT.DialogueSystem;

public class Snowflake
{
	public interface ITimeProvider
	{
		long GetCurrentTime();
	}

	public class UtcMSDateTimeProvider : ITimeProvider
	{
		private readonly long epoch;

		public UtcMSDateTimeProvider(int year, int month, int day)
		{
			epoch = new DateTime(year, month, day, 0, 0, 0, DateTimeKind.Utc).Ticks / 10000;
		}

		public long GetCurrentTime()
		{
			return DateTime.UtcNow.Ticks / 10000 - epoch;
		}
	}

	private const int WORKER_ID_BITS = 5;

	private const int DATACENTER_ID_BITS = 5;

	private const int SEQUENCE_BITS = 12;

	private const int WORKER_ID_SHIFT = 12;

	private const int DATACENTER_ID_SHIFT = 17;

	private const int TIMESTAMP_LEFT_SHIFT = 22;

	private const long SEQUENCE_MASK = 4095L;

	private const long MAX_WORKER_ID = 31L;

	private const long MAX_DATACENTER_ID = 31L;

	private long lastTimestamp;

	private long sequence;

	public static Snowflake BaseUTC2020 = new Snowflake(0, new UtcMSDateTimeProvider(2020, 1, 1));

	private long WorkerId { get; set; }

	private long DatacenterId { get; set; }

	private ITimeProvider TimeProvider { get; set; }

	private long LastTimestamp => lastTimestamp;

	private long Sequence => sequence;

	public Snowflake(byte workerId, byte dataCenterId, ITimeProvider timeProvider)
	{
		Init(workerId, dataCenterId, timeProvider);
	}

	public Snowflake(int workerId, ITimeProvider timeProvider)
	{
		Init((byte)(workerId & 0x1F), (byte)((workerId >> 5) & 0x1F), timeProvider);
	}

	private void Init(byte workerId, byte datacenterId, ITimeProvider timeProvider)
	{
		if ((long)workerId > 31L)
		{
			throw new ArgumentException($"worker Id can't be greater than {31L} or less than 0");
		}
		if ((long)datacenterId > 31L)
		{
			throw new ArgumentException($"datacenter Id can't be greater than {31L} or less than 0");
		}
		lastTimestamp = -1L;
		sequence = 0L;
		WorkerId = workerId;
		DatacenterId = datacenterId;
		TimeProvider = timeProvider;
	}

	private long TilNextTimestamp()
	{
		long currentTime;
		for (currentTime = TimeProvider.GetCurrentTime(); currentTime <= lastTimestamp; currentTime = TimeProvider.GetCurrentTime())
		{
			Thread.Sleep(1);
		}
		return currentTime;
	}

	public long NextId()
	{
		lock (this)
		{
			long num = TimeProvider.GetCurrentTime();
			if (num < lastTimestamp)
			{
				throw new Exception($"Clock moved backwards. Refusing to generate id for {lastTimestamp - num} ticks");
			}
			if (lastTimestamp == num)
			{
				sequence = (sequence + 1) & 0xFFF;
				if (sequence == 0L)
				{
					num = TilNextTimestamp();
				}
			}
			else
			{
				sequence = 0L;
			}
			lastTimestamp = num;
			return (num << 22) | (DatacenterId << 17) | (WorkerId << 12) | sequence;
		}
	}
}
