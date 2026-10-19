using System;
using System.IO;
using System.Net.Sockets;

namespace Telepathy;

public static class NetworkStreamExtensions
{
	public static int ReadSafely(this NetworkStream stream, byte[] buffer, int offset, int size)
	{
		try
		{
			return stream.Read(buffer, offset, size);
		}
		catch (IOException)
		{
			return 0;
		}
		catch (ObjectDisposedException)
		{
			return 0;
		}
	}

	public static bool ReadExactly(this NetworkStream stream, byte[] buffer, int amount)
	{
		int num;
		for (int i = 0; i < amount; i += num)
		{
			int size = amount - i;
			num = stream.ReadSafely(buffer, i, size);
			if (num == 0)
			{
				return false;
			}
		}
		return true;
	}
}
