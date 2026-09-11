using System.Runtime.InteropServices;

namespace System.Runtime.Serialization;

[Serializable]
[ComVisible(true)]
[Flags]
public enum StreamingContextStates
{
	CrossProcess = 1,
	CrossMachine = 2,
	File = 4,
	Persistence = 8,
	Remoting = 0x10,
	Other = 0x20,
	Clone = 0x40,
	CrossAppDomain = 0x80,
	All = CrossProcess | CrossMachine | File | Persistence | Remoting | Other | Clone | CrossAppDomain
}
