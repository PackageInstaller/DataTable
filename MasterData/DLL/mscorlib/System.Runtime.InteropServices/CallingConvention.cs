namespace System.Runtime.InteropServices;

[Serializable]
[ComVisible(true)]
public enum CallingConvention
{
	Winapi = 1,
	Cdecl,
	StdCall,
	ThisCall,
	FastCall
}
