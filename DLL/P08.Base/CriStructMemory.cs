using System;
using System.Runtime.InteropServices;

public class CriStructMemory<Type> : IDisposable
{
	private GCHandle gch;

	public byte[] bytes { get; private set; }

	public IntPtr ptr => gch.AddrOfPinnedObject();

	public CriStructMemory()
	{
		bytes = new byte[Marshal.SizeOf(typeof(Type))];
		gch = GCHandle.Alloc(bytes, GCHandleType.Pinned);
	}

	public CriStructMemory(int num)
	{
		bytes = new byte[Marshal.SizeOf(typeof(Type)) * num];
		gch = GCHandle.Alloc(bytes, GCHandleType.Pinned);
	}

	public void Dispose()
	{
		gch.Free();
	}
}
