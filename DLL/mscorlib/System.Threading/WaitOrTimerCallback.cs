using System.Runtime.InteropServices;

namespace System.Threading;

[ComVisible(true)]
public delegate void WaitOrTimerCallback(object state, bool timedOut);
