using Internal.Runtime.Augments;

namespace System.Threading;

public struct SpinWait
{
	internal static readonly int SpinCountforSpinBeforeWait = (PlatformHelper.IsSingleProcessor ? 1 : 35);

	private int _count;

	public int Count => _count;

	public bool NextSpinWillYield
	{
		get
		{
			if (_count < 10)
			{
				return PlatformHelper.IsSingleProcessor;
			}
			return true;
		}
	}

	public void SpinOnce()
	{
		SpinOnceCore(20);
	}

	public void SpinOnce(int sleep1Threshold)
	{
		if (sleep1Threshold < -1)
		{
			throw new ArgumentOutOfRangeException("sleep1Threshold", sleep1Threshold, "Number must be either non-negative and less than or equal to Int32.MaxValue or -1.");
		}
		if (sleep1Threshold >= 0 && sleep1Threshold < 10)
		{
			sleep1Threshold = 10;
		}
		SpinOnceCore(sleep1Threshold);
	}

	private void SpinOnceCore(int sleep1Threshold)
	{
		if ((_count >= 10 && ((_count >= sleep1Threshold && sleep1Threshold >= 0) || (_count - 10) % 2 == 0)) || PlatformHelper.IsSingleProcessor)
		{
			if (_count >= sleep1Threshold && sleep1Threshold >= 0)
			{
				RuntimeThread.Sleep(1);
			}
			else if (((_count >= 10) ? ((_count - 10) / 2) : _count) % 5 == 4)
			{
				RuntimeThread.Sleep(0);
			}
			else
			{
				RuntimeThread.Yield();
			}
		}
		else
		{
			int num = RuntimeThread.OptimalMaxSpinWaitsPerSpinIteration;
			if (_count <= 30 && 1 << _count < num)
			{
				num = 1 << _count;
			}
			RuntimeThread.SpinWait(num);
		}
		_count = ((_count == int.MaxValue) ? 10 : (_count + 1));
	}

	public void Reset()
	{
		_count = 0;
	}
}
