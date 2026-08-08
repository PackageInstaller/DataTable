using System.Threading;

namespace common.HIERTimerWheel;

public interface ISpinLock
{
	SpinLock mSpinLock { get; set; }
}
