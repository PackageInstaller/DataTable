namespace System.Reflection;

public enum MethodImplAttributes
{
	CodeTypeMask = 3,
	IL = 0,
	Native = 1,
	OPTIL = 2,
	Runtime = CodeTypeMask,
	ManagedMask = 4,
	Unmanaged = ManagedMask,
	Managed = IL,
	ForwardRef = 16,
	PreserveSig = 128,
	InternalCall = 4096,
	Synchronized = 32,
	NoInlining = 8,
	AggressiveInlining = 256,
	NoOptimization = 64,
	MaxMethodImplVal = 65535,
	SecurityMitigations = 1024
}
