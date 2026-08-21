using System.Globalization;
using System.Net.Sockets;
using System.Text;

namespace System.Net;

public class SocketAddress
{
	internal int m_Size;

	internal byte[] m_Buffer;

	private bool m_changed = true;

	private int m_hash;

	public AddressFamily Family => (AddressFamily)(m_Buffer[0] | (m_Buffer[1] << 8));

	public int Size => m_Size;

	public byte this[int offset]
	{
		get
		{
			if (offset < 0 || offset >= Size)
			{
				throw new IndexOutOfRangeException();
			}
			return m_Buffer[offset];
		}
	}

	public SocketAddress(AddressFamily family, int size)
	{
		if (size < 2)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		m_Size = size;
		m_Buffer = new byte[(size / IntPtr.Size + 2) * IntPtr.Size];
		m_Buffer[0] = (byte)family;
		m_Buffer[1] = (byte)((int)family >> 8);
	}

	internal SocketAddress(IPAddress ipAddress)
		: this(ipAddress.AddressFamily, (ipAddress.AddressFamily == AddressFamily.InterNetwork) ? 16 : 28)
	{
		m_Buffer[2] = 0;
		m_Buffer[3] = 0;
		if (ipAddress.AddressFamily == AddressFamily.InterNetworkV6)
		{
			m_Buffer[4] = 0;
			m_Buffer[5] = 0;
			m_Buffer[6] = 0;
			m_Buffer[7] = 0;
			long scopeId = ipAddress.ScopeId;
			m_Buffer[24] = (byte)scopeId;
			m_Buffer[25] = (byte)(scopeId >> 8);
			m_Buffer[26] = (byte)(scopeId >> 16);
			m_Buffer[27] = (byte)(scopeId >> 24);
			byte[] addressBytes = ipAddress.GetAddressBytes();
			for (int i = 0; i < addressBytes.Length; i++)
			{
				m_Buffer[8 + i] = addressBytes[i];
			}
		}
		else
		{
			ipAddress.TryWriteBytes(MemoryExtensions.AsSpan(m_Buffer, 4), out var _);
		}
	}

	internal SocketAddress(IPAddress ipaddress, int port)
		: this(ipaddress)
	{
		m_Buffer[2] = (byte)(port >> 8);
		m_Buffer[3] = (byte)port;
	}

	internal IPAddress GetIPAddress()
	{
		if (Family == AddressFamily.InterNetworkV6)
		{
			byte[] array = new byte[16];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = m_Buffer[i + 8];
			}
			long scopeid = (m_Buffer[27] << 24) + (m_Buffer[26] << 16) + (m_Buffer[25] << 8) + m_Buffer[24];
			return new IPAddress(array, scopeid);
		}
		if (Family == AddressFamily.InterNetwork)
		{
			return new IPAddress(((m_Buffer[4] & 0xFF) | ((m_Buffer[5] << 8) & 0xFF00) | ((m_Buffer[6] << 16) & 0xFF0000) | (m_Buffer[7] << 24)) & 0xFFFFFFFFu);
		}
		throw new SocketException(SocketError.AddressFamilyNotSupported);
	}

	internal IPEndPoint GetIPEndPoint()
	{
		IPAddress iPAddress = GetIPAddress();
		int port = ((m_Buffer[2] << 8) & 0xFF00) | m_Buffer[3];
		return new IPEndPoint(iPAddress, port);
	}

	public override bool Equals(object comparand)
	{
		if (!(comparand is SocketAddress socketAddress) || Size != socketAddress.Size)
		{
			return false;
		}
		for (int i = 0; i < Size; i++)
		{
			if (this[i] != socketAddress[i])
			{
				return false;
			}
		}
		return true;
	}

	public override int GetHashCode()
	{
		if (m_changed)
		{
			m_changed = false;
			m_hash = 0;
			int num = Size & -4;
			int i;
			for (i = 0; i < num; i += 4)
			{
				m_hash ^= m_Buffer[i] | (m_Buffer[i + 1] << 8) | (m_Buffer[i + 2] << 16) | (m_Buffer[i + 3] << 24);
			}
			if ((Size & 3) != 0)
			{
				int num2 = 0;
				int num3 = 0;
				for (; i < Size; i++)
				{
					num2 |= m_Buffer[i] << num3;
					num3 += 8;
				}
				m_hash ^= num2;
			}
		}
		return m_hash;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 2; i < Size; i++)
		{
			if (i > 2)
			{
				stringBuilder.Append(",");
			}
			stringBuilder.Append(this[i].ToString(NumberFormatInfo.InvariantInfo));
		}
		return Family.ToString() + ":" + Size.ToString(NumberFormatInfo.InvariantInfo) + ":{" + stringBuilder.ToString() + "}";
	}
}
