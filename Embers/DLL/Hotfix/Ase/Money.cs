using GameFramework.Runtime;

namespace Ase;

public class Money : ViewModelBase
{
	public const int CashPayType = 99;

	public const string CashPayIcon = "";

	private int moneyId;

	private long count;

	private long maxCount = -1L;

	private long countLimitation = -1L;

	public int MoneyId
	{
		get
		{
			return moneyId;
		}
		private set
		{
			Set(ref moneyId, value, "MoneyId");
		}
	}

	public long Count
	{
		get
		{
			return count;
		}
		private set
		{
			Set(ref count, value, "Count");
		}
	}

	public long MaxCount
	{
		get
		{
			return maxCount;
		}
		private set
		{
			Set(ref maxCount, value, "MaxCount");
		}
	}

	public long CountLimitation
	{
		get
		{
			return countLimitation;
		}
		private set
		{
			Set(ref countLimitation, value, "CountLimitation");
		}
	}

	public Money()
	{
	}

	public Money(int moneyId, long count, long maxCount, long countLimitation)
	{
		this.moneyId = moneyId;
		this.count = count;
		this.maxCount = maxCount;
		this.countLimitation = countLimitation;
	}

	public void AddCount(long count)
	{
		Count += count;
	}

	public void SetCount(long count)
	{
		Count = count;
	}
}
