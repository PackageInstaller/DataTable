using System.Buffers.Binary;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Net;

[Serializable]
public class IPAddress
{
	private sealed class ReadOnlyIPAddress : IPAddress
	{
		public ReadOnlyIPAddress(long newAddress)
			: base(newAddress)
		{
		}
	}

	public static readonly IPAddress Any = new ReadOnlyIPAddress(0L);

	public static readonly IPAddress Loopback = new ReadOnlyIPAddress(16777343L);

	public static readonly IPAddress Broadcast = new ReadOnlyIPAddress(4294967295L);

	public static readonly IPAddress None = Broadcast;

	internal const long LoopbackMask = 255L;

	public static readonly IPAddress IPv6Any = new IPAddress(new byte[16], 0L);

	public static readonly IPAddress IPv6Loopback = new IPAddress(new byte[16]
	{
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 1
	}, 0L);

	public static readonly IPAddress IPv6None = new IPAddress(new byte[16], 0L);

	private uint _addressOrScopeId;

	private readonly ushort[] _numbers;

	private string _toString;

	private int _hashCode;

	internal const int NumberOfLabels = 8;

	private bool IsIPv4 => _numbers == null;

	private bool IsIPv6 => _numbers != null;

	private uint PrivateAddress
	{
		get
		{
			return _addressOrScopeId;
		}
		set
		{
			_toString = null;
			_hashCode = 0;
			_addressOrScopeId = value;
		}
	}

	private uint PrivateScopeId
	{
		get
		{
			return _addressOrScopeId;
		}
		set
		{
			_toString = null;
			_hashCode = 0;
			_addressOrScopeId = value;
		}
	}

	public AddressFamily AddressFamily
	{
		get
		{
			if (!IsIPv4)
			{
				return AddressFamily.InterNetworkV6;
			}
			return AddressFamily.InterNetwork;
		}
	}

	public long ScopeId
	{
		get
		{
			if (IsIPv4)
			{
				throw new SocketException(SocketError.OperationNotSupported);
			}
			return PrivateScopeId;
		}
	}

	public IPAddress(long newAddress)
	{
		if (newAddress < 0 || newAddress > uint.MaxValue)
		{
			throw new ArgumentOutOfRangeException("newAddress");
		}
		PrivateAddress = (uint)newAddress;
	}

	public IPAddress(byte[] address, long scopeid)
		: this(new ReadOnlySpan<byte>(address ?? ThrowAddressNullException()), scopeid)
	{
	}

	public IPAddress(ReadOnlySpan<byte> address, long scopeid)
	{
		if (address.Length != 16)
		{
			throw new ArgumentException("An invalid IP address was specified.", "address");
		}
		if (scopeid < 0 || scopeid > uint.MaxValue)
		{
			throw new ArgumentOutOfRangeException("scopeid");
		}
		_numbers = new ushort[8];
		for (int i = 0; i < 8; i++)
		{
			_numbers[i] = (ushort)(address[i * 2] * 256 + address[i * 2 + 1]);
		}
		PrivateScopeId = (uint)scopeid;
	}

