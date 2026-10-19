using System.Runtime.InteropServices;

namespace System.Buffers;

public unsafe struct MemoryHandle(void* pointer, GCHandle handle = default(GCHandle), IPinnable pinnable = null) : IDisposable
{
	private unsafe void* _pointer = pointer;

	private GCHandle _handle = handle;

	private IPinnable _pinnable = pinnable;

	[CLSCompliant(false)]
	public unsafe void* Pointer => _pointer;

	public unsafe void Dispose()
	{
		if (_handle.IsAllocated)
		{
			_handle.Free();
		}
		if (_pinnable != null)
		{
			_pinnable.Unpin();
			_pinnable = null;
		}
		_pointer = null;
	}
}
