using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[Obsolete("An alternate API is available: Emit the MarshalAs custom attribute instead.")]
[ComVisible(true)]
public sealed class UnmanagedMarshal
{
	private UnmanagedMarshal()
	{
	}
}
