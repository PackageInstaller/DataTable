using System;
using System.IO;
using System.Runtime.InteropServices;

namespace LuaInterface;

public struct LuaByteBuffer
{
	public byte[] buffer;

	public int Length { get; private set; }

	public LuaByteBuffer(IntPtr source, int len)
	{
		this = default(LuaByteBuffer);
		buffer = new byte[len];
		Length = len;
		Marshal.Copy(source, buffer, 0, len);
	}

	public LuaByteBuffer(byte[] buf)
	{
		this = default(LuaByteBuffer);
		buffer = buf;
		Length = buf.Length;
	}

	public LuaByteBuffer(byte[] buf, int len)
	{
		this = default(LuaByteBuffer);
		buffer = buf;
		Length = len;
	}

	public LuaByteBuffer(MemoryStream stream)
	{
		this = default(LuaByteBuffer);
		buffer = stream.GetBuffer();
		Length = (int)stream.Length;
	}

	public static implicit operator LuaByteBuffer(MemoryStream stream)
	{
		return new LuaByteBuffer(stream);
	}
}
