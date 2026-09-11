using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Lifetime;

[Serializable]
[ComVisible(true)]
public enum LeaseState
{
	Null,
	Initial,
	Active,
	Renewing,
	Expired
}
