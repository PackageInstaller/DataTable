namespace System.Runtime.InteropServices;

public readonly struct OSPlatform : IEquatable<OSPlatform>
{
	private readonly string _osPlatform;

	public static OSPlatform Linux { get; } = new OSPlatform("LINUX");

	public static OSPlatform OSX { get; } = new OSPlatform("OSX");

	public static OSPlatform Windows { get; } = new OSPlatform("WINDOWS");

	private OSPlatform(string osPlatform)
	{
		if (osPlatform == null)
		{
			throw new ArgumentNullException("osPlatform");
		}
		if (osPlatform.Length == 0)
		{
			throw new ArgumentException("Value cannot be empty.", "osPlatform");
		}
		_osPlatform = osPlatform;
	}

	public static OSPlatform Create(string osPlatform)
	{
		return new OSPlatform(osPlatform);
	}

	public bool Equals(OSPlatform other)
	{
		return Equals(other._osPlatform);
	}

	internal bool Equals(string other)
	{
		return string.Equals(_osPlatform, other, StringComparison.Ordinal);
	}

	public override bool Equals(object obj)
	{
		if (obj is OSPlatform)
		{
			return Equals((OSPlatform)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (_osPlatform != null)
		{
			return _osPlatform.GetHashCode();
		}
		return 0;
	}

	public override string ToString()
	{
		return _osPlatform ?? string.Empty;
	}

	public static bool operator ==(OSPlatform left, OSPlatform right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(OSPlatform left, OSPlatform right)
	{
		return !(left == right);
	}
}
