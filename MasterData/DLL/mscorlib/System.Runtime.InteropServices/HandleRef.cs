namespace System.Runtime.InteropServices;

public readonly struct HandleRef(object wrapper, IntPtr handle)
{
	private readonly object _wrapper = wrapper;

	private readonly IntPtr _handle = handle;

	public IntPtr Handle => _handle;
}
