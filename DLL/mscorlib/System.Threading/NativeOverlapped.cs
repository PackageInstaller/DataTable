namespace System.Threading;

public struct NativeOverlapped
{
	public IntPtr InternalLow;

	public IntPtr InternalHigh;

	public int OffsetLow;

	public int OffsetHigh;

	public IntPtr EventHandle;
}
