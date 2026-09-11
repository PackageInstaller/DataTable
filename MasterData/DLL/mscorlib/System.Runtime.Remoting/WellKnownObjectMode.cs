using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[Serializable]
[ComVisible(true)]
public enum WellKnownObjectMode
{
	Singleton = 1,
	SingleCall
}
