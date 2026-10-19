using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Lifetime;

[ComVisible(true)]
public interface ILease
{
	TimeSpan CurrentLeaseTime { get; }

	LeaseState CurrentState { get; }

	TimeSpan RenewOnCallTime { get; }

	TimeSpan Renew(TimeSpan renewalTime);
}
