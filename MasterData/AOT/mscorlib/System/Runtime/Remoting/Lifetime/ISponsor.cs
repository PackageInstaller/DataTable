using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Lifetime;

[ComVisible(true)]
public interface ISponsor
{
	TimeSpan Renewal(ILease lease);
}
