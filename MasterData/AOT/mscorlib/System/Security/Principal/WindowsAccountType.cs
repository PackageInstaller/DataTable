using System.Runtime.InteropServices;

namespace System.Security.Principal;

[Serializable]
[ComVisible(true)]
public enum WindowsAccountType
{
	Normal,
	Guest,
	System,
	Anonymous
}