	internal unsafe IPAddress(ushort* numbers, int numbersLength, uint scopeid)
	{
		ushort[] array = new ushort[8];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = numbers[i];
		}
		_numbers = array;
		PrivateScopeId = scopeid;
	}

	private IPAddress(ushort[] numbers, uint scopeid)
	{
		_numbers = numbers;
		PrivateScopeId = scopeid;
	}

	public IPAddress(byte[] address)
		: this(new ReadOnlySpan<byte>(address ?? ThrowAddressNullException()))
	{
	}

	public IPAddress(ReadOnlySpan<byte> address)
	{
		if (address.Length == 4)
		{
			PrivateAddress = (uint)(((address[3] << 24) | (address[2] << 16) | (address[1] << 8) | address[0]) & 0xFFFFFFFFu);
			return;
		}
		if (address.Length == 16)
		{
			_numbers = new ushort[8];
			for (int i = 0; i < 8; i++)
			{
				_numbers[i] = (ushort)(address[i * 2] * 256 + address[i * 2 + 1]);
			}
			return;
		}
		throw new ArgumentException("An invalid IP address was specified.", "address");
	}

	public static bool TryParse(string ipString, out IPAddress address)
	{
		if (ipString == null)
		{
			address = null;
			return false;
		}
		address = IPAddressParser.Parse(ipString.AsSpan(), tryParse: true);
		return address != null;
	}

	public static IPAddress Parse(string ipString)
	{
		if (ipString == null)
		{
			throw new ArgumentNullException("ipString");
		}
		return IPAddressParser.Parse(ipString.AsSpan(), tryParse: false);
	}

	public bool TryWriteBytes(Span<byte> destination, out int bytesWritten)
	{
		if (IsIPv6)
		{
			if (destination.Length < 16)
			{
				bytesWritten = 0;
				return false;
			}
			WriteIPv6Bytes(destination);
			bytesWritten = 16;
		}
		else
		{
			if (destination.Length < 4)
			{
				bytesWritten = 0;
				return false;
			}
			WriteIPv4Bytes(destination);
			bytesWritten = 4;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private void WriteIPv6Bytes(Span<byte> destination)
	{
		int num = 0;
		for (int i = 0; i < 8; i++)
		{
			destination[num++] = (byte)((_numbers[i] >> 8) & 0xFF);
			destination[num++] = (byte)(_numbers[i] & 0xFF);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private void WriteIPv4Bytes(Span<byte> destination)
	{
		uint privateAddress = PrivateAddress;
		destination[0] = (byte)privateAddress;
		destination[1] = (byte)(privateAddress >> 8);
		destination[2] = (byte)(privateAddress >> 16);
		destination[3] = (byte)(privateAddress >> 24);
	}

	public byte[] GetAddressBytes()
	{
		if (IsIPv6)
		{
			byte[] array = new byte[16];
			WriteIPv6Bytes(array);
			return array;
		}
		byte[] array2 = new byte[4];
		WriteIPv4Bytes(array2);
		return array2;
	}

	public override string ToString()
	{
		if (_toString == null)
		{
			_toString = (IsIPv4 ? IPAddressParser.IPv4AddressToString(PrivateAddress) : IPAddressParser.IPv6AddressToString(_numbers, PrivateScopeId));
		}
		return _toString;
	}

	public static int HostToNetworkOrder(int host)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return host;
		}
		return BinaryPrimitives.ReverseEndianness(host);
	}

	public static short HostToNetworkOrder(short host)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return host;
		}
		return BinaryPrimitives.ReverseEndianness(host);
	}

	public static int NetworkToHostOrder(int network)
	{
		return HostToNetworkOrder(network);
	}

	public static short NetworkToHostOrder(short network)
	{
		return HostToNetworkOrder(network);
	}

	public static bool IsLoopback(IPAddress address)
	{
		if (address == null)
		{
			ThrowAddressNullException();
		}
		if (address.IsIPv6)
		{
			return address.Equals(IPv6Loopback);
		}
		return ((ulong)address.PrivateAddress & 0xFFuL) == ((ulong)Loopback.PrivateAddress & 0xFFuL);
	}

	internal bool Equals(object comparandObj, bool compareScopeId)
	{
		if (!(comparandObj is IPAddress iPAddress))
		{
			return false;
		}
		if (AddressFamily != iPAddress.AddressFamily)
		{
			return false;
		}
		if (IsIPv6)
		{
			for (int i = 0; i < 8; i++)
			{
				if (iPAddress._numbers[i] != _numbers[i])
				{
					return false;
				}
			}
			if (iPAddress.PrivateScopeId != PrivateScopeId)
			{
				return !compareScopeId;
			}
			return true;
		}
		return iPAddress.PrivateAddress == PrivateAddress;
	}

	public override bool Equals(object comparand)
	{
		return Equals(comparand, compareScopeId: true);
	}

	public override int GetHashCode()
	{
		if (_hashCode != 0)
		{
			return _hashCode;
		}
		int hashCode;
		if (IsIPv6)
		{
			Span<byte> span = stackalloc byte[20];
			MemoryMarshal.AsBytes(new ReadOnlySpan<ushort>(_numbers)).CopyTo(span);
			BitConverter.TryWriteBytes(span.Slice(16), _addressOrScopeId);
			hashCode = Marvin.ComputeHash32(span, Marvin.DefaultSeed);
		}
		else
		{
			hashCode = Marvin.ComputeHash32(MemoryMarshal.AsBytes(MemoryMarshal.CreateReadOnlySpan(ref _addressOrScopeId, 1)), Marvin.DefaultSeed);
		}
		_hashCode = hashCode;
		return _hashCode;
	}

	public IPAddress MapToIPv6()
	{
		if (IsIPv6)
		{
			return this;
		}
		uint privateAddress = PrivateAddress;
		return new IPAddress(new ushort[8]
		{
			0,
			0,
			0,
			0,
			0,
			65535,
			(ushort)(((privateAddress & 0xFF00) >> 8) | ((privateAddress & 0xFF) << 8)),
			(ushort)(((privateAddress & 0xFF000000u) >> 24) | ((privateAddress & 0xFF0000) >> 8))
		}, 0u);
	}

	private static byte[] ThrowAddressNullException()
	{
		throw new ArgumentNullException("address");
	}
}
