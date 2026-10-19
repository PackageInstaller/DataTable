using System;
using System.Threading;

namespace UnityEngine.Localization.Tables;

[Serializable]
public class DistributedUIDGenerator : IKeyGenerator
{
	private const int kMachineIdBits = 10;

	private const int kSequenceBits = 12;

	private static readonly int kMaxNodeId = (int)(Mathf.Pow(2f, 10f) - 1f);

	private static readonly int kMaxSequence = (int)(Mathf.Pow(2f, 12f) - 1f);

	public const string MachineIdPrefKey = "KeyGenerator-MachineId";

	[SerializeField]
	[HideInInspector]
	private long m_CustomEpoch = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();

	private long m_LastTimestamp = -1L;

	private long m_Sequence;

	private int m_MachineId;

	public long CustomEpoch => m_CustomEpoch;

	public int MachineId
	{
		get
		{
			if (m_MachineId == 0)
			{
				m_MachineId = GetMachineId();
			}
			return m_MachineId;
		}
		set
		{
			m_MachineId = Mathf.Clamp(value, 1, kMaxNodeId);
		}
	}

	public DistributedUIDGenerator()
	{
	}

	public DistributedUIDGenerator(long customEpoch)
	{
		m_CustomEpoch = customEpoch;
	}

	public long GetNextKey()
	{
		long num = TimeStamp();
		if (num == m_LastTimestamp)
		{
			m_Sequence = (m_Sequence + 1) & kMaxSequence;
			if (m_Sequence == 0L)
			{
				num = WaitNextMillis(num);
			}
		}
		else
		{
			m_Sequence = 0L;
		}
		m_LastTimestamp = num;
		return (num << 22) | (uint)(MachineId << 12) | m_Sequence;
	}

	private long TimeStamp()
	{
		return DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() - m_CustomEpoch;
	}

	private static int GetMachineId()
	{
		return Random.Range(0, kMaxNodeId);
	}

	private long WaitNextMillis(long currentTimestamp)
	{
		while (currentTimestamp == m_LastTimestamp)
		{
			Thread.Sleep(1);
			currentTimestamp = TimeStamp();
		}
		return currentTimestamp;
	}
}
